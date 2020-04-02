//
//  UIFont+THRFonts.m
//  Example
//
//  Created by Brooma Service on 20.12.2019.
//  Copyright © 2019 Threads. All rights reserved.
//

#import "UIFont+THRFonts.h"

@implementation UIFont (THRFonts)

+ (UIFont *)latoRegularOfSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"Lato-Regular" size:fontSize];
}

+ (UIFont *)latoSemiboldOfSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"Lato-Semibold" size:fontSize];
}

+ (UIFont *)latoLightOfSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"Lato-Light" size:fontSize];
}

+ (UIFont *)latoMediumOfSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"Lato-Medium" size:fontSize];
}

@end
