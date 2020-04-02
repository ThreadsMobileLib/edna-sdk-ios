//
//  UIColor+AltColor.m
//  Threads
//
//  Created by Nikolay Kagala on 31/05/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import "UIColor+AltColor.h"
#import "THRColorCompatibility.h"

@implementation UIColor (AltColor)

#pragma mark - Convenience

+ (UIColor*) dynamicColorLight: (UIColor*) light dark: (UIColor*) dark {
    
    if (@available(iOS 13, *)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                return dark;
            } else {
                return light;
            }
        }];
    } else {
        return light;
    }
}

+ (UIColor*) alt_named:(NSString*) colorName fallBackColor: (UIColor*) fallbackColor {
    
    if (@available(iOS 13, *)) {
        UIColor* namedColor = [self alt_named: colorName];
        return namedColor ? namedColor : fallbackColor;
        
    } else {
        return fallbackColor;
    }
}

+ (UIColor*) alt_named:(NSString*) colorName API_AVAILABLE(ios(13)) {
    return [UIColor colorNamed:colorName];
}

+ (UIColor*) alt_mainBackgroundColor {
    return [THRColorCompatibility systemGray6Color];
}

+ (UIColor*) alt_navigationBarBackgroundColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_navigationBarBackgroundColor"];
    } else {
        return UIColorFromRGB(0x83B143);
    }
}

+ (UIColor*) alt_navigationBarTintColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_navigationBarTintColor"];
    } else {
        return self.yellowColor;
    }
}

+ (UIColor*) alt_incomingBubbleColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_incomingBubbleColor"];
    } else {
        return [self whiteColor];
    }
}

+ (UIColor*) alt_incomingBubbleTextColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_incomingBubbleTextColor"];
    } else {
        return UIColorFromRGB(0x333333);
    }
}

+ (UIColor*) alt_incomingTimeColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_incomingTimeColor"];
    } else {
        return [self blackColor];
    }
}

+ (UIColor*) alt_incomingMediaTimeColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_incomingMediaTimeColor"];
    } else {
        return [self whiteColor];
    }
}

+ (UIColor*) alt_incomingBubbleLinkColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_incomingBubbleLinkColor"];
    } else {
        return UIColorFromRGB(0x83B143);
    }
}

+ (UIColor*) alt_outgoingBubbleColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_outgoingBubbleColor"];
    } else {
        return UIColorFromRGB(0x83B143);
    }
}

+ (UIColor*) alt_outgoingBubbleTextColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_outgoingBubbleTextColor"];
    } else {
        return [UIColor whiteColor];
    }
}

+ (UIColor*) alt_outgoingTimeColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_outgoingTimeColor"];
    } else {
        return [self whiteColor];
    }
}

+ (UIColor*) alt_outgoingMediaTimeColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_outgoingMediaTimeColor"];
    } else {
        return [self whiteColor];
    }
}

+ (UIColor*) alt_outgoingBubbleLinkColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_outgoingBubbleLinkColor"];
    } else {
        return [UIColor blueColor];
    }
}

+ (UIColor*) alt_outgoingPendingStatusColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_outgoingPendingStatusColor"];
    } else {
        return [self whiteColor];
    }
}

+ (UIColor*) alt_outgoingDeliveredStatusColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_outgoingDeliveredStatusColor"];
    } else {
        return [self whiteColor];
    }
}

+ (UIColor*) alt_outgoingReadStatusColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_outgoingReadStatusColor"];
    } else {
        return [self whiteColor];
    }
}

+ (UIColor*) alt_outgoingMediaPendingStatusColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_outgoingMediaPendingStatusColor"];
    } else {
        return [self whiteColor];
    }
}

+ (UIColor*) alt_outgoingMediaDeliveredStatusColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_outgoingMediaDeliveredStatusColor"];
    } else {
        return [self whiteColor];
    }
}

+ (UIColor*) alt_outgoingMediaReadStatusColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_outgoingMediaReadStatusColor"];
    } else {
        return [self whiteColor];
    }
}

+ (UIColor*) alt_timeAndStatusBackgroundColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_timeAndStatusBackgroundColor"];
    } else {
        return [self alt_black_transparent_50];
    }
}

+ (UIColor*) alt_incomingFileIconBgColor {
    return [THRColorCompatibility systemGray5Color];
}

+ (UIColor*) alt_incomingFileIconTintColor {
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_incomingFileIconTintColor"];
    } else {
        return UIColorFromRGB(0x83B143);
    }
}

+ (UIColor*) alt_outgoingFileIconBgColor {
    return [THRColorCompatibility systemGray5Color];
}

+ (UIColor*) alt_outgoingFileIconTintColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_outgoingFileIconTintColor"];
    } else {
        return UIColorFromRGB(0x83B143);
    }
}

+ (UIColor*) alt_failedBubbleColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_failedBubbleColor"];
    } else {
        return UIColorFromRGB(0xF44336);
    }
}

+ (UIColor*) alt_outgoingQuoteAuthorColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_outgoingQuoteAuthorColor"];
    } else {
        return [UIColor whiteColor];
    }
}

+ (UIColor*) alt_incomingQuoteAuthorColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_incomingQuoteAuthorColor"];
    } else {
        return UIColorFromRGB(0x333333);
    }
}

+ (UIColor*) alt_outgoingQuoteMessageColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_outgoingQuoteMessageColor"];
    } else {
        return [UIColor whiteColor];
    }
}

+ (UIColor*) alt_incomingQuoteMessageColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_incomingQuoteMessageColor"];
    } else {
        return UIColorFromARGB(0xB333338B);
    }
}

+ (UIColor*) alt_outgoingQuoteTimeColor {

    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_outgoingQuoteTimeColor"];
    } else {
        return [UIColor whiteColor];
    }
}

+ (UIColor*) alt_incomingQuoteTimeColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_incomingQuoteTimeColor"];
    } else {
        return UIColorFromARGB(0xB333338B);
    }
}

+ (UIColor*) alt_outgoingQuoteSeparatorColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_outgoingQuoteSeparatorColor"];
    } else {
        return [UIColor whiteColor];
    }
}

+ (UIColor*) alt_incomingQuoteSeparatorColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_incomingQuoteSeparatorColor"];
    } else {
        return UIColorFromRGB(0x83B143);
    }
}

+ (UIColor*) alt_outgoingQuoteFilesizeColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_outgoingQuoteFilesizeColor"];
    } else {
        return [UIColor whiteColor];
    }
}

+ (UIColor*) alt_incomingQuoteFilesizeColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_incomingQuoteFilesizeColor"];
    } else {
        return UIColorFromARGB(0xB333338B);
    }
}

+ (UIColor*) alt_surveyTextColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_surveyTextColor"];
    } else {
        return UIColorFromRGB(0x83B143);
    }
}

+ (UIColor*) alt_likeRatingColorEnabled {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_likeRatingColorEnabled"];
    } else {
        return UIColorFromRGB(0x83B143);
    }
}

+ (UIColor*) alt_likeRatingColorDisabled {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_likeRatingColorDisabled"];
    } else {
        return UIColorFromRGB(0x83B143);
    }
}

+ (UIColor*) alt_starRatingColorEnabled {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_starRatingColorEnabled"];
    } else {
        return [UIColor redColor];
    }
}

+ (UIColor*) alt_starRatingColorDisabled {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_starRatingColorDisabled"];
    } else {
        return [UIColor redColor];
    }
}

+ (UIColor*) alt_surveyCompletionColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_surveyCompletionColor"];
    } else {
        return UIColorFromRGB(0x83B143);
    }
}

+ (UIColor*) alt_starRatingColorCompleted {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_starRatingColorCompleted"];
    } else {
        return [UIColor redColor];
    }
}

+ (UIColor*) alt_likeRatingColorCompleted {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_likeRatingColorCompleted"];
    } else {
        return [UIColor yellowColor];
    }
}

+ (UIColor*) alt_likeLabelOnStarColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_likeLabelOnStarColor"];
    } else {
        return [self whiteColor];
    }
}

+ (UIColor*) alt_likeLabelUnderStarColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_likeLabelUnderStarColor"];
    } else {
        return [self whiteColor];
    }
}

+ (UIColor*) alt_scheduleAlertColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_scheduleAlertColor"];
    } else {
        return UIColorFromRGB(0x333333);
    }
}

+ (UIColor*) alt_waitingSpecialistBgColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_waitingSpecialistBgColor"];
    } else {
        return [self whiteColor];
    }
}

+ (UIColor*) alt_waitingSpecialistBorderColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_waitingSpecialistBorderColor"];
    } else {
        return [UIColor clearColor];
    }
}

+ (UIColor*) alt_waitingSpecialistSpinnerColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_waitingSpecialistSpinnerColor"];
    } else {
        return UIColorFromRGB(0x83B143);
    }
}

+ (UIColor*) alt_specialisConnectTitleColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_specialisConnectTitleColor"];
    } else {
        return UIColorFromRGB(0x333333);
    }
}

+ (UIColor*) alt_specialisConnectSubtitleColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_specialisConnectSubtitleColor"];
    } else {
        return UIColorFromRGB(0x333333);
    }
}

+ (UIColor*) alt_sendButtonColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_sendButtonColor"];
    } else {
        return UIColorFromRGB(0x83B143);
    }
}

+ (UIColor*) alt_sendButtonHighlightColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_sendButtonHighlightColor"];
    } else {
        return UIColorFromARGB(0xB283B143);
    }
}

+ (UIColor*) alt_sendButtonDisabledColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_sendButtonDisabledColor"];
    } else {
        return [self lightGrayColor];
    }
}

+ (UIColor*) alt_attachButtonColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_attachButtonColor"];
    } else {
        return UIColorFromRGB(0x83B143);
    }
}

+ (UIColor*) alt_attachButtonHighlightColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_attachButtonHighlightColor"];
    } else {
        return UIColorFromARGB(0xB283B143);
    }
}

+ (UIColor*) alt_toolbarTintColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_toolbarTintColor"];
    } else {
        return [UIColor redColor];
    }
}

+ (UIColor*) alt_toolbarQuotedMessageAuthorColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_toolbarQuotedMessageAuthorColor"];
    } else {
        return UIColorFromRGB(0x333333);
    }
}

+ (UIColor*) alt_toolbarQuotedMessageColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_toolbarQuotedMessageColor"];
    } else {
        return UIColorFromARGB(0x803333330);
    }
}

+ (UIColor*) alt_photoPickerToolbarTintColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_photoPickerToolbarTintColor"];
    } else {
        return UIColorFromRGB(0x83B143);
    }
}

+ (UIColor*) alt_photoPickerSheetTextColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_photoPickerSheetTextColor"];
    } else {
        return UIColorFromRGB(0x83B143);
    }
}

+ (UIColor*) alt_emptyImageColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_emptyImageColor"];
    } else {
        return  [self alt_middleGray];
    }
}

+ (UIColor*) alt_refreshColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_refreshColor"];
    } else {
        return UIColorFromRGB(0x83B143);
    }
}

+ (UIColor*) alt_scrollToBottomBadgeColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_scrollToBottomBadgeColor"];
    } else {
        return [self alt_red];
    }
}

+ (UIColor*) alt_scrollToBottomBadgeTextColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_scrollToBottomBadgeTextColor"];
    } else {
        return [self whiteColor];
    }
}

+ (UIColor*) alt_typingTextColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_typingTextColor"];
    } else {
        return UIColorFromARGB(0x803333330);
    }
}

+ (UIColor*) alt_placeholderTitleColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_placeholderTitleColor"];
    } else {
        return UIColorFromARGB(0xB2333333);
    }
}

+ (UIColor*) alt_placeholderSubtitleColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_placeholderSubtitleColor"];
    } else {
        return UIColorFromARGB(0x80333333);
    }
}

+ (UIColor*) alt_searchScopeBarTintColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_searchScopeBarTintColor"];
    } else {
        return UIColorFromRGB(0x83B143);
    }
}

+ (UIColor*) alt_searchBarTextColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_searchBarTextColor"];
    } else {
        return UIColorFromRGB(0x333333);
    }
}

+ (UIColor*) alt_searchBarTintColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_searchBarTintColor"];
    } else {
        return UIColorFromRGB(0x333333);
    }
}

+ (UIColor*) alt_searchMessageAuthorTextColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_searchMessageAuthorTextColor"];
    } else {
        return UIColorFromRGB(0x333333);
    }
}

+ (UIColor*) alt_searchMessageDateTextColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_searchMessageDateTextColor"];
    } else {
        return UIColorFromARGB(0xB333338B);
    }
}

+ (UIColor*) alt_searchMessageFileTextColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_searchMessageFileTextColor"];
    } else {
        return UIColorFromARGB(0xB333338B);
    }
}

+ (UIColor*) alt_searchMessageTextColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_searchMessageTextColor"];
    } else {
        return UIColorFromARGB(0xB333338B);
    }
}

+ (UIColor*) alt_searchMessageMatchTextColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_searchMessageMatchTextColor"];
    } else {
        return UIColorFromRGB(0x83B143);
    }
}

+ (UIColor*) alt_findedMessageHeaderTextColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_findedMessageHeaderTextColor"];
    } else {
        return UIColorFromARGB(0x803333330);
    }
}

+ (UIColor*) alt_findedMessageHeaderBackgroundColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_findedMessageHeaderBackgroundColor"];
    } else {
        return UIColorFromRGB(0xEAF0F0);
    }
}

+ (UIColor*) alt_findMoreMessageTextColor {
    
    if (@available(iOS 13, *)) {
        return [self alt_named:@"alt_findMoreMessageTextColor"];
    } else {
        return UIColorFromRGB(0x333333);
    }
}

#pragma mark - Colors

+ (UIColor*) alt_darkGreen { return UIColorFromRGB(0x009688); }

+ (UIColor*) alt_lightGreen { return UIColorFromRGB(0x25C281); }

+ (UIColor*) alt_gray { return UIColorFromRGB(0x607D8B); }

+ (UIColor*) alt_lightGray { return UIColorFromRGB(0xEFF3F8); }

+ (UIColor*) alt_middleGray { return UIColorFromRGB(0xE6E6EC); }

+ (UIColor*) alt_darkGray { return UIColorFromRGB(0xC7C7C7); }

+ (UIColor*) alt_darkerGray { return UIColorFromRGB(0x333333); }

+ (UIColor*) alt_black_transparent_50 {
    return [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5f];
}

+ (UIColor*) alt_lightCyan { return UIColorFromRGB(0xB2DFDB); }

+ (UIColor*) alt_blue { return UIColorFromRGB(0x3598DC); }

+ (UIColor*) alt_red { return UIColorFromRGB(0xF44336); }

+ (UIColor*) alt_orange { return UIColorFromRGB(0xFF9800); }

+ (UIColor*) alt_darkOrange { return UIColorFromRGB(0xF7C16F); }

+ (UIColor*) alt_gold {
    return UIColorFromRGB(0xFCC200);
}

@end
