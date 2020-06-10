//
//  UIFont+THRFonts.swift
//  ExampleSwift
//
//  Created by Brooma Service on 23.04.2020.
//  Copyright © 2020 Threads. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    public class func latoRegular(ofSize: CGFloat) -> UIFont {
        return UIFont.init(name: "Lato-Regular", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
    }

    public class func latoSemibold(ofSize: CGFloat) -> UIFont {
        return UIFont.init(name: "Lato-Semibold", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
    }

    public class func latoLight(ofSize: CGFloat) -> UIFont {
        return UIFont.init(name: "Lato-Light", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
    }

    public class func latoMedium(ofSize: CGFloat) -> UIFont {
        return UIFont.init(name: "Lato-Medium", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
    }

}
