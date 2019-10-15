//
//  UIColor+ColorCompatibility.m
//  Threads
//
//  Created by Brooma Service on 05/09/2019.
//  Copyright © 2019 Sequenia. All rights reserved.
//

#import "THRColorCompatibility.h"
#import "UIColor+AltColor.h"

@implementation THRColorCompatibility

+ (UIColor*) labelColor {
    if (@available(iOS 13.0, *)) {
        return UIColor.labelColor;
    }
    return UIColorFromARGB(0xFF000000);
}

+ (UIColor*) secondaryLabelColor {
    if (@available(iOS 13.0, *)) {
        return UIColor.secondaryLabelColor;
    }
    return UIColorFromARGB(0x993c3c43);
}

+ (UIColor*) tertiaryLabelColor {
    if (@available(iOS 13.0, *)) {
        return UIColor.tertiaryLabelColor;
    }
    return UIColorFromARGB(0x4c3c3c43);
}

+ (UIColor*) quaternaryLabelColor {
    if (@available(iOS 13.0, *)) {
        return UIColor.quaternaryLabelColor;
    }
    return UIColorFromARGB(0x2d3c3c43);
}

+ (UIColor*) systemFillColor {
    if (@available(iOS 13.0, *)) {
        return UIColor.systemFillColor;
    }
    return UIColorFromARGB(0x33787880);
}

+ (UIColor*) secondarySystemFillColor {
    if (@available(iOS 13.0, *)) {
        return UIColor.secondarySystemFillColor;
    }
    return UIColorFromARGB(0x28787880);
}

+ (UIColor*) tertiarySystemFillColor {
    if (@available(iOS 13.0, *)) {
        return UIColor.tertiarySystemFillColor;
    }
    return UIColorFromARGB(0x1e767680);
}

+ (UIColor*) quaternarySystemFillColor {
    if (@available(iOS 13.0, *)) {
        return UIColor.quaternarySystemFillColor;
    }
    return UIColorFromARGB(0x14747480);
}

+ (UIColor*) placeholderTextColor {
    if (@available(iOS 13.0, *)) {
        return UIColor.placeholderTextColor;
    }
    return UIColorFromARGB(0x4c3c3c43);
}

+ (UIColor*) systemBackgroundColor {
    if (@available(iOS 13.0, *)) {
        return UIColor.systemBackgroundColor;
    }
    return UIColorFromARGB(0xffffffff);
}

+ (UIColor*) secondarySystemBackgroundColor {
    if (@available(iOS 13.0, *)) {
        return UIColor.secondarySystemBackgroundColor;
    }
    return UIColorFromARGB(0xfff2f2f7);
}

+ (UIColor*) tertiarySystemBackgroundColor {
    if (@available(iOS 13.0, *)) {
        return UIColor.tertiarySystemBackgroundColor;
    }
    return UIColorFromARGB(0xffffffff);
}

+ (UIColor*) systemGroupedBackgroundColor {
    if (@available(iOS 13.0, *)) {
        return UIColor.systemGroupedBackgroundColor;
    }
    return UIColorFromARGB(0xfff2f2f7);
}

+ (UIColor*) secondarySystemGroupedBackgroundColor {
    if (@available(iOS 13.0, *)) {
        return UIColor.secondarySystemGroupedBackgroundColor;
    }
    return UIColorFromARGB(0xffffffff);
}

+ (UIColor*) tertiarySystemGroupedBackgroundColor {
    if (@available(iOS 13.0, *)) {
        return UIColor.tertiarySystemGroupedBackgroundColor;
    }
    return UIColorFromARGB(0xfff2f2f7);
}

+ (UIColor*) separatorColor {
    if (@available(iOS 13.0, *)) {
        return UIColor.separatorColor;
    }
    return UIColorFromARGB(0x493c3c43);
}

+ (UIColor*) opaqueSeparatorColor {
    if (@available(iOS 13.0, *)) {
        return UIColor.opaqueSeparatorColor;
    }
    return UIColorFromARGB(0xffc6c6c8);
}

+ (UIColor*) linkColor {
    if (@available(iOS 13.0, *)) {
        return UIColor.linkColor;
    }
    return UIColorFromARGB(0xff007aff);
}

+ (UIColor*) darkTextColor {
    if (@available(iOS 13.0, *)) {
        return UIColor.darkTextColor;
    }
    return UIColorFromARGB(0xff000000);
}

+ (UIColor*) lightTextColor {
    if (@available(iOS 13.0, *)) {
        return UIColor.lightTextColor;
    }
    return UIColorFromARGB(0x99ffffff);
}

+ (UIColor*) systemBlueColor {
    if (@available(iOS 13.0, *)) {
        return UIColor.systemBlueColor;
    }
    return UIColorFromARGB(0xFF007AFF);
}

+ (UIColor*) systemGreenColor {
    if (@available(iOS 13.0, *)) {
        return UIColor.systemGreenColor;
    }
    return UIColorFromARGB(0xff34c759);
}

+ (UIColor*) systemIndigoColor {
    if (@available(iOS 13.0, *)) {
        return UIColor.systemIndigoColor;
    }
    return UIColorFromARGB(0xff5856d6);
}

+ (UIColor*) systemOrangeColor {
    if (@available(iOS 13.0, *)) {
        return UIColor.systemOrangeColor;
    }
    return UIColorFromARGB(0xffff9500);
}

+ (UIColor*) systemPinkColor {
    if (@available(iOS 13.0, *)) {
        return UIColor.systemPinkColor;
    }
    return UIColorFromARGB(0xffff2d54);
}

+ (UIColor*) systemPurpleColor {
    if (@available(iOS 13.0, *)) {
        return UIColor.systemPurpleColor;
    }
    return UIColorFromARGB(0xffaf52de);
}

+ (UIColor*) systemRedColor {
    if (@available(iOS 13.0, *)) {
        return UIColor.systemRedColor;
    }
    return UIColorFromARGB(0xffff3a30);
}

+ (UIColor*) systemTealColor {
    if (@available(iOS 13.0, *)) {
        return UIColor.systemTealColor;
    }
    return UIColorFromARGB(0xff5ac7fa);
}

+ (UIColor*) systemYellowColor {
    if (@available(iOS 13.0, *)) {
        return UIColor.systemYellowColor;
    }
    return UIColorFromARGB(0xffffcc00);
}

+ (UIColor*) systemGrayColor {
    if (@available(iOS 13.0, *)) {
        return UIColor.systemGrayColor;
    }
    return UIColorFromARGB(0xff8e8e93);
}

+ (UIColor*) systemGray2Color {
    if (@available(iOS 13.0, *)) {
        return UIColor.systemGray2Color;
    }
    return UIColorFromARGB(0xffaeaeb2);
}

+ (UIColor*) systemGray3Color {
    if (@available(iOS 13.0, *)) {
        return UIColor.systemGray3Color;
    }
    return UIColorFromARGB(0xffc7c7cc);
}

+ (UIColor*) systemGray4Color {
    if (@available(iOS 13.0, *)) {
        return UIColor.systemGray4Color;
    }
    return UIColorFromARGB(0xffd1d1d6);
}

+ (UIColor*) systemGray5Color {
    if (@available(iOS 13.0, *)) {
        return UIColor.systemGray5Color;
    }
    return UIColorFromARGB(0xffe5e5ea);
}

+ (UIColor*) systemGray6Color {
    if (@available(iOS 13.0, *)) {
        return UIColor.systemGray6Color;
    }
    return UIColorFromARGB(0xfff2f2f7);
}

@end
