//
//  File.swift
//  URLEmbeddedView
//
//  Created by marty-suzuki on 2017/10/08.
//

import Foundation

public enum URLEmbeddedViewError: Error {
    case invalidURLString(String)
}

public enum Result<T> {
    case success(T)
    case failure(Error)
    
    public var value: T? {
        if case .success(let value) = self { return value }
        return nil
    }
    
    public var error: Error? {
        if case .failure(let error) = self { return error }
        return nil
    }
}

@objc public final class Task: NSObject {
    private var task: URLSessionTask?
    private(set) var isExpired: Bool
    let uuidString: String
    
    override init() {
        self.task = nil
        self.isExpired = false
        self.uuidString = UUID().uuidString
        super.init()
    }
    
    fileprivate func setTask(_ task: URLSessionTask) {
        self.task = task
    }
    
    func expire(shouldContinueDownloading: Bool) {
        isExpired = true
        if !shouldContinueDownloading {
            task?.cancel()
        }
    }
}

/// Use for Test
protocol OGSessionProtocol: class {
    func send<T: OGRequest>(_ request: T, task: Task, success: @escaping (T.Response, Bool) -> Void, failure: @escaping (OGSession.Error, Bool) -> Void) -> Task
}

final class OGSession: OGSessionProtocol {
    enum Error: Swift.Error {
        case noData
        case castFaild
        case jsonDecodeFaild
        case htmlDecodeFaild
        case imageGenerateFaild
        case other(Swift.Error)
    }
    
    private let session: URLSession
    private var taskCollection: [String : Task] = [:]
    private let lock = Lock()
    
    init(configuration: URLSessionConfiguration = .default) {
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 60
        self.session = URLSession(configuration: configuration)
    }
    
    @discardableResult
    func send<T: OGRequest>(_ request: T, task: Task = .init(), success: @escaping (T.Response, Bool) -> Void, failure: @escaping (OGSession.Error, Bool) -> Void) -> Task {
        let uuidString = task.uuidString
        let dataTask = session.dataTask(with: request.urlRequest) { [weak self, uuidString] data, response, error in
            guard let me = self else {
                return
            }

            me.lock.lock()
            let isExpired = me.taskCollection[uuidString]?.isExpired ?? false
            me.taskCollection.removeValue(forKey: uuidString)
            me.lock.unlock()

            if let error = error {
                failure((error as? Error) ?? .other(error), isExpired)
                return
            }
            guard let data = data else {
                failure(.noData, isExpired)
                return
            }
            do {
                let response = try T.response(data: data)
                success(response, isExpired)
            } catch let e as Error {
                failure(e, isExpired)
            } catch let e {
                failure(.other(e), isExpired)
            }
        }
        task.setTask(dataTask)

        lock.synchronized {
            taskCollection[uuidString] = task
        }
        
        dataTask.resume()
        return task
    }
}
