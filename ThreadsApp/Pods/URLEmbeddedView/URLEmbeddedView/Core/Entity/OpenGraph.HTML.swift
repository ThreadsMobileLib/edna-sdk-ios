//
//  OpenGraph.HTML.swift
//  URLEmbeddedView
//
//  Created by marty-suzuki on 2018/07/14.
//  Copyright © 2018年 marty-suzuki. All rights reserved.
//

import Foundation

extension OpenGraph {
    struct HTML {
        private enum Const {
            static let metaTagKey = "meta"
            static let propertyKey = "property"
            static let contentKey = "content"
            static let propertyPrefix = "og:"
            static let regex: NSRegularExpression? = {
                let patterns = [
                    // "" & ""
                    "(?:content\\s*=\\s*\"([^>]*)\"\\s*property\\s*=\\s*\"([^>]*)\")",
                    "(?:property\\s*=\\s*\"([^>]*)\"\\s*content\\s*=\\s*\"([^>]*)\")",
                    // '' & ''
                    "(?:content\\s*=\\s*'([^>]*)'\\s*property\\s*=\\s*'([^>]*)')",
                    "(?:property\\s*=\\s*'([^>]*)'\\s*content\\s*=\\s*'([^>]*)')",
                    // "" & ''
                    "(?:content\\s*=\\s*\"([^>]*)\"\\s*property\\s*=\\s*'([^>]*)')",
                    "(?:property\\s*=\\s*\"([^>]*)\"\\s*content\\s*=\\s*'([^>]*)')",
                    // '' & ""
                    "(?:content\\s*=\\s*'([^>]*)'\\s*property\\s*=\\s*\"([^>]*)\")",
                    "(?:property\\s*=\\s*'([^>]*)'\\s*content\\s*=\\s*\"([^>]*)\")"
                ]
                let pattern = "meta\\s*\(patterns.joined(separator: "|"))\\s*/?>"
                return try? NSRegularExpression(pattern: pattern, options: [])
            }()
        }

        struct Metadata {
            enum Error: Swift.Error {
                case faildToConvertData(String)
            }

            let property: String
            let content: String
            fileprivate var isValid: Bool {
                return !property.isEmpty && !content.isEmpty
            }

            func unescapedContent() throws -> String {
                guard #available(iOS 11, tvOS 11, macOS 10.13, *) else {
                    return content
                }
                guard let data = content.data(using: .utf8) else {
                    throw Error.faildToConvertData(content)
                }
                let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                    .documentType : NSAttributedString.DocumentType.html,
                    NSAttributedString.DocumentReadingOptionKey("CharacterEncoding"): String.Encoding.utf8.rawValue
                ]
                return try NSAttributedString(data: data, options: options, documentAttributes: nil).string
            }
        }

        let metaList: [Metadata]

        init?(htmlString: String) {
            guard let regex = Const.regex else { return nil }
            let range = NSRange(htmlString.startIndex..<htmlString.endIndex, in: htmlString)
            let results = regex.matches(in: htmlString, options: [], range: range)
            let metaList: [Metadata] = results.compactMap { result in
                guard result.numberOfRanges > 2 else { return nil }
                let initial = Metadata(property: "", content: "")
                let metaData = (0..<result.numberOfRanges).reduce(initial) { metadata, index in
                    if index == 0 { return metadata }
                    let range = result.range(at: index)
                    if range.location == NSNotFound { return metadata }
                    let substring = (htmlString as NSString).substring(with: range)
                    if substring.contains(Const.propertyPrefix) {
                        return Metadata(property: substring, content: metadata.content)
                    }
                    return Metadata(property: metadata.property, content: substring)
                }
                return metaData.isValid ? metaData : nil
            }
            if metaList.isEmpty { return nil }
            self.metaList = metaList
        }
    }
}
