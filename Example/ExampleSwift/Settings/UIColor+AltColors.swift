//
//  UIColor+AltColors.swift
//  ExampleSwift
//
//  Created by Brooma Service on 23.04.2020.
//  Copyright © 2020 Threads. All rights reserved.
//

import Foundation

extension UIColor {

    public class func alt_mainBackground() -> UIColor {
        return ColorCompatibility.systemGray6Color()
    }

    public class func alt_incomingBubble() -> UIColor {
        return UIColor.named( "alt_incomingBubbleColor", fallback: UIColor.white)
    }

    public class func alt_incomingBubbleText() -> UIColor {
        return UIColor.named( "alt_incomingBubbleTextColor", fallback: UIColor.init(rgb: 0x333333))
    }

    public class func alt_incomingTime() -> UIColor {
        return UIColor.named( "alt_incomingTimeColor", fallback: UIColor.black)
    }

    public class func alt_incomingMediaTime() -> UIColor {
        return UIColor.named( "alt_incomingMediaTimeColor", fallback: UIColor.white)
    }

    public class func alt_incomingBubbleLink() -> UIColor {
        return UIColor.named( "alt_incomingBubbleLinkColor", fallback: UIColor.alt_green())
    }

    public class func alt_outgoingBubble() -> UIColor {
        return UIColor.named( "alt_outgoingBubbleColor", fallback: UIColor.alt_green())
    }

    public class func alt_outgoingBubbleText() -> UIColor {
        return UIColor.named( "alt_outgoingBubbleTextColor", fallback: UIColor.white)
    }

    public class func alt_outgoingTime() -> UIColor {
        return UIColor.named( "alt_outgoingTimeColor", fallback: UIColor.white)
    }

    public class func alt_outgoingMediaTime() -> UIColor {
        return UIColor.named( "alt_outgoingMediaTimeColor", fallback: UIColor.white)
    }

    public class func alt_outgoingBubbleLink() -> UIColor {
        return UIColor.named( "alt_outgoingBubbleLinkColor", fallback: UIColor.blue)
    }

    public class func alt_outgoingPendingStatus() -> UIColor {
        return UIColor.named( "alt_outgoingPendingStatusColor", fallback: UIColor.white)
    }

    public class func alt_outgoingDeliveredStatus() -> UIColor {
        return UIColor.named( "alt_outgoingDeliveredStatusColor", fallback: UIColor.white)
    }

    public class func alt_outgoingReadStatus() -> UIColor {
        return UIColor.named( "alt_outgoingReadStatusColor", fallback: UIColor.white)
    }

    public class func alt_outgoingMediaPendingStatus() -> UIColor {
        return UIColor.named( "alt_outgoingMediaPendingStatusColor", fallback: UIColor.white)
    }

    public class func alt_outgoingMediaDeliveredStatus() -> UIColor {
        return UIColor.named( "alt_outgoingMediaDeliveredStatusColor", fallback: UIColor.white)
    }

    public class func alt_outgoingMediaReadStatus() -> UIColor {
        return UIColor.named( "alt_outgoingMediaReadStatusColor", fallback: UIColor.white)
    }

    public class func alt_timeAndStatusBackground() -> UIColor {
        return UIColor.named( "alt_timeAndStatusBackgroundColor", fallback: UIColor.alt_black_transparent_50())
    }

    public class func alt_incomingFileIconBg() -> UIColor {
        return ColorCompatibility.systemGray5Color()
    }

    public class func alt_incomingFileIconTint() -> UIColor {
        return UIColor.named( "alt_incomingFileIconTintColor", fallback: UIColor.alt_green())
    }

    public class func alt_outgoingFileIconBg() -> UIColor {
        return ColorCompatibility.systemGray5Color()
    }

    public class func alt_outgoingFileIconTint() -> UIColor {
        return UIColor.named( "alt_outgoingFileIconTintColor", fallback: UIColor.alt_green())
    }

    public class func alt_failedBubble() -> UIColor {
        return UIColor.named( "alt_failedBubbleColor", fallback: UIColor.init(rgb: 0xF44336))
    }

    public class func alt_outgoingQuoteAuthor() -> UIColor {
        return UIColor.named( "alt_outgoingQuoteAuthorColor", fallback: UIColor.white)
    }

    public class func alt_incomingQuoteAuthor() -> UIColor {
        return UIColor.named( "alt_incomingQuoteAuthorColor", fallback: UIColor.init(rgb: 0x333333))
    }

    public class func alt_outgoingQuoteMessage() -> UIColor {
        return UIColor.named( "alt_outgoingQuoteMessageColor", fallback: UIColor.white)
    }

    public class func alt_incomingQuoteMessage() -> UIColor {
        return UIColor.named( "alt_incomingQuoteMessageColor", fallback: UIColor.init(argb: 0xB333338B))
    }

    public class func alt_outgoingQuoteTime() -> UIColor {
        return UIColor.named( "alt_outgoingQuoteTimeColor", fallback: UIColor.white)
    }

    public class func alt_incomingQuoteTime() -> UIColor {
        return UIColor.named( "alt_incomingQuoteTimeColor", fallback: UIColor.init(argb: 0xB333338B))
    }

    public class func alt_outgoingQuoteSeparator() -> UIColor {
        return UIColor.named( "alt_outgoingQuoteSeparatorColor", fallback: UIColor.white)
    }

    public class func alt_incomingQuoteSeparator() -> UIColor {
        return UIColor.named( "alt_incomingQuoteSeparatorColor", fallback: UIColor.alt_green())
    }

    public class func alt_outgoingQuoteFilesize() -> UIColor {
        return UIColor.named( "alt_outgoingQuoteFilesizeColor", fallback: UIColor.white)
    }

    public class func alt_incomingQuoteFilesize() -> UIColor {
        return UIColor.named( "alt_incomingQuoteFilesizeColor", fallback: UIColor.init(argb: 0xB333338B))
    }

    public class func alt_surveyText() -> UIColor {
        return UIColor.named( "alt_surveyTextColor", fallback: UIColor.alt_green())
    }

    public class func alt_likeRatingColorEnabled() -> UIColor {
        return UIColor.named( "alt_likeRatingColorEnabled", fallback: UIColor.alt_green())
    }

    public class func alt_likeRatingColorDisabled() -> UIColor {
        return UIColor.named( "alt_likeRatingColorDisabled", fallback: UIColor.alt_green())
    }

    public class func alt_starRatingColorEnabled() -> UIColor {
        return UIColor.named( "alt_starRatingColorEnabled", fallback: UIColor.red)
    }

    public class func alt_starRatingColorDisabled() -> UIColor {
        return UIColor.named( "alt_starRatingColorDisabled", fallback: UIColor.red)
    }

    public class func alt_surveyCompletion() -> UIColor {
        return UIColor.named( "alt_surveyCompletionColor", fallback: UIColor.alt_green())
    }

    public class func alt_starRatingColorCompleted() -> UIColor {
        return UIColor.named( "alt_starRatingColorCompleted", fallback: UIColor.red)
    }

    public class func alt_likeRatingColorCompleted() -> UIColor {
        return UIColor.named( "alt_likeRatingColorCompleted", fallback: UIColor.yellow)
    }

    public class func alt_likeLabelOnStar() -> UIColor {
        return UIColor.named( "alt_likeLabelOnStarColor", fallback: UIColor.white)
    }

    public class func alt_likeLabelUnderStar() -> UIColor {
        return UIColor.named( "alt_likeLabelUnderStarColor", fallback: UIColor.white)
    }

    public class func alt_quickReplyBackground() -> UIColor {
        return UIColor.named( "alt_quickReplyBackgroundColor", fallback: UIColor.alt_green())
    }

    public class func alt_quickReplyBackgroundColorHighlighted() -> UIColor {
        return UIColor.named( "alt_quickReplyBackgroundColorHighlighted", fallback: UIColor.alt_darkGreen())
    }

    public class func alt_quickReplyBorder() -> UIColor {
        return UIColor.named( "alt_quickReplyBorderColor", fallback: UIColor.alt_green())
    }

    public class func alt_quickReplyText() -> UIColor {
        return UIColor.named( "alt_quickReplyTextColor", fallback: UIColor.white)
    }

    public class func alt_quickReplyTextColorHighLighted() -> UIColor {
        return UIColor.named( "alt_quickReplyTextColorHighLighted", fallback: UIColor.white)
    }

    public class func alt_scheduleAlert() -> UIColor {
        return UIColor.named( "alt_scheduleAlertColor", fallback: UIColor.init(rgb: 0x333333))
    }

    public class func alt_waitingSpecialistBg() -> UIColor {
        return UIColor.named( "alt_waitingSpecialistBgColor", fallback: UIColor.white)
    }

    public class func alt_waitingSpecialistBorder() -> UIColor {
        return UIColor.named( "alt_waitingSpecialistBorderColor", fallback: UIColor.clear)
    }

    public class func alt_waitingSpecialistSpinner() -> UIColor {
        return UIColor.named( "alt_waitingSpecialistSpinnerColor", fallback: UIColor.alt_green())
    }

    public class func alt_specialisConnectTitle() -> UIColor {
        return UIColor.named( "alt_specialisConnectTitleColor", fallback: UIColor.init(rgb: 0x333333))
    }

    public class func alt_specialisConnectSubtitle() -> UIColor {
        return UIColor.named( "alt_specialisConnectSubtitleColor", fallback: UIColor.init(rgb: 0x333333))
    }

    public class func alt_sendButton() -> UIColor {
        return UIColor.named( "alt_sendButtonColor", fallback: UIColor.alt_green())
    }

    public class func alt_sendButtonHighlight() -> UIColor {
        return UIColor.named( "alt_sendButtonHighlightColor", fallback: UIColor.init(argb: 0xB283B143))
    }

    public class func alt_sendButtonDisabled() -> UIColor {
        return UIColor.named( "alt_sendButtonDisabledColor", fallback: UIColor.lightGray)
    }

    public class func alt_attachButton() -> UIColor {
        return UIColor.named( "alt_attachButtonColor", fallback: UIColor.alt_green())
    }

    public class func alt_attachButtonHighlight() -> UIColor {
        return UIColor.named( "alt_attachButtonHighlightColor", fallback: UIColor.init(argb: 0xB283B143))
    }

    public class func alt_toolbarTint() -> UIColor {
        return UIColor.named( "alt_toolbarTintColor", fallback: UIColor.red)
    }

    public class func alt_toolbarQuotedMessageAuthor() -> UIColor {
        return UIColor.named( "alt_toolbarQuotedMessageAuthorColor", fallback: UIColor.init(rgb: 0x333333))
    }

    public class func alt_toolbarQuotedMessage() -> UIColor {
        return UIColor.named( "alt_toolbarQuotedMessageColor", fallback: UIColor.init(argb: UInt(0x803333330 as Int64)))
    }

    public class func alt_photoPickerToolbarTint() -> UIColor {
        return UIColor.named( "alt_photoPickerToolbarTintColor", fallback: UIColor.alt_green())
    }

    public class func alt_photoPickerSheetText() -> UIColor {
        return UIColor.named( "alt_photoPickerSheetTextColor", fallback: UIColor.alt_green())
    }

    public class func alt_emptyImage() -> UIColor {
        return UIColor.named( "alt_emptyImageColor", fallback:  UIColor.alt_middleGray())
    }

    public class func alt_refresh() -> UIColor {
        return UIColor.named( "alt_refreshColor", fallback: UIColor.alt_green())
    }

    public class func alt_scrollToBottomBadge() -> UIColor {
        return UIColor.named( "alt_scrollToBottomBadgeColor", fallback: UIColor.alt_red())
    }

    public class func alt_scrollToBottomBadgeText() -> UIColor {
        return UIColor.named( "alt_scrollToBottomBadgeTextColor", fallback: UIColor.white)
    }

    public class func alt_typingText() -> UIColor {
        return UIColor.named( "alt_typingTextColor", fallback: UIColor.init(argb: UInt(0x803333330 as Int64)))
    }

    public class func alt_placeholderTitle() -> UIColor {
        return UIColor.named( "alt_placeholderTitleColor", fallback: UIColor.init(argb: 0xB2333333))
    }

    public class func alt_placeholderSubtitle() -> UIColor {
        return UIColor.named( "alt_placeholderSubtitleColor", fallback: UIColor.init(argb: 0x80333333))
    }

    public class func alt_searchScopeBarTint() -> UIColor {
        return UIColor.named( "alt_searchScopeBarTintColor", fallback: UIColor.alt_green())
    }

    public class func alt_searchBarText() -> UIColor {
        return UIColor.named( "alt_searchBarTextColor", fallback: UIColor.init(rgb: 0x333333))
    }

    public class func alt_searchBarTint() -> UIColor {
        return UIColor.named( "alt_searchBarTintColor", fallback: UIColor.init(rgb: 0x333333))
    }

    public class func alt_searchMessageAuthorText() -> UIColor {
        return UIColor.named( "alt_searchMessageAuthorTextColor", fallback: UIColor.init(rgb: 0x333333))
    }

    public class func alt_searchMessageDateText() -> UIColor {
        return UIColor.named( "alt_searchMessageDateTextColor", fallback: UIColor.init(argb: 0xB333338B))
    }

    public class func alt_searchMessageFileText() -> UIColor {
        return UIColor.named( "alt_searchMessageFileTextColor", fallback: UIColor.init(argb: 0xB333338B))
    }

    public class func alt_searchMessageText() -> UIColor {
        return UIColor.named( "alt_searchMessageTextColor", fallback: UIColor.init(argb: 0xB333338B))
    }

    public class func alt_searchMessageMatchText() -> UIColor {
        return UIColor.named( "alt_searchMessageMatchTextColor", fallback: UIColor.alt_green())
    }

    public class func alt_findedMessageHeaderText() -> UIColor {
        return UIColor.named( "alt_findedMessageHeaderTextColor", fallback: UIColor.init(argb: UInt(0x803333330 as Int64)))
    }

    public class func alt_findedMessageHeaderBackground() -> UIColor {
        return UIColor.named( "alt_findedMessageHeaderBackgroundColor", fallback: UIColor.init(rgb: 0xEAF0F0))
    }

    public class func alt_findMoreMessageText() -> UIColor {
        return UIColor.named( "alt_findMoreMessageTextColor", fallback: UIColor.init(rgb: 0x333333))
    }

    public class func alt_green() -> UIColor {return UIColor.init(rgb: 0x83B143) }

    public class func alt_darkGreen() -> UIColor { return UIColor.init(rgb: 0x4F8E28) }

    public class func alt_lightGreen() -> UIColor { return UIColor.init(rgb: 0x25C281) }

    public class func alt_gray() -> UIColor { return UIColor.init(rgb: 0x607D8B) }

    public class func alt_lightGray() -> UIColor { return UIColor.init(rgb: 0xEFF3F8) }

    public class func alt_middleGray() -> UIColor { return UIColor.init(rgb: 0xE6E6EC) }

    public class func alt_darkGray() -> UIColor { return UIColor.init(rgb: 0xC7C7C7) }

    public class func alt_darkerGray() -> UIColor { return UIColor.init(rgb: 0x333333) }

    public class func alt_black_transparent_50() -> UIColor {
        return UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
    }

    public class func alt_lightCyan() -> UIColor { return UIColor.init(rgb: 0xB2DFDB) }

    public class func alt_blue() -> UIColor { return UIColor.init(rgb: 0x3598DC) }

    public class func alt_red() -> UIColor { return UIColor.init(rgb: 0xF44336) }

    public class func alt_orange() -> UIColor { return UIColor.init(rgb: 0xFF9800) }

    public class func alt_darkOrange() -> UIColor { return UIColor.init(rgb: 0xF7C16F) }

    public class func alt_gold() -> UIColor {
        return UIColor.init(rgb: 0xFCC200)
    }
    
}
