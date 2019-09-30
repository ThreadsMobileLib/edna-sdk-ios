//
//  UIColor+THRColor.h
//  Threads
//
//  Created by Nikolay Kagala on 31/05/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
                 blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
                alpha:1.0]

#define UIColorFromARGB(argbValue) \
[UIColor colorWithRed:((float)((argbValue & 0x00FF0000) >> 16))/255.0 \
                green:((float)((argbValue & 0x0000FF00) >>  8))/255.0 \
                 blue:((float)((argbValue & 0x000000FF) >>  0))/255.0 \
                alpha:((float)((argbValue & 0xFF000000) >> 24))/255.0]

@interface UIColor (AltColor)

#pragma mark - Convenience

+ (UIColor*) alt_mainBackgroundColor;

+ (UIColor*) alt_navigationBarBackgroundColor;

+ (UIColor*) alt_navigationBarTintColor;

+ (UIColor*) alt_incomingBubbleColor;

+ (UIColor*) alt_incomingBubbleTextColor;

+ (UIColor*) alt_incomingTimeColor;

+ (UIColor*) alt_incomingMediaTimeColor;

+ (UIColor*) alt_incomingBubbleLinkColor;

+ (UIColor*) alt_outgoingBubbleColor;

+ (UIColor*) alt_outgoingBubbleTextColor;

+ (UIColor*) alt_outgoingTimeColor;

+ (UIColor*) alt_outgoingMediaTimeColor;

+ (UIColor*) alt_outgoingBubbleLinkColor;

+ (UIColor*) alt_outgoingPendingStatusColor;

+ (UIColor*) alt_outgoingDeliveredStatusColor;

+ (UIColor*) alt_outgoingReadStatusColor;

+ (UIColor*) alt_outgoingMediaPendingStatusColor;

+ (UIColor*) alt_outgoingMediaDeliveredStatusColor;

+ (UIColor*) alt_outgoingMediaReadStatusColor;

+ (UIColor*) alt_timeAndStatusBackgroundColor;

+ (UIColor*) alt_incomingFileIconBgColor;

+ (UIColor*) alt_incomingFileIconTintColor;

+ (UIColor*) alt_outgoingFileIconBgColor;

+ (UIColor*) alt_outgoingFileIconTintColor;

+ (UIColor*) alt_failedBubbleColor;

+ (UIColor*) alt_incomingQuoteAuthorColor;

+ (UIColor*) alt_incomingQuoteMessageColor;

+ (UIColor*) alt_incomingQuoteSeparatorColor;

+ (UIColor*) alt_incomingQuoteTimeColor;

+ (UIColor*) alt_incomingQuoteFilesizeColor;

+ (UIColor*) alt_outgoingQuoteAuthorColor;

+ (UIColor*) alt_outgoingQuoteMessageColor;

+ (UIColor*) alt_outgoingQuoteSeparatorColor;

+ (UIColor*) alt_outgoingQuoteTimeColor;

+ (UIColor*) alt_outgoingQuoteFilesizeColor;

+ (UIColor*) alt_surveyTextColor;

+ (UIColor*) alt_likeRatingColorEnabled;

+ (UIColor*) alt_likeRatingColorDisabled;

+ (UIColor*) alt_starRatingColorEnabled;

+ (UIColor*) alt_starRatingColorDisabled;

+ (UIColor*) alt_surveyCompletionColor;

+ (UIColor*) alt_starRatingColorCompleted;

+ (UIColor*) alt_likeRatingColorCompleted;

+ (UIColor*) alt_likeLabelOnStarColor;

+ (UIColor*) alt_likeLabelUnderStarColor;

+ (UIColor*) alt_scheduleAlertColor;

+ (UIColor*) alt_waitingSpecialistBgColor;

+ (UIColor*) alt_waitingSpecialistBorderColor;

+ (UIColor*) alt_waitingSpecialistSpinnerColor;

+ (UIColor*) alt_specialisConnectTitleColor;

+ (UIColor*) alt_specialisConnectSubtitleColor;

+ (UIColor*) alt_sendButtonColor;

+ (UIColor*) alt_sendButtonHighlightColor;

+ (UIColor*) alt_sendButtonDisabledColor;

+ (UIColor*) alt_attachButtonColor;

+ (UIColor*) alt_attachButtonHighlightColor;

+ (UIColor*) alt_toolbarTintColor;

+ (UIColor*) alt_toolbarQuotedMessageAuthorColor;

+ (UIColor*) alt_toolbarQuotedMessageColor;

+ (UIColor*) alt_photoPickerToolbarTintColor;

+ (UIColor*) alt_photoPickerSheetTextColor;

+ (UIColor*) alt_emptyImageColor;

+ (UIColor*) alt_refreshColor;

+ (UIColor*) alt_scrollToBottomBadgeColor;

+ (UIColor*) alt_scrollToBottomBadgeTextColor;

+ (UIColor*) alt_typingTextColor;

+ (UIColor*) alt_placeholderTitleColor;

+ (UIColor*) alt_placeholderSubtitleColor;

+ (UIColor*) alt_searchScopeBarTintColor;

+ (UIColor*) alt_searchBarTextColor;

+ (UIColor*) alt_searchBarTintColor;

+ (UIColor*) alt_searchMessageAuthorTextColor;

+ (UIColor*) alt_searchMessageDateTextColor;

+ (UIColor*) alt_searchMessageFileTextColor;

+ (UIColor*) alt_searchMessageTextColor;

+ (UIColor*) alt_searchMessageMatchTextColor;

+ (UIColor*) alt_findedMessageHeaderTextColor;

+ (UIColor*) alt_findedMessageHeaderBackgroundColor;

+ (UIColor*) alt_findMoreMessageTextColor;

#pragma mark - Colors

+ (UIColor*) alt_darkGreen;

+ (UIColor*) alt_lightGreen;

+ (UIColor*) alt_gray;

+ (UIColor*) alt_lightGray;

+ (UIColor*) alt_middleGray;

+ (UIColor*) alt_darkGray;

+ (UIColor*) alt_darkerGray;

+ (UIColor*) alt_black_transparent_50;

+ (UIColor*) alt_lightCyan;

+ (UIColor*) alt_blue;

+ (UIColor*) alt_red;

+ (UIColor*) alt_orange;

+ (UIColor*) alt_darkOrange;

+ (UIColor*) alt_gold;

@end
