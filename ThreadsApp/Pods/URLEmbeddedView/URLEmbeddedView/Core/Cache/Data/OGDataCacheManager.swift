//
//  OGDataCacheManager.swift
//  URLEmbeddedView
//
//  Created by Taiki Suzuki on 2016/03/11.
//
//

import Foundation
import CoreData

final class OGDataCacheManager: NSObject {
    
    private struct CacheKey {
        static let timeOfExpirationForOGData = "TimeOfExpirationForOGDataCache"
    }
    
    private(set) lazy var applicationDocumentsDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
    private(set) lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle(for: type(of: self)).url(forResource: "URLEmbeddedViewOGData", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    private(set) lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("URLEmbeddedViewOGData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        let options = [NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true]
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
        } catch {
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "URLEmbeddedView-OGDataCache Error", code: 9999, userInfo: dict)
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        return coordinator
    }()
    
    private(set) lazy var writerManagedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    private(set) lazy var mainManagedObjectContext: NSManagedObjectContext = {
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.parent = self.writerManagedObjectContext
        return managedObjectContext
    }()
    
    private(set) lazy var updateManagedObjectContext: NSManagedObjectContext = {
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        managedObjectContext.parent = self.mainManagedObjectContext
        return managedObjectContext
    }()
    
//    var timeOfExpiration: NSTimeInterval {
//        get {
//            let ud = NSUserDefaults.standardUserDefaults()
//            return ud.doubleForKey(CacheKey.timeOfExpirationForOGData)
//        }
//        set {
//            let ud = NSUserDefaults.standardUserDefaults()
//            ud.setDouble(newValue, forKey: CacheKey.timeOfExpirationForOGData)
//            ud.synchronize()
//        }
//    }
    
    var updateInterval: TimeInterval = {
        let ud = UserDefaults.standard
        guard let updateInterval = ud.updateIntervalForOGData else {
            let interval = 10.days
            ud.updateIntervalForOGData = interval
            return interval
        }
        return updateInterval
    }() {
        didSet { UserDefaults.standard.updateIntervalForOGData = updateInterval }
    }
    
    override init() {
        super.init()
    }

    private func fetchOGData(url: String, completion: @escaping (OGData?) -> ()) {
        updateManagedObjectContext.perform { [managedObjectContext = updateManagedObjectContext] in
            let fetchRequest = NSFetchRequest<OGData>()
            fetchRequest.entity = NSEntityDescription.entity(forEntityName: "OGData", in: managedObjectContext)
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "sourceUrl = %@", url)
            let fetchedList = (try? managedObjectContext.fetch(fetchRequest))
            completion(fetchedList?.first)
        }
    }
    
    private func saveContext (_ completion: ((Error?) -> Void)?) {
        saveContext(updateManagedObjectContext, success: { [weak self] in
            guard let mainManagedObjectContext = self?.mainManagedObjectContext else {
                completion?(NSError(domain: "mainManagedObjectContext is not avairable", code: 9999, userInfo: nil))
                return
            }
            self?.saveContext(mainManagedObjectContext, success: { [weak self] in
                guard let writerManagedObjectContext = self?.writerManagedObjectContext else {
                    completion?(NSError(domain: "writerManagedObjectContext is not avairable", code: 9999, userInfo: nil))
                    return
                }
                self?.saveContext(writerManagedObjectContext, success: {
                    completion?(nil)
                }, failure: { [weak self] in
                    self?.mainManagedObjectContext.rollback()
                    self?.updateManagedObjectContext.rollback()
                    completion?($0)
                })
            }, failure: { [weak self] in
                self?.updateManagedObjectContext.rollback()
                completion?($0)
            })
        }, failure: {
            completion?($0)
        })
    }
    
    private func saveContext(_ context: NSManagedObjectContext, success: (() -> Void)?, failure: ((Error) -> Void)?) {
        context.perform {
            if !context.hasChanges {
                success?()
            }
            do {
                try context.save()
                success?()
            } catch {
                context.rollback()
                failure?(error)
            }
        }
    }
}

extension OGDataCacheManager: OGDataCacheManagerProtocol {
    func fetchOrInsertOGCacheData(url: String, completion: @escaping (OGCacheData) -> ()) {
        fetchOGCacheData(url: url) { [managedObjectContext = updateManagedObjectContext] cache in
            if let cache = cache {
                completion(cache)
            } else {
                let ogData = NSEntityDescription.insertNewObject(forEntityName: "OGData", into: managedObjectContext) as! OGData
                ogData.sourceUrl = url
                ogData.createDate = Date()
                ogData.updateDate = Date(timeIntervalSince1970: 0)
                let newCache = OGCacheData(ogData: OpenGraph.Data(ogData: ogData),
                                           createDate: ogData.createDate,
                                           updateDate: nil)
                completion(newCache)
            }
        }
    }

    func fetchOGCacheData(url: String, completion: @escaping (OGCacheData?) -> ()) {
        fetchOGData(url: url) { ogData in
            let cache: OGCacheData? = ogData.map {
                let updateDate: Date?
                if $0.updateDate == Date(timeIntervalSince1970: 0) {
                    updateDate = nil
                } else {
                    updateDate = $0.updateDate
                }
                return OGCacheData(ogData: OpenGraph.Data(ogData: $0),
                                   createDate: $0.createDate,
                                   updateDate: updateDate)
            }
            completion(cache)
        }
    }

    func updateIfNeeded(cache: OGCacheData) {
        guard let sourceUrl = cache.ogData.sourceUrl else {
            return
        }
        fetchOGData(url: sourceUrl.absoluteString) { [weak self] ogData in
            guard let ogData = ogData else {
                return
            }
            guard let me = self else {
                return
            }
            if ogData.update(with: cache) {
                ogData.updateDate = Date()
                me.saveContext(nil)
            }
        }
    }

    func deleteOGCacheDate(cache: OGCacheData, completion: ((Error?) -> Void)?) {
        guard let sourceUrl = cache.ogData.sourceUrl else {
            return
        }
        fetchOGData(url: sourceUrl.absoluteString) { [weak self] ogData in
            guard let ogData = ogData else {
                return
            }
            guard let me = self else {
                return
            }
            ogData.managedObjectContext?.delete(ogData)
            me.saveContext(completion)
        }
    }
}
