//
//  AutoLayout.swift
//  URLEmbeddedView
//
//  Created by marty-suzuki on 2017/08/17.
//  Copyright © 2017年 marty-suzuki. All rights reserved.
//

import UIKit

extension UIView {
    struct Size {
        static let zero = Size(width: 0, height: 0)
        
        let width: CGFloat?
        let height: CGFloat?
        
        init(width: CGFloat? = nil, height: CGFloat? = nil) {
            self.width = width
            self.height = height
        }
    }
    
    func addConstraints(with view: UIView,
                        size: Size,
                        relatedBy relation: NSLayoutRelation = .equal,
                        multiplier: CGFloat = 1) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addConstraints([
                (.width, size.width),
                (.height, size.height)
            ]
            .compactMap { (value: (NSLayoutAttribute, CGFloat?)) in
                value.1.map {
                    .init(item: view,
                          attribute: value.0,
                          relatedBy: relation,
                          toItem: nil,
                          attribute: .notAnAttribute,
                          multiplier: multiplier,
                          constant: $0)
                }
            }
        )
    }
    
    func addConstraints(with view: UIView, center: CGPoint, multiplier: CGFloat = 1) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addConstraints([
                (.centerX, center.x),
                (.centerY, center.y)
            ]
            .compactMap {
                .init(item: view,
                      attribute: $0,
                      relatedBy: .equal,
                      toItem: self,
                      attribute: $0,
                      multiplier: multiplier,
                      constant: $1)
            })
    }
    
    struct Edges {
        static let zero = Edges(top: 0, left: 0, right: 0, bottom: 0)
        
        let top: CGFloat?
        let left: CGFloat?
        let right: CGFloat?
        let bottom: CGFloat?
        
        init(top: CGFloat? = nil,
             left: CGFloat? = nil,
             right: CGFloat? = nil,
             bottom: CGFloat? = nil) {
            self.top = top
            self.left = left
            self.right = right
            self.bottom = bottom
        }
    }
    
    func addConstraints(with view: UIView, edges: Edges, multiplier: CGFloat = 1) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addConstraints([
                (.top, edges.top),
                (.left, edges.left),
                (.right, edges.right),
                (.bottom, edges.bottom)
            ]
            .compactMap { (value: (NSLayoutAttribute, CGFloat?)) in
                value.1.map {
                    .init(item: view,
                          attribute: value.0,
                          relatedBy: .equal,
                          toItem: self,
                          attribute: value.0,
                          multiplier: multiplier,
                          constant: $0)
                }
            })
    }
}
