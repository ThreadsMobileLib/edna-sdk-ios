//
//  URLEmbeddedView+Inspectable.swift
//  URLEmbeddedView
//
//  Created by Taiki Suzuki on 2016/03/07.
//
//

import Foundation

extension URLEmbeddedView {
    @IBInspectable public var cornerRaidus: CGFloat {
        set {
            layer.masksToBounds = newValue > 0
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    @IBInspectable public var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
            imageView.layer.borderColor = layer.borderColor
        }
        get {
            return layer.backgroundColor.map(UIColor.init)
        }
    }
    @IBInspectable public var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
            imageView.layer.borderWidth = layer.borderWidth
        }
        get {
            return layer.borderWidth
        }
    }
}
