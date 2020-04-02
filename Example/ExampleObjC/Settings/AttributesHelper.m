//
//  AttributesHelper.m
//  ExampleObjC
//
//  Created by Brooma Service on 20.12.2019.
//  Copyright © 2019 Threads. All rights reserved.
//

#import "AttributesHelper.h"
#import "UIColor+AltColor.h"
#import "UIFont+THRFonts.h"

@implementation AttributesHelper

+ (THRAttributes*) getDefaultAttributes {
    return [THRAttributes defaultAttributes];
}

+ (THRAttributes*) getAltAttributes {
    
    THRAttributes *attributes = [THRAttributes defaultAttributes];
    
    attributes.refreshColor = [UIColor alt_refreshColor];
    attributes.statusBarStyle = UIStatusBarStyleDefault;
    
    attributes.navigationBarTitleFont = [UIFont latoSemiboldOfSize:18.f];
    attributes.navigationBarSubtitleFont = [UIFont latoSemiboldOfSize:13.f];
    
    attributes.backgroundColor = [UIColor alt_mainBackgroundColor];
    
    attributes.placeholderImage = [UIImage imageNamed:@"placeholder_image"];
    attributes.placeholderTitleColor = [UIColor alt_placeholderTitleColor];
    attributes.placeholderSubtitleColor = [UIColor alt_placeholderSubtitleColor];
    attributes.placeholderTitleFont = [UIFont latoSemiboldOfSize:19.f];
    attributes.placeholderSubtitleFont = [UIFont latoRegularOfSize:15.f];
    
    attributes.myMessageFont = [UIFont latoRegularOfSize:16.f];
    
    attributes.attachButtonColor = [UIColor alt_attachButtonColor];
    attributes.attachButtonHighlightColor = [UIColor alt_attachButtonHighlightColor];
    
    attributes.sendButtonColor = [UIColor alt_sendButtonColor];
    attributes.sendButtonHighlightColor = [UIColor alt_sendButtonHighlightColor];
    
    attributes.waitingSpecialistBorderColor = [UIColor alt_waitingSpecialistBorderColor];
    attributes.waitingSpecialistSpinnerColor = [UIColor alt_waitingSpecialistSpinnerColor];
    
    attributes.outgoingBubbleColor = [UIColor alt_outgoingBubbleColor];
    attributes.outgoingBubbleTextColor = [UIColor alt_outgoingBubbleTextColor];
    attributes.outgoingBubbleLinkColor = [UIColor alt_outgoingBubbleLinkColor];
    
    attributes.failedBubbleColor = [UIColor alt_failedBubbleColor];
    attributes.failedMessageFont = [UIFont latoSemiboldOfSize:12.f];
    
    attributes.incomingBubbleColor = [UIColor alt_incomingBubbleColor];
    attributes.incomingBubbleTextColor = [UIColor alt_incomingBubbleTextColor];
    attributes.incomingBubbleLinkColor = [UIColor alt_incomingBubbleLinkColor];
    
    attributes.bubbleMessageFont = [UIFont latoRegularOfSize:17.f];
    attributes.bubbleTimeFont = [UIFont latoRegularOfSize:12.f];
    
    attributes.messageHeaderFont = [UIFont latoSemiboldOfSize:13.f];
    
    attributes.specialisConnectTitleFont = [UIFont latoSemiboldOfSize:17.f];
    attributes.specialisConnectSubtitleFont = [UIFont latoRegularOfSize:12.f];
    attributes.specialisConnectTitleColor = [UIColor alt_specialisConnectTitleColor];
    attributes.specialisConnectSubtitleColor = [UIColor alt_specialisConnectSubtitleColor];
    
    attributes.toolbarTintColor = [UIColor alt_toolbarTintColor];
    attributes.toolbarQuotedMessageAuthorColor = [UIColor alt_toolbarQuotedMessageAuthorColor];
    attributes.toolbarQuotedMessageColor = [UIColor alt_toolbarQuotedMessageColor];
    attributes.toolbarQuotedMessageAuthorFont = [UIFont latoRegularOfSize:17.f];
    attributes.toolbarQuotedMessageFont = [UIFont latoLightOfSize:17.f];
    
    attributes.quoteAuthorFont = [UIFont latoSemiboldOfSize:17.f];
    attributes.quoteMessageFont = [UIFont latoLightOfSize:17.f];
    attributes.quoteFilesizeFont = [UIFont latoRegularOfSize:13.f];
    attributes.quoteTimeFont = [UIFont latoRegularOfSize:13.f];
    
    attributes.outgoingQuoteSeparatorColor = [UIColor alt_outgoingQuoteSeparatorColor];
    attributes.outgoingQuoteAuthorColor = [UIColor alt_outgoingQuoteAuthorColor];
    attributes.outgoingQuoteMessageColor = [UIColor alt_outgoingQuoteMessageColor];
    attributes.outgoingQuoteTimeColor = [UIColor alt_outgoingQuoteTimeColor];
    attributes.outgoingQuoteFilesizeColor = [UIColor alt_outgoingQuoteFilesizeColor];
    
    attributes.incomingQuoteSeparatorColor = [UIColor alt_incomingQuoteSeparatorColor];
    attributes.incomingQuoteAuthorColor = [UIColor alt_incomingQuoteAuthorColor];
    attributes.incomingQuoteMessageColor = [UIColor alt_incomingQuoteMessageColor];
    attributes.incomingQuoteTimeColor = [UIColor alt_incomingQuoteTimeColor];
    attributes.incomingQuoteFilesizeColor = [UIColor alt_incomingQuoteFilesizeColor];
    
    attributes.incomingFileIconTintColor = [UIColor alt_incomingFileIconTintColor];
    attributes.incomingFileIconBgColor = [UIColor alt_incomingFileIconBgColor];
    
    attributes.clearSearchIcon = [UIImage imageNamed:@"ic_clear_search"];
    attributes.searchBarTintColor = [UIColor alt_searchBarTintColor];
    attributes.searchBarTextColor = [UIColor alt_searchBarTextColor];
    attributes.searchBarTextFont = [UIFont latoRegularOfSize:14.f];
    
    attributes.searchScopeBarTintColor = [UIColor alt_searchScopeBarTintColor];
    attributes.searchScopeBarFont = [UIFont latoRegularOfSize:13.f];
    
    attributes.findedMessageHeaderTextColor = [UIColor alt_findedMessageHeaderTextColor];
    attributes.findedMessageHeaderBackgroundColor = [UIColor alt_findedMessageHeaderBackgroundColor];
    attributes.findedMessageHeaderTextFont = [UIFont latoRegularOfSize:13.f];
    attributes.findMoreMessageTextColor = [UIColor alt_findMoreMessageTextColor];
    attributes.findMoreMessageTextFont = [UIFont latoRegularOfSize:15.f];
    
    attributes.searchMessageAuthorTextColor = [UIColor alt_searchMessageAuthorTextColor];
    attributes.searchMessageTextColor = [UIColor alt_searchMessageTextColor];
    attributes.searchMessageDateTextColor = [UIColor alt_searchMessageDateTextColor];
    attributes.searchMessageFileTextColor = [UIColor alt_searchMessageFileTextColor];
    attributes.searchMessageMatchTextColor = [UIColor alt_searchMessageMatchTextColor];
    attributes.searchMessageAuthorTextFont = [UIFont latoRegularOfSize:17.f];
    attributes.searchMessageTextFont = [UIFont latoRegularOfSize:13.f];
    attributes.searchMessageFileTextFont = [UIFont latoRegularOfSize:13.f];
    attributes.searchMessageDateTextFont = [UIFont latoRegularOfSize:13.f];
    attributes.searchMessageMatchTextFont = [UIFont latoMediumOfSize:13.f];
    
    attributes.photoPickerSelfieEnabled = YES;
    attributes.photoPickerCheckmarkIcon = [UIImage imageNamed:@"ic_checkmark"];
    attributes.photoPickerToolbarTintColor = [UIColor alt_photoPickerToolbarTintColor];
    attributes.photoPickerToolbarButtonFont = [UIFont latoRegularOfSize:17.f];
    attributes.photoPickerSheetTextColor = [UIColor alt_photoPickerSheetTextColor];
    attributes.photoPickerSheetTextFont = [UIFont latoRegularOfSize:17.f];
    
    attributes.fileViewerTitleFont = attributes.navigationBarTitleFont;
    
    attributes.sendButtonFont = [UIFont latoRegularOfSize:17.f];
    
    attributes.messageBubbleFilledMaskImage = [UIImage imageNamed:@"rect_bubble_filled"];
    attributes.messageBubbleStrokedMaskImage = [UIImage imageNamed:@"rect_bubble_stroked"];
    
    attributes.typingText = NSLocalizedString(@"typing...", @"");
    attributes.typingTextColor = [UIColor alt_typingTextColor];
    attributes.typingTextFont = [UIFont latoMediumOfSize:13.f];
    
    attributes.scheduleIcon = [UIImage imageNamed:@"schedule_alert"];
    attributes.scheduleAlertFont = [UIFont latoSemiboldOfSize:17.f];
    attributes.scheduleAlertColor = [UIColor alt_scheduleAlertColor];
    
    attributes.scrollToBottomImage = [UIImage imageNamed:@"alt_scroll_down_button"];
    
    attributes.surveyTextFont = [UIFont latoRegularOfSize:17.f];
    attributes.surveyTextColor = [UIColor alt_surveyTextColor];
    attributes.surveyCompletionFont = [UIFont latoRegularOfSize:17.f];
    attributes.surveyCompletionColor = [UIColor alt_surveyCompletionColor];
    
    attributes.iconLikeFull = [[UIImage imageNamed:@"ic_like_filled"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    attributes.iconLikeEmpty  = [[UIImage imageNamed:@"ic_like_stroked"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    attributes.iconDislikeFull  = [[UIImage imageNamed:@"ic_dislike_filled"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    attributes.iconDislikeEmpty  = [[UIImage imageNamed:@"ic_dislike_stroked"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    attributes.iconStarRatingFull  = [[UIImage imageNamed:@"ic_heart_filled"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    attributes.iconStarRatingEmty = [[UIImage imageNamed:@"ic_heart_stroked"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    attributes.likeRatingColorEnabled = [UIColor alt_likeRatingColorEnabled];
    attributes.likeRatingColorDisabled = [UIColor alt_likeRatingColorDisabled];
    attributes.starRatingColorEnabled = [UIColor alt_starRatingColorEnabled];
    attributes.starRatingColorDisabled = [UIColor alt_starRatingColorDisabled];
    attributes.likeRatingColorCompleted = [UIColor alt_likeRatingColorCompleted];
    attributes.starRatingColorCompleted = [UIColor alt_starRatingColorCompleted];
    
    attributes.navigationBarSubtitleShowOrgUnit = YES;
    attributes.showWaitingForSpecialistProgress = NO;
    attributes.canShowSpecialistInfo = NO;
    attributes.navigationBarVisible = YES;
    attributes.historyLoadingCount = @(25);
    return attributes;
    
}

@end
