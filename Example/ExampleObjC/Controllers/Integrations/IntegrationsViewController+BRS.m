//
//  IntegrationsViewController+BRS.m
//  ExampleObjC
//
//  Created by Vitaliy Kuzmenko on 12/08/2019.
//  Copyright © 2019 Threads. All rights reserved.
//

#import "IntegrationsViewController+BRS.h"

@implementation UIColor (BRS)

+ (UIColor *)brsTintColor {
    return [UIColor colorWithRed:0.513f green:0.694f blue:0.262f alpha:1.f];
}

+ (UIColor *)brsBackgroundColor {
    return [UIColor colorWithRed:0.917f green:0.941f blue:0.941f alpha:1.f];
}

+ (UIColor *)brsColor3 {
    return [UIColor colorWithWhite:0.2 alpha:0.7];
}

+ (UIColor *)brsColor4 {
    return [UIColor colorWithWhite:0.2 alpha:0.5];
}

+ (UIColor *)brsColor5 {
    return [UIColor colorWithRed:0.957f green:0.262f blue:0.211f alpha:1];
}

@end

@implementation UIFont (BRS)

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

@implementation IntegrationsViewController (BRS)

- (THRAttributes *)getBRSAttributes {
    THRAttributes *attributes = [[THRAttributes alloc] init];
    
    attributes.refreshColor = [UIColor brsTintColor];
    attributes.statusBarStyle = UIStatusBarStyleDefault;
    
    attributes.navigationBarTitleFont = [UIFont latoSemiboldOfSize:18.f];
    attributes.navigationBarSubtitleFont = [UIFont latoSemiboldOfSize:13.f];
    
    attributes.backgroundColor = [UIColor brsBackgroundColor];
    
    attributes.placeholderImage = [UIImage imageNamed:@"placeholder_image"];
    attributes.placeholderTitleColor = [UIColor brsColor3];
    attributes.placeholderSubtitleColor = [UIColor brsColor4];
    attributes.placeholderTitleFont = [UIFont latoSemiboldOfSize:19.f];
    attributes.placeholderSubtitleFont = [UIFont latoRegularOfSize:15.f];
    
    attributes.myMessageFont = [UIFont latoRegularOfSize:16.f];
    
    attributes.attachButtonColor = [UIColor brsTintColor];
    attributes.attachButtonHighlightColor = [[UIColor brsTintColor] colorWithAlphaComponent:0.7];
    
    attributes.sendButtonColor = [UIColor brsTintColor];
    attributes.sendButtonHighlightColor = [[UIColor brsTintColor] colorWithAlphaComponent:0.7];
    
    attributes.waitingSpecialistBorderColor = [UIColor clearColor];
    attributes.waitingSpecialistSpinnerColor = [UIColor brsTintColor];
    
    attributes.outgoingBubbleColor = [UIColor brsTintColor];
    attributes.outgoingBubbleTextColor = [UIColor whiteColor];
    attributes.outgoingBubbleLinkColor = [UIColor blueColor];
    
    attributes.failedBubbleColor = [UIColor brsColor5];
    attributes.incomingBubbleTextColor = [UIColor brsColor4];
    attributes.incomingBubbleLinkColor = [UIColor brsTintColor];
    
    attributes.bubbleMessageFont = [UIFont latoRegularOfSize:17.f];
    attributes.bubbleTimeFont = [UIFont latoRegularOfSize:12.f];
    
    attributes.failedMessageFont = [UIFont latoSemiboldOfSize:12.f];
    attributes.messageHeaderFont = [UIFont latoSemiboldOfSize:13.f];
    
    attributes.specialisConnectTitleFont = [UIFont latoSemiboldOfSize:17.f];
    attributes.specialisConnectSubtitleFont = [UIFont latoRegularOfSize:12.f];
    attributes.specialisConnectTitleColor = [UIColor brsColor4];
    attributes.specialisConnectSubtitleColor = [UIColor brsColor4];
    
    attributes.toolbarTintColor = [UIColor redColor];
    attributes.toolbarQuotedMessageAuthorColor = [UIColor brsColor4];
    attributes.toolbarQuotedMessageColor = [UIColor brsColor4];
    attributes.toolbarQuotedMessageAuthorFont = [UIFont latoRegularOfSize:17.f];
    attributes.toolbarQuotedMessageFont = [UIFont latoLightOfSize:17.f];
    
    attributes.quoteAuthorFont = [UIFont latoSemiboldOfSize:17.f];
    attributes.quoteMessageFont = [UIFont latoLightOfSize:17.f];
    attributes.quoteFilesizeFont = [UIFont latoRegularOfSize:13.f];
    attributes.quoteTimeFont = [UIFont latoRegularOfSize:13.f];
    
    attributes.outgoingQuoteSeparatorColor = [UIColor whiteColor];
    attributes.outgoingQuoteAuthorColor = [UIColor whiteColor];
    attributes.outgoingQuoteMessageColor = [UIColor whiteColor];
    attributes.outgoingQuoteTimeColor = [UIColor whiteColor];
    attributes.outgoingQuoteFilesizeColor = [UIColor whiteColor];
    
    attributes.incomingQuoteSeparatorColor = [UIColor brsTintColor];
    attributes.incomingQuoteAuthorColor = [UIColor brsColor4];
    attributes.incomingQuoteMessageColor = [UIColor brsColor3];
    attributes.incomingQuoteTimeColor = [UIColor brsColor3];
    attributes.incomingQuoteFilesizeColor = [UIColor brsColor3];
    attributes.incomingFileIconTintColor = [UIColor brsTintColor];
    attributes.incomingFileIconBgColor = [UIColor brsBackgroundColor];
    
    attributes.clearSearchIcon = [UIImage imageNamed:@"ic_clear_search"];
    attributes.searchBarTintColor = [UIColor brsColor4];
    attributes.searchBarTextColor = [UIColor brsColor4];
    attributes.searchScopeBarTintColor = [UIColor brsTintColor];
    attributes.searchBarTextFont = [UIFont latoRegularOfSize:14.f];
    attributes.searchScopeBarFont = [UIFont latoRegularOfSize:13.f];
    
    attributes.findedMessageHeaderTextColor = [UIColor brsColor4];
    attributes.findedMessageHeaderBackgroundColor = [UIColor brsBackgroundColor];
    attributes.findedMessageHeaderTextFont = [UIFont latoRegularOfSize:13.f];
    attributes.findMoreMessageTextColor = [UIColor brsColor4];
    attributes.findMoreMessageTextFont = [UIFont latoRegularOfSize:15.f];
    
    attributes.searchMessageAuthorTextColor = [UIColor brsColor4];
    attributes.searchMessageTextColor = [UIColor brsColor3];
    attributes.searchMessageDateTextColor = [UIColor brsColor3];
    attributes.searchMessageFileTextColor = [UIColor brsColor3];
    attributes.searchMessageMatchTextColor = [UIColor brsTintColor];
    attributes.searchMessageAuthorTextFont = [UIFont latoRegularOfSize:17.f];
    attributes.searchMessageTextFont = [UIFont latoRegularOfSize:13.f];
    attributes.searchMessageFileTextFont = [UIFont latoRegularOfSize:13.f];
    attributes.searchMessageDateTextFont = [UIFont latoRegularOfSize:13.f];
    attributes.searchMessageMatchTextFont = [UIFont latoMediumOfSize:13.f];
    
    attributes.photoPickerSelfieEnabled = YES;
    attributes.photoPickerCheckmarkIcon = [UIImage imageNamed:@"ic_checkmark"];
    attributes.photoPickerToolbarTintColor = [UIColor brsTintColor];
    attributes.photoPickerToolbarButtonFont = [UIFont latoRegularOfSize:17.f];
    attributes.photoPickerSheetTextColor = [UIColor brsTintColor];
    attributes.photoPickerSheetTextFont = [UIFont latoRegularOfSize:17.f];
    
    attributes.fileViewerTitleFont = attributes.navigationBarTitleFont;
    
    attributes.sendButtonFont = [UIFont latoRegularOfSize:17.f];
    
    attributes.messageBubbleFilledMaskImage = [UIImage imageNamed:@"rect_bubble_filled"];
    attributes.messageBubbleStrokedMaskImage = [UIImage imageNamed:@"rect_bubble_stroked"];
    
    attributes.typingText = NSLocalizedString(@"typing...", @"");
    attributes.typingTextColor = [UIColor brsColor4];
    attributes.typingTextFont = [UIFont latoMediumOfSize:13.f];
    
    attributes.scheduleIcon = [UIImage imageNamed:@"schedule_alert"];
    attributes.scheduleAlertFont = [UIFont latoSemiboldOfSize:17.f];
    attributes.scheduleAlertColor = [UIColor brsColor4];
    
    attributes.scrollToBottomImage = [UIImage imageNamed:@"scroll_down_button_brs"];
    
    attributes.surveyTextFont = [UIFont latoRegularOfSize:17.f];
    attributes.surveyTextColor = [UIColor brsTintColor];
    attributes.surveyCompletionFont = [UIFont latoRegularOfSize:17.f];
    attributes.surveyCompletionColor = [UIColor brsTintColor];
    
    attributes.iconLikeFull = [[UIImage imageNamed:@"ic_like_filled"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    attributes.iconLikeEmpty  = [[UIImage imageNamed:@"ic_like_stroked"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    attributes.iconDislikeFull  = [[UIImage imageNamed:@"ic_dislike_filled"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    attributes.iconDislikeEmpty  = [[UIImage imageNamed:@"ic_dislike_stroked"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    attributes.iconStarRatingFull  = [[UIImage imageNamed:@"ic_heart_filled"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    attributes.iconStarRatingEmty = [[UIImage imageNamed:@"ic_heart_stroked"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    attributes.likeRatingColorEnabled = [UIColor brsTintColor];
    attributes.likeRatingColorDisabled = [UIColor brsTintColor];
    attributes.starRatingColorEnabled = [UIColor redColor];
    attributes.starRatingColorDisabled = [UIColor redColor];
    attributes.likeRatingColorCompleted = [UIColor yellowColor];
    attributes.starRatingColorCompleted = [UIColor redColor];
    
    attributes.navigationBarSubtitleShowOrgUnit = YES;
    attributes.showWaitingForSpecialistProgress = NO;
    attributes.canShowSpecialistInfo = NO;
    attributes.navigationBarVisible = YES;
    attributes.historyLoadingCount = @(25);
    return attributes;
}

@end
