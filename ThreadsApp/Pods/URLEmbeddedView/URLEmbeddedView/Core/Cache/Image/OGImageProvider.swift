//
//  OGImageProvider.swift
//  URLEmbeddedView
//
//  Created by Taiki Suzuki on 2016/03/07.
//
//

import Foundation

/// Use for test
protocol OGImageProviderProtocol: class {
    func loadImage(urlString: String, completion: ((Result<UIImage>) -> Void)?) -> Task?
    func clearMemoryCache()
    func clearAllCache()
    func cancelLoading(_ task: Task, shouldContinueDownloading: Bool)
}

/// Provides Image from cache or API
@objc public final class OGImageProvider: NSObject, OGImageProviderProtocol {

    //MARK: - Static constants
    @objc(sharedInstance)
    public static let shared = OGImageProvider()
    
    //MARK: - Properties
    private let session: OGSessionProtocol
    private let cacheManager: OGImageCacheManagerProtocol
    private let queue = DispatchQueue(label: "com.OGImageProvider.URLEmbeddedView", attributes: .concurrent)
    
    init(cacheManager: OGImageCacheManagerProtocol = OGImageCacheManager(),
         session: OGSessionProtocol = OGSession(configuration: .default)) {
        self.cacheManager = cacheManager
        self.session = session
        super.init()
    }

    @objc public func loadImage(withURLString urlString: String, completion: ((UIImage?, Error?) -> Void)? = nil) -> Task? {
        return loadImage(urlString: urlString) { completion?($0.value, $0.error) }
    }
    
    @nonobjc public func loadImage(urlString: String, completion: ((Result<UIImage>) -> Void)? = nil) -> Task? {
        guard let url = URL(string: urlString) else {
            completion?(.failure(URLEmbeddedViewError.invalidURLString(urlString)))
            return nil
        }

        let task = Task()

        queue.async { [weak self] in
            if !urlString.isEmpty {
                if let image = self?.cacheManager.cachedImage(urlString: urlString) {
                    completion?(.success(image))
                    return
                }
            }
            let request = ImageRequest(url: url)
            _ = self?.session.send(request, task: .init(), success: { value, isExpired in
                self?.cacheManager.storeImage(value.1, data: value.0, urlString: urlString)
                if !isExpired { completion?(.success(value.1)) }
            }, failure: { error, isExpired in
                if !isExpired { completion?(.failure(error)) }
            })
        }

        return task
    }
    
    @objc public func clearMemoryCache() {
        queue.async { [weak self] in
            self?.cacheManager.clearMemoryCache()
        }
    }
    
    @objc public func clearAllCache() {
        queue.async { [weak self] in
            self?.cacheManager.clearAllCache()
        }
    }
    
    @objc public func cancelLoading(_ task: Task, shouldContinueDownloading: Bool) {
        task.expire(shouldContinueDownloading: shouldContinueDownloading)
    }
}
