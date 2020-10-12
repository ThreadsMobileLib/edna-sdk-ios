//
//  AttributesHelper.swift
//  ExampleSwift
//
//  Created by Brooma Service on 20.12.2019.
//  Copyright © 2019 Threads. All rights reserved.
//

import Foundation
import UIKit
import Threads

class AttributesHelper {
    
    class func getDefaultAttributes() -> THRAttributes {
        return THRAttributes.default()
    }
    
    class func getAltAttributes() -> THRAttributes {
        
        let attributes = THRAttributes.default()
        
        attributes.refreshColor = UIColor.alt_refresh()
        
        attributes.statusBarStyle = .default
        
        attributes.navigationBarTitleFont = .latoSemibold(ofSize: 18)
        attributes.navigationBarSubtitleFont = .latoSemibold(ofSize: 13)
        
        attributes.backgroundColor = UIColor.alt_mainBackground()
        
        attributes.placeholderImage = #imageLiteral(resourceName: "placeholder_image.png")
        attributes.placeholderTitleColor = UIColor.alt_placeholderTitle()
        attributes.placeholderSubtitleColor = UIColor.alt_placeholderSubtitle()
        attributes.placeholderTitleFont = .latoSemibold(ofSize: 19)
        attributes.placeholderSubtitleFont = .latoRegular(ofSize: 15)
        
        attributes.myMessageFont = .latoRegular(ofSize: 16)
        
        attributes.attachButtonColor = UIColor.alt_attachButton()
        attributes.attachButtonHighlightColor = UIColor.alt_attachButtonHighlight()
        
        attributes.sendButtonColor = UIColor.alt_sendButton()
        attributes.sendButtonHighlightColor = UIColor.alt_sendButtonHighlight()
        
        attributes.waitingSpecialistBorderColor = UIColor.alt_waitingSpecialistBorder()
        attributes.waitingSpecialistSpinnerColor = UIColor.alt_waitingSpecialistSpinner()
        
        attributes.outgoingBubbleColor = UIColor.alt_outgoingBubble()
        attributes.outgoingBubbleTextColor = UIColor.alt_outgoingBubbleText()
        attributes.outgoingBubbleLinkColor = UIColor.alt_outgoingBubbleLink()
        
        attributes.failedBubbleColor = UIColor.alt_failedBubble()
        attributes.failedMessageFont = .latoSemibold(ofSize: 12)
        
        attributes.incomingBubbleColor = UIColor.alt_incomingBubble()
        attributes.incomingBubbleTextColor = UIColor.alt_incomingBubbleText()
        attributes.incomingBubbleLinkColor = UIColor.alt_incomingBubbleLink()
        
        attributes.bubbleMessageFont = .latoRegular(ofSize: 17)
        attributes.bubbleTimeFont = .latoRegular(ofSize: 12)
        
        attributes.messageHeaderFont = .latoSemibold(ofSize: 13)
        
        attributes.specialisConnectTitleFont = .latoSemibold(ofSize: 17)
        attributes.specialisConnectSubtitleFont = .latoRegular(ofSize: 12)
        attributes.specialisConnectTitleColor = UIColor.alt_specialisConnectTitle()
        attributes.specialisConnectSubtitleColor = UIColor.alt_specialisConnectSubtitle()
        
        attributes.toolbarTintColor = UIColor.alt_toolbarTint()
        attributes.toolbarQuotedMessageAuthorColor = UIColor.alt_toolbarQuotedMessageAuthor()
        attributes.toolbarQuotedMessageColor = UIColor.alt_toolbarQuotedMessage()
        attributes.toolbarQuotedMessageAuthorFont = .latoRegular(ofSize: 17)
        attributes.toolbarQuotedMessageFont = .latoRegular(ofSize: 17)
        
        attributes.quoteAuthorFont = .latoSemibold(ofSize: 17)
        attributes.quoteMessageFont = .latoLight(ofSize: 17)
        attributes.quoteFilesizeFont = .latoRegular(ofSize: 13)
        attributes.quoteTimeFont = .latoRegular(ofSize: 13)
        
        attributes.outgoingQuoteSeparatorColor = UIColor.alt_outgoingQuoteSeparator()
        attributes.outgoingQuoteAuthorColor = UIColor.alt_outgoingQuoteAuthor()
        attributes.outgoingQuoteMessageColor = UIColor.alt_outgoingQuoteMessage()
        attributes.outgoingQuoteTimeColor = UIColor.alt_outgoingQuoteTime()
        attributes.outgoingQuoteFilesizeColor = UIColor.alt_outgoingQuoteFilesize()
        
        attributes.incomingQuoteSeparatorColor = UIColor.alt_incomingQuoteSeparator()
        attributes.incomingQuoteAuthorColor = UIColor.alt_incomingQuoteAuthor()
        attributes.incomingQuoteMessageColor = UIColor.alt_incomingQuoteMessage()
        attributes.incomingQuoteTimeColor = UIColor.alt_incomingQuoteTime()
        attributes.incomingQuoteFilesizeColor = UIColor.alt_incomingQuoteFilesize()
        attributes.incomingFileIconTintColor = UIColor.alt_incomingFileIconTint()
        attributes.incomingFileIconBgColor = UIColor.alt_incomingFileIconBg()
        
        attributes.clearSearchIcon = #imageLiteral(resourceName: "ic_clear_search.png")
        attributes.searchBarTintColor = UIColor.alt_searchBarTint()
        attributes.searchBarTextColor = UIColor.alt_searchBarText()
        attributes.searchScopeBarTintColor = UIColor.alt_searchScopeBarTint()
        attributes.searchBarTextFont = .latoRegular(ofSize: 14)
        attributes.searchScopeBarFont = .latoRegular(ofSize: 13)
        
        attributes.findedMessageHeaderTextColor = UIColor.alt_findedMessageHeaderText()
        attributes.findedMessageHeaderBackgroundColor = UIColor.alt_findedMessageHeaderBackground()
        attributes.findedMessageHeaderTextFont = .latoRegular(ofSize: 13)
        attributes.findMoreMessageTextColor = UIColor.alt_findMoreMessageText()
        attributes.findMoreMessageTextFont = .latoRegular(ofSize: 15)
        
        attributes.searchMessageAuthorTextColor = UIColor.alt_searchMessageAuthorText()
        attributes.searchMessageTextColor = UIColor.alt_searchMessageText()
        attributes.searchMessageDateTextColor = UIColor.alt_searchMessageDateText()
        attributes.searchMessageFileTextColor = UIColor.alt_searchMessageFileText()
        attributes.searchMessageMatchTextColor = UIColor.alt_searchMessageMatchText()
        attributes.searchMessageAuthorTextFont = .latoRegular(ofSize: 17)
        attributes.searchMessageTextFont = .latoRegular(ofSize: 13)
        attributes.searchMessageFileTextFont = .latoRegular(ofSize: 13)
        attributes.searchMessageDateTextFont = .latoRegular(ofSize: 13)
        attributes.searchMessageMatchTextFont = .latoRegular(ofSize: 13)
        
        attributes.photoPickerSelfieEnabled = true
        attributes.photoPickerCheckmarkIcon = #imageLiteral(resourceName: "ic_checkmark.png")
        attributes.photoPickerToolbarTintColor = UIColor.alt_photoPickerToolbarTint()
        attributes.photoPickerToolbarButtonFont = .latoRegular(ofSize: 17)
        attributes.photoPickerSheetTextColor = UIColor.alt_photoPickerSheetText()
        attributes.photoPickerSheetTextFont = .latoRegular(ofSize: 17)
        
        attributes.fileViewerTitleFont = attributes.navigationBarTitleFont;
        
        attributes.sendButtonFont = .latoRegular(ofSize: 17)
        
        attributes.messageBubbleFilledMaskImage = #imageLiteral(resourceName: "rect_bubble_filled.png")
        attributes.messageBubbleStrokedMaskImage = #imageLiteral(resourceName: "rect_bubble_stroked.png")
        
        attributes.typingText = NSLocalizedString("typing...", comment: "");
        attributes.typingTextColor = UIColor.alt_typingText()
        attributes.typingTextFont = .latoMedium(ofSize: 13)
        
        attributes.scheduleIcon = #imageLiteral(resourceName:"schedule_alert")
        attributes.scheduleAlertFont = .latoSemibold(ofSize: 17)
        attributes.scheduleAlertColor = UIColor.alt_scheduleAlert()
        
        attributes.scrollToBottomImage = #imageLiteral(resourceName: "alt_scroll_down_button")
        
        attributes.surveyTextFont = .latoRegular(ofSize: 17)
        attributes.surveyTextColor = UIColor.alt_surveyText()
        attributes.surveyCompletionFont = .latoRegular(ofSize: 17)
        attributes.surveyCompletionColor = UIColor.alt_surveyCompletion()
        
        attributes.iconLikeFull = #imageLiteral(resourceName:"ic_like_filled").withRenderingMode(.alwaysTemplate)
        attributes.iconLikeEmpty = #imageLiteral(resourceName:"ic_like_stroked").withRenderingMode(.alwaysTemplate)
        attributes.iconDislikeFull = #imageLiteral(resourceName:"ic_dislike_filled").withRenderingMode(.alwaysTemplate)
        attributes.iconDislikeEmpty = #imageLiteral(resourceName:"ic_dislike_stroked").withRenderingMode(.alwaysTemplate)
        attributes.iconStarRatingFull = #imageLiteral(resourceName:"ic_heart_filled").withRenderingMode(.alwaysTemplate)
        attributes.iconStarRatingEmty = #imageLiteral(resourceName:"ic_heart_stroked").withRenderingMode(.alwaysTemplate)
        
        attributes.likeRatingColorEnabled = UIColor.alt_likeRatingColorEnabled()
        attributes.likeRatingColorDisabled = UIColor.alt_likeRatingColorDisabled()
        attributes.starRatingColorEnabled = UIColor.alt_starRatingColorEnabled()
        attributes.starRatingColorDisabled = UIColor.alt_starRatingColorDisabled()
        attributes.likeRatingColorCompleted = UIColor.alt_likeRatingColorCompleted()
        attributes.starRatingColorCompleted = UIColor.alt_starRatingColorCompleted()
        
        attributes.quickRepliesBlockInput = false
        attributes.quickReplyFont = .latoSemibold(ofSize: 20)
        attributes.quickReplyBorderCornerRadius = 0;
        attributes.quickReplyBorderColor = UIColor.alt_quickReplyBorder()
        attributes.quickReplyTextColor = UIColor.alt_quickReplyText()
        attributes.quickReplyTextColorHighLighted = UIColor.alt_quickReplyTextColorHighLighted()
        attributes.quickReplyBackgroundColor = UIColor.alt_quickReplyBackground()
        attributes.quickReplyBackgroundColorHighlighted = UIColor.alt_quickReplyBackgroundColorHighlighted()
        
        attributes.navigationBarSubtitleShowOrgUnit = true
        attributes.showWaitingForSpecialistProgress = false
        attributes.canShowSpecialistInfo = false
        attributes.navigationBarVisible = true
        
        attributes.historyLoadingCount = 25;
        
        return attributes
    }
}
