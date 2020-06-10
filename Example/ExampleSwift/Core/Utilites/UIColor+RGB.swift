//
//  UIColor+RGB.swift
//  ExampleSwift
//
//  Created by Brooma Service on 23.04.2020.
//  Copyright © 2020 Threads. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    @available(iOS 13.0, *)
    convenience init(light: UIColor, dark: UIColor) {
        
        self.init(dynamicProvider: { (traits) in
            
            switch traits.userInterfaceStyle {
            
            case .unspecified, .light:
                return light
                
            case .dark:
                return dark
                
            @unknown default:
                return light
            }
        })
    }
    
    convenience init(rgb: UInt) {
        self.init(red: CGFloat((Float((rgb & 0xff0000) >> 16)) / 255.0),
                  green: CGFloat((Float((rgb & 0x00ff00) >> 8)) / 255.0),
                  blue: CGFloat((Float((rgb & 0x0000ff) >> 0)) / 255.0),
                  alpha: 1.0)
    }
    
    convenience init(argb: UInt) {
        self.init(red: CGFloat((Float((argb & 0x00ff0000) >> 16)) / 255.0),
                  green: CGFloat((Float((argb & 0x0000ff00) >> 8)) / 255.0),
                  blue: CGFloat((Float((argb & 0x000000ff) >> 0)) / 255.0),
                  alpha: CGFloat((Float((argb & 0xff000000) >> 24)) / 255.0))
    }
    
    public class func named(_ colorName: String, fallback: UIColor) -> UIColor {
        
        if #available(iOS 11.0, *) {
            let namedColor = UIColor.init(named: colorName)
            return namedColor ?? fallback;
        } else {
            return fallback
        }
    }
    
}
