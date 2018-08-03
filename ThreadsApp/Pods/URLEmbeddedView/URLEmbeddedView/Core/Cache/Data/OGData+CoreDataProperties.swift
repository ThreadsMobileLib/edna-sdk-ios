//
//  OGData+CoreDataProperties.swift
//  URLEmbeddedView
//
//  Created by Taiki Suzuki on 2016/03/12.
//
//

import Foundation
import CoreData

extension OGData {

    @NSManaged var createDate: Date
    @NSManaged var imageUrl: String
    @NSManaged var pageDescription: String
    @NSManaged var pageTitle: String
    @NSManaged var pageType: String
    @NSManaged var siteName: String
    @NSManaged var sourceUrl: String
    @NSManaged var updateDate: Date
    @NSManaged var url: String

}
