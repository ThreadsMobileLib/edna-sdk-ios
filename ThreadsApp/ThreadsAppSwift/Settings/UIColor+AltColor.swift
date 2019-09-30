//
//  UIColor+AltSwiftColor.swift
//  ThreadsAppSwift
//
//  Created by Brooma Service on 23/09/2019.
//  Copyright © 2019 Brooma Service. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int, alpha: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha) / 255.0)
    }
    
    convenience init(rgbHex: UInt32) {
        self.init(red:Int((rgbHex >> 16) & 0xff), green:Int((rgbHex >> 8) & 0xff), blue:Int(rgbHex & 0xff), alpha: 255);
    }
    
    convenience init(argbHex: UInt32) {
        self.init(red:Int((argbHex >> 16) & 0xff), green:Int((argbHex >> 8) & 0xff), blue:Int(argbHex & 0xff), alpha: Int((argbHex >> 24) & 0xff))
    }
    
    @available(iOS 13.0, *)
    class func alt_named(_ colorName: String) -> UIColor? {
        return UIColor(named: colorName);
    }
    
    class func alt_mainBackgroundColor() -> UIColor {
        return THRColorCompatibility.systemGray6();
    }
    
    class func alt_navigationBarBackgroundColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_navigationBarBackgroundColor") ?? UIColor(rgbHex: 0x83B143)
        } else {
            return UIColor(rgbHex: 0x83B143);
        }
    }

    class func alt_navigationBarTintColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_navigationBarTintColor") ?? self.yellow
        } else {
            return self.yellow;
        }
    }

    class func alt_incomingBubbleColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_incomingBubbleColor") ?? self.white
        } else {
            return self.white
        }
    }

    class func alt_incomingBubbleTextColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_incomingBubbleTextColor") ?? UIColor(rgbHex: 0x333333)
        } else {
            return UIColor(rgbHex: 0x333333)
        }
    }

    class func alt_incomingTimeColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_incomingTimeColor") ?? self.black
        } else {
            return self.black
        }
    }

    class func alt_incomingMediaTimeColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_incomingMediaTimeColor") ?? self.white
        } else {
            return self.white
        }
    }

    class func alt_incomingBubbleLinkColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_incomingBubbleLinkColor") ?? UIColor(rgbHex: 0x83B143)
        } else {
            return UIColor(rgbHex: 0x83B143)
        }
    }

    class func alt_outgoingBubbleColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_outgoingBubbleColor") ?? UIColor(rgbHex: 0x83B143)
        } else {
            return UIColor(rgbHex: 0x83B143)
        }
    }

    class func alt_outgoingBubbleTextColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_outgoingBubbleTextColor") ?? self.white
        } else {
            return self.white
        }
    }

    class func alt_outgoingTimeColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_outgoingTimeColor") ?? self.white
        } else {
            return self.white
        }
    }

    class func alt_outgoingMediaTimeColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_outgoingMediaTimeColor") ?? self.white
        } else {
            return self.white
        }
    }

    class func alt_outgoingBubbleLinkColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_outgoingBubbleLinkColor") ?? self.blue
        } else {
            return self.blue
        }
    }

    class func alt_outgoingPendingStatusColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_outgoingPendingStatusColor") ?? self.white
        } else {
            return self.white
        }
    }

    class func alt_outgoingDeliveredStatusColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_outgoingDeliveredStatusColor") ?? self.white
        } else {
            return self.white
        }
    }

    class func alt_outgoingReadStatusColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_outgoingReadStatusColor") ?? self.white
        } else {
            return self.white
        }
    }

    class func alt_outgoingMediaPendingStatusColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_outgoingMediaPendingStatusColor") ?? self.white
        } else {
            return self.white
        }
    }

    class func alt_outgoingMediaDeliveredStatusColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_outgoingMediaDeliveredStatusColor") ?? self.white
        } else {
            return self.white
        }
    }

    class func alt_outgoingMediaReadStatusColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_outgoingMediaReadStatusColor") ?? self.white
        } else {
            return self.white
        }
    }

    class func alt_timeAndStatusBackgroundColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_timeAndStatusBackgroundColor") ?? self.alt_black_transparent_50()
        } else {
            return self.alt_black_transparent_50()
        }
    }

    class func alt_incomingFileIconBgColor() -> UIColor {
        return THRColorCompatibility.systemGray5()
    }

    class func alt_incomingFileIconTintColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_incomingFileIconTintColor") ?? UIColor(rgbHex: 0x83B143)
        } else {
            return UIColor(rgbHex: 0x83B143)
        }
    }

    class func alt_outgoingFileIconBgColor() -> UIColor {
        return THRColorCompatibility.systemGray5()
    }

    class func alt_outgoingFileIconTintColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_outgoingFileIconTintColor") ?? UIColor(rgbHex: 0x83B143)
        } else {
            return UIColor(rgbHex: 0x83B143)
        }
    }

    class func alt_failedBubbleColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_failedBubbleColor") ?? UIColor(rgbHex: 0xF44336)
        } else {
            return UIColor(rgbHex: 0xF44336)
        }
    }

    class func alt_outgoingQuoteAuthorColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_outgoingQuoteAuthorColor") ?? self.white
        } else {
            return self.white
        }
    }

    class func alt_incomingQuoteAuthorColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_incomingQuoteAuthorColor") ?? UIColor(rgbHex:0x333333)
        } else {
            return UIColor(rgbHex:0x333333)
        }
    }

    class func alt_outgoingQuoteMessageColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_outgoingQuoteMessageColor") ?? self.white
        } else {
            return self.white
        }
    }

    class func alt_incomingQuoteMessageColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_incomingQuoteMessageColor") ?? UIColor(argbHex:0xB333338B)
        } else {
            return UIColor(argbHex:0xB333338B)
        }
    }

    class func alt_outgoingQuoteTimeColor() -> UIColor {

        if #available(iOS 13.0, *) {
            return self.alt_named("alt_outgoingQuoteTimeColor") ?? self.white
        } else {
            return self.white
        }
    }

    class func alt_incomingQuoteTimeColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_incomingQuoteTimeColor") ?? UIColor(argbHex:0xB333338B)
        } else {
            return UIColor(argbHex:0xB333338B)
        }
    }

    class func alt_outgoingQuoteSeparatorColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_outgoingQuoteSeparatorColor") ?? self.white
        } else {
            return self.white
        }
    }

    class func alt_incomingQuoteSeparatorColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_incomingQuoteSeparatorColor") ?? UIColor(rgbHex: 0x83B143)
        } else {
            return UIColor(rgbHex: 0x83B143)
        }
    }

    class func alt_outgoingQuoteFilesizeColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_outgoingQuoteFilesizeColor") ?? self.white
        } else {
            return self.white
        }
    }

    class func alt_incomingQuoteFilesizeColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_incomingQuoteFilesizeColor") ?? UIColor(argbHex:0xB333338B)
        } else {
            return UIColor(argbHex:0xB333338B)
        }
    }

    class func alt_surveyTextColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_surveyTextColor") ?? UIColor(rgbHex: 0x83B143)
        } else {
            return UIColor(rgbHex: 0x83B143)
        }
    }

    class func alt_likeRatingColorEnabled() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_likeRatingColorEnabled") ?? UIColor(rgbHex: 0x83B143)
        } else {
            return UIColor(rgbHex: 0x83B143)
        }
    }

    class func alt_likeRatingColorDisabled() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_likeRatingColorDisabled") ?? UIColor(rgbHex: 0x83B143)
        } else {
            return UIColor(rgbHex: 0x83B143)
        }
    }

    class func alt_starRatingColorEnabled() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_starRatingColorEnabled") ?? self.red
        } else {
            return self.red
        }
    }

    class func alt_starRatingColorDisabled() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_starRatingColorDisabled") ?? self.red
        } else {
            return self.red
        }
    }

    class func alt_surveyCompletionColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_surveyCompletionColor") ?? UIColor(rgbHex: 0x83B143)
        } else {
            return UIColor(rgbHex: 0x83B143)
        }
    }

    class func alt_starRatingColorCompleted() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_starRatingColorCompleted") ?? self.red
        } else {
            return self.red
        }
    }

    class func alt_likeRatingColorCompleted() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_likeRatingColorCompleted") ?? UIColor.yellow
        } else {
            return UIColor.yellow
        }
    }

    class func alt_likeLabelOnStarColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_likeLabelOnStarColor") ?? self.white
        } else {
            return self.white
        }
    }

    class func alt_likeLabelUnderStarColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_likeLabelUnderStarColor") ?? self.white
        } else {
            return self.white
        }
    }

    class func alt_scheduleAlertColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_scheduleAlertColor") ?? UIColor(rgbHex: 0x333333)
        } else {
            return UIColor(rgbHex: 0x333333)
        }
    }

    class func alt_waitingSpecialistBgColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_waitingSpecialistBgColor") ?? self.white
        } else {
            return self.white
        }
    }

    class func alt_waitingSpecialistBorderColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_waitingSpecialistBorderColor") ?? UIColor.clear
        } else {
            return UIColor.clear
        }
    }

    class func alt_waitingSpecialistSpinnerColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_waitingSpecialistSpinnerColor") ?? UIColor(rgbHex: 0x83B143)
        } else {
            return UIColor(rgbHex: 0x83B143)
        }
    }

    class func alt_specialisConnectTitleColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_specialisConnectTitleColor") ?? UIColor(rgbHex: 0x333333)
        } else {
            return UIColor(rgbHex: 0x333333)
        }
    }

    class func alt_specialisConnectSubtitleColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_specialisConnectSubtitleColor") ?? UIColor(rgbHex: 0x333333)
        } else {
            return UIColor(rgbHex: 0x333333)
        }
    }

    class func alt_sendButtonColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_sendButtonColor") ?? UIColor(rgbHex: 0x83B143)
        } else {
            return UIColor(rgbHex: 0x83B143)
        }
    }

    class func alt_sendButtonHighlightColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_sendButtonHighlightColor") ?? UIColor(argbHex:0xB283B143)
        } else {
            return UIColor(argbHex:0xB283B143)
        }
    }

    class func alt_sendButtonDisabledColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_sendButtonDisabledColor") ?? self.lightGray
        } else {
            return self.lightGray
        }
    }

    class func alt_attachButtonColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_attachButtonColor") ?? UIColor(rgbHex: 0x83B143)
        } else {
            return UIColor(rgbHex: 0x83B143)
        }
    }

    class func alt_attachButtonHighlightColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_attachButtonHighlightColor") ?? UIColor(argbHex:0xB283B143)
        } else {
            return UIColor(argbHex:0xB283B143)
        }
    }

    class func alt_toolbarTintColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_toolbarTintColor") ?? self.red
        } else {
            return self.red
        }
    }

    class func alt_toolbarQuotedMessageAuthorColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_toolbarQuotedMessageAuthorColor") ?? UIColor(rgbHex: 0x333333)
        } else {
            return UIColor(rgbHex: 0x333333)
        }
    }

    class func alt_toolbarQuotedMessageColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_toolbarQuotedMessageColor") ?? UIColor(argbHex:0x80333333)
        } else {
            return UIColor(argbHex:0x80333333)
        }
    }

    class func alt_photoPickerToolbarTintColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_photoPickerToolbarTintColor") ?? UIColor(rgbHex: 0x83B143)
        } else {
            return UIColor(rgbHex: 0x83B143)
        }
    }

    class func alt_photoPickerSheetTextColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_photoPickerSheetTextColor") ?? UIColor(rgbHex: 0x83B143)
        } else {
            return UIColor(rgbHex: 0x83B143)
        }
    }

    class func alt_emptyImageColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_emptyImageColor") ?? self.alt_middleGray()
        } else {
            return self.alt_middleGray()
        }
    }

    class func alt_refreshColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_refreshColor") ?? UIColor(rgbHex: 0x83B143)
        } else {
            return UIColor(rgbHex: 0x83B143)
        }
    }

    class func alt_scrollToBottomBadgeColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_scrollToBottomBadgeColor") ?? self.alt_red()
        } else {
            return self.alt_red()
        }
    }

    class func alt_scrollToBottomBadgeTextColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_scrollToBottomBadgeTextColor") ?? self.white
        } else {
            return self.white
        }
    }

    class func alt_typingTextColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_typingTextColor") ?? UIColor(argbHex:0x80333333)
        } else {
            return UIColor(argbHex:0x80333333)
        }
    }

    class func alt_placeholderTitleColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_placeholderTitleColor") ?? UIColor(argbHex:0xB2333333)
        } else {
            return UIColor(argbHex:0xB2333333)
        }
    }

    class func alt_placeholderSubtitleColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_placeholderSubtitleColor") ?? UIColor(argbHex:0x80333333)
        } else {
            return UIColor(argbHex:0x80333333)
        }
    }

    class func alt_searchScopeBarTintColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_searchScopeBarTintColor") ?? UIColor(rgbHex: 0x83B143)
        } else {
            return UIColor(rgbHex: 0x83B143)
        }
    }

    class func alt_searchBarTextColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_searchBarTextColor") ?? UIColor(rgbHex: 0x333333)
        } else {
            return UIColor(rgbHex: 0x333333)
        }
    }

    class func alt_searchBarTintColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_searchBarTintColor") ?? UIColor(rgbHex: 0x333333)
        } else {
            return UIColor(rgbHex: 0x333333)
        }
    }

    class func alt_searchMessageAuthorTextColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_searchMessageAuthorTextColor") ?? UIColor(rgbHex: 0x333333)
        } else {
            return UIColor(rgbHex: 0x333333)
        }
    }

    class func alt_searchMessageDateTextColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_searchMessageDateTextColor") ?? UIColor(argbHex:0xB333338B)
        } else {
            return UIColor(argbHex:0xB333338B)
        }
    }

    class func alt_searchMessageFileTextColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_searchMessageFileTextColor") ?? UIColor(argbHex:0xB333338B)
        } else {
            return UIColor(argbHex:0xB333338B)
        }
    }

    class func alt_searchMessageTextColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_searchMessageTextColor") ?? UIColor(argbHex:0xB333338B)
        } else {
            return UIColor(argbHex:0xB333338B)
        }
    }

    class func alt_searchMessageMatchTextColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_searchMessageMatchTextColor") ?? UIColor(rgbHex: 0x83B143)
        } else {
            return UIColor(rgbHex: 0x83B143)
        }
    }

    class func alt_findedMessageHeaderTextColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_findedMessageHeaderTextColor") ?? UIColor(argbHex:0x80333333)
        } else {
            return UIColor(argbHex:0x80333333)
        }
    }

    class func alt_findedMessageHeaderBackgroundColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_findedMessageHeaderBackgroundColor") ?? UIColor(rgbHex: 0xEAF0F0)
        } else {
            return UIColor(rgbHex: 0xEAF0F0)
        }
    }

    class func alt_findMoreMessageTextColor() -> UIColor {
        
        if #available(iOS 13.0, *) {
            return self.alt_named("alt_findMoreMessageTextColor") ?? UIColor(rgbHex: 0x333333)
        } else {
            return UIColor(rgbHex: 0x333333)
        }
    }

    class func alt_darkGreen() -> UIColor { return UIColor(rgbHex: 0x009688) }

    class func alt_lightGreen() -> UIColor { return UIColor(rgbHex: 0x25C281) }

    class func alt_gray() -> UIColor { return UIColor(rgbHex: 0x607D8B) }

    class func alt_lightGray() -> UIColor { return UIColor(rgbHex: 0xEFF3F8) }

    class func alt_middleGray() -> UIColor { return UIColor(rgbHex: 0xE6E6EC) }

    class func alt_darkGray() -> UIColor { return UIColor(rgbHex: 0xC7C7C7) }

    class func alt_darkerGray() -> UIColor { return UIColor(rgbHex: 0x333333) }

    class func alt_black_transparent_50() -> UIColor {
        return UIColor(argbHex: 0x80000000)
    }

    class func alt_lightCyan() -> UIColor { return UIColor(rgbHex: 0xB2DFDB) }

    class func alt_blue() -> UIColor { return UIColor(rgbHex: 0x3598DC) }

    class func alt_red() -> UIColor { return UIColor(rgbHex: 0xF44336) }

    class func alt_orange() -> UIColor { return UIColor(rgbHex: 0xFF9800) }

    class func alt_darkOrange() -> UIColor { return UIColor(rgbHex: 0xF7C16F) }

    class func alt_gold() -> UIColor {
        return UIColor(rgbHex: 0xFCC200)
    }


    
}
