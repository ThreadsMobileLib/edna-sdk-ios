//
//  THRColorCompatibility.swift
//  ThreadsAppSwift
//
//  Created by Brooma Service on 23/09/2019.
//  Copyright © 2019 Brooma Service. All rights reserved.
//

import UIKit

class THRColorCompatibility {
    
    class func label() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return UIColor.label
        } else {
            return UIColor(argbHex:0xFF000000)
        };
    }

    class func secondaryLabel() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.secondaryLabel;
        }
        return UIColor(argbHex:0x993c3c43);
    }

    class func tertiaryLabel() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.tertiaryLabel;
        }
        return UIColor(argbHex:0x4c3c3c43);
    }

    class func quaternaryLabel() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.quaternaryLabel;
        }
        return UIColor(argbHex:0x2d3c3c43);
    }

    class func systemFill() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemFill;
        }
        return UIColor(argbHex:0x33787880);
    }

    class func secondarySystemFill() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.secondarySystemFill;
        }
        return UIColor(argbHex:0x28787880);
    }

    class func tertiarySystemFill() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.tertiarySystemFill;
        }
        return UIColor(argbHex:0x1e767680);
    }

    class func quaternarySystemFill() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.quaternarySystemFill;
        }
        return UIColor(argbHex:0x14747480);
    }

    class func placeholderText() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.placeholderText;
        }
        return UIColor(argbHex:0x4c3c3c43);
    }

    class func systemBackground() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemBackground;
        }
        return UIColor(argbHex:0xffffffff);
    }

    class func secondarySystemBackground() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.secondarySystemBackground;
        }
        return UIColor(argbHex:0xfff2f2f7);
    }

    class func tertiarySystemBackground() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.tertiarySystemBackground;
        }
        return UIColor(argbHex:0xffffffff);
    }

    class func systemGroupedBackground() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemGroupedBackground;
        }
        return UIColor(argbHex:0xfff2f2f7);
    }

    class func secondarySystemGroupedBackground() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.secondarySystemGroupedBackground;
        }
        return UIColor(argbHex:0xffffffff);
    }

    class func tertiarySystemGroupedBackground() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.tertiarySystemGroupedBackground;
        }
        return UIColor(argbHex:0xfff2f2f7);
    }

    class func separator() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.separator;
        }
        return UIColor(argbHex:0x493c3c43);
    }

    class func opaqueSeparator() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.opaqueSeparator;
        }
        return UIColor(argbHex:0xffc6c6c8);
    }

    class func link() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.link;
        }
        return UIColor(argbHex:0xff007aff);
    }

    class func darkText() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.darkText;
        }
        return UIColor(argbHex:0xff000000);
    }

    class func lightText() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.lightText;
        }
        return UIColor(argbHex:0x99ffffff);
    }

    class func systemBlue() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemBlue;
        }
        return UIColor(argbHex:0xFF007AFF);
    }

    class func systemGreen() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemGreen;
        }
        return UIColor(argbHex:0xff34c759);
    }

    class func systemIndigo() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemIndigo;
        }
        return UIColor(argbHex:0xff5856d6);
    }

    class func systemOrange() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemOrange;
        }
        return UIColor(argbHex:0xffff9500);
    }

    class func systemPink() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemPink;
        }
        return UIColor(argbHex:0xffff2d54);
    }

    class func systemPurple() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemPurple;
        }
        return UIColor(argbHex:0xffaf52de);
    }

    class func systemRed() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemRed;
        }
        return UIColor(argbHex:0xffff3a30);
    }

    class func systemTeal() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemTeal;
        }
        return UIColor(argbHex:0xff5ac7fa);
    }

    class func systemYellow() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemYellow;
        }
        return UIColor(argbHex:0xffffcc00);
    }

    class func systemGray() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemGray;
        }
        return UIColor(argbHex:0xff8e8e93);
    }

    class func systemGray2() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemGray2;
        }
        return UIColor(argbHex:0xffaeaeb2);
    }

    class func systemGray3() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemGray3;
        }
        return UIColor(argbHex:0xffc7c7cc);
    }

    class func systemGray4() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemGray4;
        }
        return UIColor(argbHex:0xffd1d1d6);
    }

    class func systemGray5() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemGray5;
        }
        return UIColor(argbHex:0xffe5e5ea);
    }

    class func systemGray6() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemGray6;
        }
        return UIColor(argbHex:0xfff2f2f7);
    }
}
