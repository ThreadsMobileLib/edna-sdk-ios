//
//  ColorCompatibility.swift
//  ExampleSwift
//
//  Created by Brooma Service on 23.04.2020.
//  Copyright © 2020 Threads. All rights reserved.
//

import UIKit

class ColorCompatibility: NSObject {
    
    public class func labelColor() -> UIColor {

        if #available(iOS 13.0, *) {
            return UIColor.label
        } else {
            return UIColor.init(argb: 0xFF000000)
        }

    }
    
    public class func secondaryLabelColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.secondaryLabel;
        }
        return UIColor.init(argb: 0x993c3c43);
    }

    public class func tertiaryLabelColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.tertiaryLabel;
        }
        return UIColor.init(argb: 0x4c3c3c43);
    }

    public class func quaternaryLabelColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.quaternaryLabel;
        }
        return UIColor.init(argb: 0x2d3c3c43);
    }

    public class func systemFillColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemFill;
        }
        return UIColor.init(argb: 0x33787880);
    }

    public class func secondarySystemFillColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.secondarySystemFill;
        }
        return UIColor.init(argb: 0x28787880);
    }

    public class func tertiarySystemFillColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.tertiarySystemFill;
        }
        return UIColor.init(argb: 0x1e767680);
    }

    public class func quaternarySystemFillColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.quaternarySystemFill;
        }
        return UIColor.init(argb: 0x14747480);
    }

    public class func placeholderTextColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.placeholderText;
        }
        return UIColor.init(argb: 0x4c3c3c43);
    }

    public class func systemBackgroundColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemBackground;
        }
        return UIColor.init(argb: 0xffffffff);
    }

    public class func secondarySystemBackgroundColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.secondarySystemBackground;
        }
        return UIColor.init(argb: 0xfff2f2f7);
    }

    public class func tertiarySystemBackgroundColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.tertiarySystemBackground;
        }
        return UIColor.init(argb: 0xffffffff);
    }

    public class func systemGroupedBackgroundColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemGroupedBackground;
        }
        return UIColor.init(argb: 0xfff2f2f7);
    }

    public class func secondarySystemGroupedBackgroundColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.secondarySystemGroupedBackground;
        }
        return UIColor.init(argb: 0xffffffff);
    }

    public class func tertiarySystemGroupedBackgroundColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.tertiarySystemGroupedBackground;
        }
        return UIColor.init(argb: 0xfff2f2f7);
    }

    public class func separatorColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.separator;
        }
        return UIColor.init(argb: 0x493c3c43);
    }

    public class func opaqueSeparatorColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.opaqueSeparator;
        }
        return UIColor.init(argb: 0xffc6c6c8);
    }

    public class func linkColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.link;
        }
        return UIColor.init(argb: 0xff007aff);
    }

    public class func darkTextColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.darkText;
        }
        return UIColor.init(argb: 0xff000000);
    }

    public class func lightTextColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.lightText;
        }
        return UIColor.init(argb: 0x99ffffff);
    }

    public class func systemBlueColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemBlue;
        }
        return UIColor.init(argb: 0xFF007AFF);
    }

    public class func systemGreenColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemGreen;
        }
        return UIColor.init(argb: 0xff34c759);
    }

    public class func systemIndigoColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemIndigo;
        }
        return UIColor.init(argb: 0xff5856d6);
    }

    public class func systemOrangeColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemOrange;
        }
        return UIColor.init(argb: 0xffff9500);
    }

    public class func systemPinkColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemPink;
        }
        return UIColor.init(argb: 0xffff2d54);
    }

    public class func systemPurpleColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemPurple;
        }
        return UIColor.init(argb: 0xffaf52de);
    }

    public class func systemRedColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemRed;
        }
        return UIColor.init(argb: 0xffff3a30);
    }

    public class func systemTealColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemTeal;
        }
        return UIColor.init(argb: 0xff5ac7fa);
    }

    public class func systemYellowColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemYellow;
        }
        return UIColor.init(argb: 0xffffcc00);
    }

    public class func systemGrayColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemGray;
        }
        return UIColor.init(argb: 0xff8e8e93);
    }

    public class func systemGray2Color() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemGray2;
        }
        return UIColor.init(argb: 0xffaeaeb2);
    }

    public class func systemGray3Color() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemGray3;
        }
        return UIColor.init(argb: 0xffc7c7cc);
    }

    public class func systemGray4Color() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemGray4;
        }
        return UIColor.init(argb: 0xffd1d1d6);
    }

    public class func systemGray5Color() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemGray5;
        }
        return UIColor.init(argb: 0xffe5e5ea);
    }

    public class func systemGray6Color() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemGray6;
        }
        return UIColor.init(argb: 0xfff2f2f7);
    }

}
