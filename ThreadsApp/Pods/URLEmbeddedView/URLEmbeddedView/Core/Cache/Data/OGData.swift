//
//  OGData.swift
//  URLEmbeddedView
//
//  Created by Taiki Suzuki on 2016/03/11.
//
//

import Foundation
import CoreData

final class OGData: NSManagedObject {

    func update(with cache: OGCacheData) -> Bool {
        let ogData = cache.ogData

        var changed: Bool = false
        if let newValue = ogData.imageUrl?.absoluteString, newValue != imageUrl {
            self.imageUrl = newValue
            changed = true
        }
        if let newValue = ogData.pageDescription, newValue != pageDescription {
            self.pageDescription = newValue
            changed = true
        }
        if let newValue = ogData.pageTitle, newValue != pageTitle {
            self.pageTitle = newValue
            changed = true
        }
        if let newValue = ogData.pageType, newValue != pageType {
            self.pageType = newValue
            changed = true
        }
        if let newValue = ogData.siteName, newValue != siteName {
            self.siteName = newValue
            changed = true
        }
        if let newValue = ogData.sourceUrl?.absoluteString, newValue != sourceUrl {
            self.sourceUrl = newValue
            changed = true
        }
        if let newValue = ogData.url?.absoluteString, newValue != url {
            self.url = newValue
            changed = true
        }
        if let newValue = cache.updateDate, newValue != updateDate {
            self.updateDate = newValue
            changed = true
        }
        return changed
    }
}
