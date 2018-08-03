//
//  OpenGraphDataDownloader.swift
//  URLEmbeddedView
//
//  Created by marty-suzuki on 2018/07/14.
//  Copyright © 2018年 marty-suzuki. All rights reserved.
//

import Foundation

/// Use for Test
protocol OpenGraphDataDownloaderProtocol: class {
    func fetchOGData(urlString: String, completion: ((OpenGraphDataDownloader.Result) -> Void)?) -> Task
    func fetchOGData(urlString: String, task: Task, completion: ((OpenGraphDataDownloader.Result) -> Void)?) -> Task
    func cancelLoading(_ task: Task, shouldContinueDownloading: Bool)
}

/// OGP object downloader
@objc public final class OpenGraphDataDownloader: NSObject, OpenGraphDataDownloaderProtocol {

    @objc(sharedInstance)
    public static let shared = OpenGraphDataDownloader()

    private let session: OGSessionProtocol

    init(session: OGSessionProtocol = OGSession(configuration: .default)) {
        self.session = session
        super.init()
    }

    @discardableResult
    @objc public func fetchOGData(withURLString urlString: String, completion: ((OpenGraphData?, Swift.Error?) -> Void)? = nil) -> Task {
        return fetchOGData(urlString: urlString) { completion?($0.data as OpenGraphData?, $0.error) }
    }

    @discardableResult
    @nonobjc public func fetchOGData(urlString: String, completion: ((Result) -> Void)? = nil) -> Task {
        return fetchOGData(urlString: urlString, task: .init(), completion: completion)
    }

    @discardableResult
    func fetchOGData(urlString: String, task: Task, completion: ((Result) -> Void)? = nil) -> Task {
        guard let url = URL(string: urlString) else {
            completion?(.failure(error: Error.createURLFailed(urlString), isExpired: false))
            return task
        }

        let failure: (OGSession.Error, Bool) -> Void = { error, isExpired in
            completion?(.failure(error: error, isExpired: isExpired))
        }
        if url.host?.contains("youtube.com") == true {
            guard let request = YoutubeEmbedRequest(url: url) else {
                completion?(.failure(error: Error.createYoutubeRequestFailed(urlString), isExpired: false))
                return task
            }
            return session.send(request, task: task, success: { youtube, isExpired in
                let data = OpenGraph.Data(youtube: youtube, sourceUrl: url.absoluteString)
                completion?(.success(data: data, isExpired: isExpired))
            }, failure: failure)
        } else {
            let request = HtmlRequest(url: url)
            return session.send(request, task: task, success: { html, isExpired in
                let data = OpenGraph.Data(html: html, sourceUrl: url.absoluteString)
                completion?(.success(data: data, isExpired: isExpired))
            }, failure: failure)
        }
    }

    @objc public func cancelLoading(_ task: Task, shouldContinueDownloading: Bool) {
        task.expire(shouldContinueDownloading: shouldContinueDownloading)
    }
}

extension OpenGraphDataDownloader {
    /// Represents error
    public enum Error: Swift.Error {
        case createURLFailed(String)
        case createYoutubeRequestFailed(String)
    }

    /// Represents download result
    public enum Result {
        case success(data: OpenGraph.Data, isExpired: Bool)
        case failure(error: Swift.Error, isExpired: Bool)
    }
}

extension OpenGraphDataDownloader.Result {
    public var isExpired: Bool {
        switch self {
        case .failure(_, let isExpired): return isExpired
        case .success(_, let isExpired): return isExpired
        }
    }

    public var data: OpenGraph.Data? {
        if case .success(let data, _) = self {
            return data
        }
        return nil
    }

    public var error: Swift.Error? {
        if case .failure(let error, _) = self {
            return error
        }
        return nil
    }
}
