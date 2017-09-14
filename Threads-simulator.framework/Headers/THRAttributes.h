//
//  THRAttributes.h
//  Threads
//
//  Created by Nikolay Kagala on 30/05/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "THRCompatibility.h"

NS_ASSUME_NONNULL_BEGIN

@interface THRAttributes : NSObject

#pragma mark - General

/**
 *  Works properly for non view controller based status bar appearance
 */
@property (assign, nonatomic, readwrite) UIStatusBarStyle statusBarStyle;

@property (strong, nonatomic, readwrite) UIColor* refreshColor;


#pragma mark - Navigation bar
@property (nonatomic, assign, readwrite) BOOL navigationBarVisible;
@property (strong, nonatomic, readwrite) UIColor* navigationBarBackgroundColor;
@property (strong, nonatomic, readwrite) UIColor* navigationBarTintColor;

@property (strong, nonatomic, readwrite) UIFont* navigationBarItemFont;
@property (strong, nonatomic, readwrite) UIFont* navigationBarTitleFont;
@property (strong, nonatomic, readwrite) UIFont* navigationBarSubtitleFont;

#pragma mark - Placeholder

@property (strong, nonatomic, readwrite) UIColor* backgroundColor;
@property (strong, nonatomic, readwrite) UIImage* placeholderImage;
@property (strong, nonatomic, readwrite) UIColor* placeholderTitleColor;
@property (strong, nonatomic, readwrite) UIColor* placeholderSubtitleColor;
@property (strong, nonatomic, readwrite) UIFont* placeholderTitleFont;
@property (strong, nonatomic, readwrite) UIFont* placeholderSubtitleFont;

#pragma mark - Toolbar

@property (strong, nonatomic, readwrite) UIColor *toolbarTintColor;

@property (strong, nonatomic, readwrite) UIColor *attachButtonColor;
@property (strong, nonatomic, readwrite) UIColor *attachButtonHighlightColor;

@property (strong, nonatomic, readwrite) UIColor *sendButtonColor;
@property (strong, nonatomic, readwrite) UIColor *sendButtonHighlightColor;
@property (strong, nonatomic, readwrite) UIColor *sendButtonDisabledColor;
@property (strong, nonatomic, readwrite) UIFont  *sendButtonFont;

@property (strong, nonatomic, readwrite) UIFont* myMessageFont;

@property (strong, nonatomic, readwrite) UIFont* toolbarQuotedMessageAuthorFont;
@property (strong, nonatomic, readwrite) UIFont* toolbarQuotedMessageFont;
@property (strong, nonatomic, readwrite) UIColor* toolbarQuotedMessageAuthorColor;
@property (strong, nonatomic, readwrite) UIColor* toolbarQuotedMessageColor;

#pragma mark - Waiting for specialist

@property (nonatomic, assign, readwrite) BOOL showWaitingForSpecialistProgress;
@property (strong, nonatomic, readwrite) UIColor *waitingSpecialistSpinnerColor;
@property (strong, nonatomic, readwrite) UIColor *waitingSpecialistBgColor;
@property (strong, nonatomic, readwrite) UIColor *waitingSpecialistBorderColor;
@property (nonatomic, assign, readwrite) CGFloat waitingSpecialistBorderWidth;

#pragma mark - Messages
@property (strong, nonatomic, readwrite) UIFont* bubbleMessageFont;
@property (strong, nonatomic, readwrite) UIFont* bubbleTimeFont;
@property (strong, nonatomic, readwrite) UIFont* failedMessageFont;
@property (strong, nonatomic, readwrite) UIFont* messageHeaderFont;

@property (strong, nonatomic, readwrite) UIFont* quoteAuthorFont;
@property (strong, nonatomic, readwrite) UIFont* quoteMessageFont;
@property (strong, nonatomic, readwrite) UIFont* quoteTimeFont;
@property (strong, nonatomic, readwrite) UIFont* quoteFilesizeFont;

@property (strong, nonatomic, readwrite) UIImage* messageBubbleFilledMaskImage;
@property (strong, nonatomic, readwrite) UIImage* messageBubbleStrokedMaskImage;
@property (strong, nonatomic, readwrite) UIColor *emptyImageColor;

#pragma mark - System messages
@property (strong, nonatomic, readwrite) UIFont* specialisConnectTitleFont;
@property (strong, nonatomic, readwrite) UIFont* specialisConnectSubtitleFont;
@property (strong, nonatomic, readwrite) UIColor* specialisConnectTitleColor;
@property (strong, nonatomic, readwrite) UIColor* specialisConnectSubtitleColor;

@property (strong, nonatomic, readwrite) UIFont* typingTextFont;
@property (strong, nonatomic, readwrite) UIColor* typingTextColor;
@property (strong, nonatomic, readwrite) NSString* typingText;

@property (strong, nonatomic, readwrite) UIImage *scheduleIcon;
@property (strong, nonatomic, readwrite) UIColor *scheduleAlertColor;
@property (strong, nonatomic, readwrite) UIFont  *scheduleAlertFont;

#pragma mark - Incoming message

@property (strong, nonatomic, readwrite) UIColor* incomingBubbleColor;
@property (strong, nonatomic, readwrite) UIColor* incomingBubbleTextColor;

@property (assign, nonatomic, readwrite) BOOL showIncomingAvatar;

@property (strong, nonatomic, readwrite) UIColor* incomingQuoteSeparatorColor;
@property (strong, nonatomic, readwrite) UIColor* incomingQuoteAuthorColor;
@property (strong, nonatomic, readwrite) UIColor* incomingQuoteMessageColor;
@property (strong, nonatomic, readwrite) UIColor* incomingQuoteTimeColor;
@property (strong, nonatomic, readwrite) UIColor* incomingQuoteFilesizeColor;
@property (strong, nonatomic, readwrite) UIColor* incomingFileIconTintColor;
@property (strong, nonatomic, readwrite) UIColor* incomingFileIconBgColor;
@property (nonatomic, assign, readwrite) CGFloat commonMessageAvatarSize;
@property (nonatomic, assign, readwrite) CGFloat systemMessageAvatarSize;

#pragma mark - Outgoing message

@property (strong, nonatomic, readwrite) UIColor* failedBubbleColor;
@property (strong, nonatomic, readwrite) UIColor* outgoingBubbleColor;
@property (strong, nonatomic, readwrite) UIColor* outgoingBubbleTextColor;
@property (assign, nonatomic, readonly) BOOL showOutgoingAvatar;
@property (strong, nonatomic, readwrite) UIImage* avatarPlaceholderImage;

@property (strong, nonatomic, readwrite) UIColor* outgoingQuoteSeparatorColor;
@property (strong, nonatomic, readwrite) UIColor* outgoingQuoteAuthorColor;
@property (strong, nonatomic, readwrite) UIColor* outgoingQuoteMessageColor;
@property (strong, nonatomic, readwrite) UIColor* outgoingQuoteTimeColor;
@property (strong, nonatomic, readwrite) UIColor* outgoingQuoteFilesizeColor;

#pragma mark - Search controller
@property (strong, nonatomic, readwrite) UIColor* searchScopeBarTintColor;
@property (strong, nonatomic, readwrite) UIColor* searchBarTextColor;
@property (strong, nonatomic, readwrite) UIColor* searchBarTintColor;
@property (strong, nonatomic, readwrite) UIFont* searchScopeBarFont;
@property (strong, nonatomic, readwrite) UIFont* searchBarTextFont;

#pragma mark - Search message
@property (strong, nonatomic, readwrite) UIImage* clearSearchIcon;
@property (strong, nonatomic, readwrite) UIColor* findedMessageHeaderTextColor;
@property (strong, nonatomic, readwrite) UIColor* findedMessageHeaderBackgroundColor;
@property (strong, nonatomic, readwrite) UIFont* findedMessageHeaderTextFont;

@property (strong, nonatomic, readwrite) UIColor* findMoreMessageTextColor;
@property (strong, nonatomic, readwrite) UIFont* findMoreMessageTextFont;

@property (strong, nonatomic, readwrite) UIColor* searchMessageAuthorTextColor;
@property (strong, nonatomic, readwrite) UIColor* searchMessageTextColor;
@property (strong, nonatomic, readwrite) UIColor* searchMessageDateTextColor;
@property (strong, nonatomic, readwrite) UIColor* searchMessageFileTextColor;
@property (strong, nonatomic, readwrite) UIColor* searchMessageStatusTintColor;
@property (strong, nonatomic, readwrite) UIColor* searchMessageMatchTextColor;

@property (strong, nonatomic, readwrite) UIFont* searchMessageAuthorTextFont;
@property (strong, nonatomic, readwrite) UIFont* searchMessageMatchTextFont;
@property (strong, nonatomic, readwrite) UIFont* searchMessageTextFont;
@property (strong, nonatomic, readwrite) UIFont* searchMessageFileTextFont;
@property (strong, nonatomic, readwrite) UIFont* searchMessageDateTextFont;

#pragma mark - Photopicker

@property (nonatomic, strong) UIColor *photoPickerToolbarTintColor;
@property (nonatomic, strong) UIFont *photoPickerToolbarButtonFont;

@property (nonatomic, strong) UIImage *photoPickerCheckmarkIcon;
@property (nonatomic, strong) UIImage *photoPickerEmptyCheckmarkIcon;

@property (nonatomic, strong) UIColor *photoPickerSheetTextColor;
@property (nonatomic, strong) UIFont *photoPickerSheetTextFont;

#pragma mark - Survey
#pragma mark - Specialist Info

@property (nonatomic, strong) UIColor *starRatingColorEnabled;
@property (nonatomic, strong) UIColor *likeRatingColorEnabled;
@property (nonatomic, strong) UIColor *starRatingColorDisabled;
@property (nonatomic, strong) UIColor *likeRatingColorDisabled;
@property (nonatomic, strong) UIColor *starRatingColorCompleted;
@property (nonatomic, strong) UIColor *likeRatingColorCompleted;
@property (nonatomic, assign) BOOL canShowSpecialistInfo;

@property (nonatomic, strong) UIColor *likeLabelOnStarColor;
@property (nonatomic, strong) UIColor *likeLabelUnderStarColor;

@property (nonatomic, strong) UIImage *iconStarRatingEmty;
@property (nonatomic, strong) UIImage *iconStarRatingFull;
@property (nonatomic, strong) UIImage *iconLikeEmpty;
@property (nonatomic, strong) UIImage *iconDislikeEmpty;
@property (nonatomic, strong) UIImage *iconLikeFull;
@property (nonatomic, strong) UIImage *iconDislikeFull;

@property (nonatomic, assign) BOOL canShowDebugScreen;

#pragma mark - DataStore

@property (nonatomic, strong) NSDictionary <NSString *, NSString *> *customHTTPHeadersForDataStore;
@property (nonatomic, strong) NSNumber *historyLoadingCount;

#pragma mark - Request Close Thread Survey

@property (strong, nonatomic, readwrite) NSString* closeThreadSurveyText;
@property (strong, nonatomic, readwrite) NSString* closeThreadSurveyAnswerClose;
@property (strong, nonatomic, readwrite) NSString* closeThreadSurveyAnswerContinue;

+ (instancetype) defaultAttributes;

@end

NS_ASSUME_NONNULL_END
