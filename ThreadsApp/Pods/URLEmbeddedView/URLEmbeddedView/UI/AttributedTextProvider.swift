//
//  AttributedTextProvider.swift
//  URLEmbeddedView
//
//  Created by Taiki Suzuki on 2016/03/07.
//
//

import Foundation

public final class AttributedTextProvider: NSObject {
    @objc(sharedInstance)
    static let shared = AttributedTextProvider()
    
    private let titleAttributeManager       = AttributeManager(style: .title)
    private let domainAttributeManager      = AttributeManager(style: .domain)
    private let descriptionAttributeManager = AttributeManager(style: .description)
    private let noDataTitleAttributeManager = AttributeManager(style: .noDataTitle)
    
    var didChangeValue: ((AttributeManager.Style, AttributeManager.Attribute, Any) -> Void)?
    
    private override init() {
        super.init()
        self[.title].didChangeValue       = { [weak self] in self?.didChangeValue?($0, $1, $2) }
        self[.domain].didChangeValue      = { [weak self] in self?.didChangeValue?($0, $1, $2) }
        self[.description].didChangeValue = { [weak self] in self?.didChangeValue?($0, $1, $2) }
        self[.noDataTitle].didChangeValue = { [weak self] in self?.didChangeValue?($0, $1, $2) }
    }
    
    public subscript(style: AttributeManager.Style) -> AttributeManager {
        switch style {
        case .title       : return titleAttributeManager
        case .domain      : return domainAttributeManager
        case .description : return descriptionAttributeManager
        case .noDataTitle : return noDataTitleAttributeManager
        }
    }
    
    func didChangeValue(_ closure: ((AttributeManager.Style, AttributeManager.Attribute, Any) -> Void)?) {
        self[.title].didChangeValue       = { closure?($0, $1, $2) }
        self[.domain].didChangeValue      = { closure?($0, $1, $2) }
        self[.description].didChangeValue = { closure?($0, $1, $2) }
        self[.noDataTitle].didChangeValue = { closure?($0, $1, $2) }
    }
}

