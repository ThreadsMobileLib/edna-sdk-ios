//
//  IntegrationsViewController+BRS.swift
//  ExampleSwift
//
//  Created by Vitaliy Kuzmenko on 12/08/2019.
//  Copyright © 2019 Threads. All rights reserved.
//

import UIKit
import Threads

extension UIColor {
 
    fileprivate static let brsTint = #colorLiteral(red:0.513, green:0.694, blue:0.262, alpha:1.0)
    
    fileprivate static let brsBackground = #colorLiteral(red: 0.917, green:0.941, blue:0.941, alpha:1.0)
    
    fileprivate static let brsColor3 = UIColor(white: 0.2, alpha: 0.7)
    
    fileprivate static let brsColor4 = UIColor(white: 0.2, alpha: 0.5)
    
    fileprivate static let brsColor5 = #colorLiteral(red: 0.957, green: 0.262, blue: 0.211, alpha: 1)
    
}

extension UIFont {
 
    fileprivate static func latoRegular(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Lato-Regular", size: fontSize)!
    }
    
    fileprivate static func latoSemibold(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Lato-Semibold", size: fontSize)!
    }
    
    fileprivate static func latoLight(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Lato-Light", size: fontSize)!
    }
    
    fileprivate static func latoMedium(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Lato-Medium", size: fontSize)!
    }
    
}

extension IntegrationsViewController {
    
    func getBRSAttributes() -> THRAttributes {
        let attributes = THRAttributes()
        
        attributes.refreshColor = .brsTint
        attributes.statusBarStyle = .default
        
        attributes.navigationBarTitleFont = .latoSemibold(ofSize: 18)
        attributes.navigationBarSubtitleFont = .latoSemibold(ofSize: 13)
        
        attributes.backgroundColor = .brsBackground
        
        attributes.placeholderImage = #imageLiteral(resourceName: "placeholder_image.png")
        attributes.placeholderTitleColor = .brsColor3
        attributes.placeholderSubtitleColor = .brsColor4
        attributes.placeholderTitleFont = .latoSemibold(ofSize: 19)
        attributes.placeholderSubtitleFont = .latoRegular(ofSize: 15)
        
        attributes.myMessageFont = .latoRegular(ofSize: 16)
        
        attributes.attachButtonColor = .brsTint
        attributes.attachButtonHighlightColor = UIColor.brsTint.withAlphaComponent(0.7)
        
        attributes.sendButtonColor = .brsTint
        attributes.sendButtonHighlightColor = UIColor.brsTint.withAlphaComponent(0.7)
        
        attributes.waitingSpecialistBorderColor = .clear
        attributes.waitingSpecialistSpinnerColor = .brsTint
        
        attributes.outgoingBubbleColor = .brsTint
        attributes.outgoingBubbleTextColor = .white
        attributes.outgoingBubbleLinkColor = .blue
        
        attributes.failedBubbleColor = .brsColor5
        attributes.incomingBubbleTextColor = .brsColor4
        attributes.incomingBubbleLinkColor = .brsTint
        
        attributes.bubbleMessageFont = .latoRegular(ofSize: 17)
        attributes.bubbleTimeFont = .latoRegular(ofSize: 12)
        
        attributes.failedMessageFont = .latoSemibold(ofSize: 12)
        attributes.messageHeaderFont = .latoSemibold(ofSize: 13)
        
        attributes.specialisConnectTitleFont = .latoSemibold(ofSize: 17)
        attributes.specialisConnectSubtitleFont = .latoRegular(ofSize: 12)
        attributes.specialisConnectTitleColor = .brsColor4
        attributes.specialisConnectSubtitleColor = .brsColor4
        
        attributes.toolbarTintColor = .red
        attributes.toolbarQuotedMessageAuthorColor = .brsColor4
        attributes.toolbarQuotedMessageColor = .brsColor4
        attributes.toolbarQuotedMessageAuthorFont = .latoRegular(ofSize: 17)
        attributes.toolbarQuotedMessageFont = .latoRegular(ofSize: 17)
        
        attributes.quoteAuthorFont = .latoSemibold(ofSize: 17)
        attributes.quoteMessageFont = .latoLight(ofSize: 17)
        attributes.quoteFilesizeFont = .latoRegular(ofSize: 13)
        attributes.quoteTimeFont = .latoRegular(ofSize: 13)
        
        attributes.outgoingQuoteSeparatorColor = .white
        attributes.outgoingQuoteAuthorColor = .white
        attributes.outgoingQuoteMessageColor = .white
        attributes.outgoingQuoteTimeColor = .white
        attributes.outgoingQuoteFilesizeColor = .white
        
        attributes.incomingQuoteSeparatorColor = .brsTint
        attributes.incomingQuoteAuthorColor = .brsColor4
        attributes.incomingQuoteMessageColor = .brsColor3
        attributes.incomingQuoteTimeColor = .brsColor3
        attributes.incomingQuoteFilesizeColor = .brsColor3
        attributes.incomingFileIconTintColor = .brsTint
        attributes.incomingFileIconBgColor = .brsBackground
        
        attributes.clearSearchIcon = #imageLiteral(resourceName: "ic_clear_search.png")
        attributes.searchBarTintColor = .brsColor4
        attributes.searchBarTextColor = .brsColor4
        attributes.searchScopeBarTintColor = .brsTint
        attributes.searchBarTextFont = .latoRegular(ofSize: 14)
        attributes.searchScopeBarFont = .latoRegular(ofSize: 13)
        
        attributes.findedMessageHeaderTextColor = .brsColor4
        attributes.findedMessageHeaderBackgroundColor = .brsBackground
        attributes.findedMessageHeaderTextFont = .latoRegular(ofSize: 13)
        attributes.findMoreMessageTextColor = .brsColor4
        attributes.findMoreMessageTextFont = .latoRegular(ofSize: 15)
        
        attributes.searchMessageAuthorTextColor = .brsColor4
        attributes.searchMessageTextColor = .brsColor3
        attributes.searchMessageDateTextColor = .brsColor3
        attributes.searchMessageFileTextColor = .brsColor3
        attributes.searchMessageMatchTextColor = .brsTint
        attributes.searchMessageAuthorTextFont = .latoRegular(ofSize: 17)
        attributes.searchMessageTextFont = .latoRegular(ofSize: 13)
        attributes.searchMessageFileTextFont = .latoRegular(ofSize: 13)
        attributes.searchMessageDateTextFont = .latoRegular(ofSize: 13)
        attributes.searchMessageMatchTextFont = .latoRegular(ofSize: 13)
        
        attributes.photoPickerSelfieEnabled = true
        attributes.photoPickerCheckmarkIcon = #imageLiteral(resourceName: "ic_checkmark.png")
        attributes.photoPickerToolbarTintColor = .brsTint
        attributes.photoPickerToolbarButtonFont = .latoRegular(ofSize: 17)
        attributes.photoPickerSheetTextColor = .brsTint
        attributes.photoPickerSheetTextFont = .latoRegular(ofSize: 17)
        
        attributes.fileViewerTitleFont = attributes.navigationBarTitleFont;
        
        attributes.sendButtonFont = .latoRegular(ofSize: 17)
        
        attributes.messageBubbleFilledMaskImage = #imageLiteral(resourceName: "rect_bubble_filled.png")
        attributes.messageBubbleStrokedMaskImage = #imageLiteral(resourceName: "rect_bubble_stroked.png")
        
        attributes.typingText = NSLocalizedString("typing...", comment: "");
        attributes.typingTextColor = .brsColor4
        attributes.typingTextFont = .latoMedium(ofSize: 13)
        
        attributes.scheduleIcon = #imageLiteral(resourceName:"schedule_alert")
        attributes.scheduleAlertFont = .latoSemibold(ofSize: 17)
        attributes.scheduleAlertColor = .brsColor4
        
        attributes.scrollToBottomImage = #imageLiteral(resourceName:"scroll_down_button_brs")
        
        attributes.surveyTextFont = .latoRegular(ofSize: 17)
        attributes.surveyTextColor = .brsTint
        attributes.surveyCompletionFont = .latoRegular(ofSize: 17)
        attributes.surveyCompletionColor = .brsTint
        
        attributes.iconLikeFull = #imageLiteral(resourceName:"ic_like_filled").withRenderingMode(.alwaysTemplate)
        attributes.iconLikeEmpty = #imageLiteral(resourceName:"ic_like_stroked").withRenderingMode(.alwaysTemplate)
        attributes.iconDislikeFull = #imageLiteral(resourceName:"ic_dislike_filled").withRenderingMode(.alwaysTemplate)
        attributes.iconDislikeEmpty = #imageLiteral(resourceName:"ic_dislike_stroked").withRenderingMode(.alwaysTemplate)
        attributes.iconStarRatingFull = #imageLiteral(resourceName:"ic_heart_filled").withRenderingMode(.alwaysTemplate)
        attributes.iconStarRatingEmty = #imageLiteral(resourceName:"ic_heart_stroked").withRenderingMode(.alwaysTemplate)
        
        attributes.likeRatingColorEnabled = .brsTint
        attributes.likeRatingColorDisabled = .brsTint
        attributes.starRatingColorEnabled = .red
        attributes.starRatingColorDisabled = .red
        attributes.likeRatingColorCompleted = .yellow
        attributes.starRatingColorCompleted = .red
        
        attributes.navigationBarSubtitleShowOrgUnit = true
        attributes.showWaitingForSpecialistProgress = false
        attributes.canShowSpecialistInfo = false
        attributes.navigationBarVisible = true
        
        attributes.historyLoadingCount = 25;
        
        return attributes
    }
    
}
