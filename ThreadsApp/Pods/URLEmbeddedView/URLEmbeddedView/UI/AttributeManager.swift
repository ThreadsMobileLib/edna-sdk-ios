//
//  AttributeManager.swift
//  URLEmbeddedView
//
//  Created by Taiki Suzuki on 2016/03/08.
//
//

import Foundation

public final class AttributeManager {
    public enum Style {
        case title, description, domain, noDataTitle
        
        var font: UIFont {
            switch self {
            case .title       : return .boldSystemFont(ofSize: 16)
            case .description : return .systemFont(ofSize: 14)
            case .domain      : return .systemFont(ofSize: 10)
            case .noDataTitle : return .systemFont(ofSize: 16)
            }
        }
        
        var numberOfLines: Int {
            switch self {
            case .title, .noDataTitle : return 2
            case .description         : return 1
            case .domain              : return 1
            }
        }
        
        var fontColor: UIColor {
            switch self {
            case .description, .domain, .noDataTitle, .title:
                return .black
            }
        }
    }
    
    enum Attribute {
        case font, numberOfLines,fontColor
    }
    
    var didChangeValue: ((Style, Attribute, Any) -> Void)?
    private let style: Style
    
    @objc public var font: UIFont {
        didSet { didChangeValue?(style, .font, font) }
    }
    
    @objc public var numberOfLines: Int {
        didSet { didChangeValue?(style, .numberOfLines, numberOfLines) }
    }
    
    @objc public var fontColor: UIColor {
        didSet { didChangeValue?(style, .fontColor, fontColor) }
    }
    
    init(style: Style) {
        self.style = style
        self.font = style.font
        self.numberOfLines = style.numberOfLines
        self.fontColor = style.fontColor
    }
    
    func attributedText(_ string: String) -> NSAttributedString {
        let attributes: [NSAttributedStringKey : Any] = [
            .font : font,
            .foregroundColor : fontColor
        ]
        return NSAttributedString(string: string, attributes: attributes)
    }
}
