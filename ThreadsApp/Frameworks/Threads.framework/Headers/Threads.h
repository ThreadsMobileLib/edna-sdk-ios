//
//  Threads.h
//  Threads
//
//  Created by Nikolay Kagala on 30/05/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Threads/THRCompatibility.h>
#import <Threads/THRAttributes.h>
@class PushNotificationMessage;

typedef void(^THRShortPushHandler)(UIBackgroundFetchResult result);

NS_ASSUME_NONNULL_BEGIN

#if __IPHONE_OS_VERSION_MIN_REQUIRED < 80000
#error "Threads minimum iOS version is 8.0"
#endif

//! Project version number for Threads.
FOUNDATION_EXPORT double ThreadsVersionNumber;

//! Project version string for Threads.
FOUNDATION_EXPORT const unsigned char ThreadsVersionString[];

typedef void(^THRRegistrationCompletion)(BOOL state, NSError *error);
typedef void(^THRSubmissionCompletion)(BOOL success, NSError *error);

static NSInteger const THRErrorNoErrors                 = 0;
static NSInteger const THRErrorEmptyClientIdCode        = -1;
static NSInteger const THRErrorEmptyClientNameCode      = -2;
static NSInteger const THRErrorOutsideMessageImageIsNil = -3;

typedef enum : NSUInteger {
    THRMessageRecieveStateAccepted,
    THRMessageRecieveStateNotAccepted
} THRMessageRecieveState;

@interface Threads: NSObject

/*!
 * Identifier of client
 */
@property NSString *clientId;

@property NSString *clientIdSignature;

/*!
 * Name of client
 */
@property NSString *clientName;

/*!
 * Custom data
 */
@property NSString *data;

@property NSString *appMarker;

/*!
 * Boolean parameneter, which enable or disable Google Analytics
 */
@property BOOL analyticsEnabled;

/*!
 * Debug logging enabling paramter
 */
@property BOOL debugLoggingEnabled;

/*!
 * It is title that will be show in the empty screen of chat
 */
@property NSString *helloTitle;

/*!
 * It is description that will be show in the empty screen of chat
 */
@property NSString *helloDescription;

/*!
 * It is boolean which tell us about chat style: gragmented or not
 */
@property (readonly)BOOL fragmented;

/*!
 * Return count of unreaded messages
 */
@property (nonatomic, readonly)NSInteger unreadedMessagesCount;

/*!
 * Unreaded messages block which will be called on changing `unreadedMessagesCount` value
 */
@property (strong, nonatomic)void (^unreadedMessagesCountChanged)(NSInteger unreadedCount);

/*!
 * Returns Threads singletone
 */
+ (instancetype)threads NS_SWIFT_NAME(threads());

+ (void)setClienIdEncrypted:(BOOL)isEncrypted;

+ (void)setHistoryUrl:(NSString *)historyUrl;

+ (void)setFileUploadUrl:(NSString *)fileUploadUrl;

/*!
 * @param attributes: set if you need customization
 */
+ (void)setAttributes:(THRAttributes *)attributes;

/*!
 * Setting client id for identity user on MFMS servers.
 * It can be a phone number.
 *
 * @param clientId: must be set
 */
+ (void)setClientId:(NSString *)clientId;

+ (void)setClientIdSignature:(NSString *)clientIdSignature;

+ (void)setAppMarker:(NSString *)appMarker;

/*!
 * Setting client name for showing user's name on MFMS servers.
 *
 * @param clientName: must be set
 */
+ (void)setClientName:(NSString *)clientName;

/*!
 * Setting custom data to be sent in client_info system message
 *
 * @param data
 */
+ (void)setData:(NSString *)data;

/*!
 * Setting enable Analytics.
 */
+ (void)setAnalyticsEnabled:(BOOL)enabled;

+ (void)setDebugLoggingEnabled:(BOOL)enabled;

/*!
 * Setting hello title.
 */
+ (void)setHelloTitle:(NSString *)title;

/*!
 * Setting hello description.
 */
+ (void)setHelloDescription:(NSString *)description;

/*!
 * Return last known client id. Need for demo project
 */
+ (NSString *)getLastClientId;

/*!
 * Return last known client name. Need for demo project
 */
+ (NSString *)getLastClientName;

/*!
 * Return attributes of chat
 */
+ (THRAttributes *)getAttributes;

/*!
 *  Registering clients with clientId on MFMS's servers.
 */
+ (void)registerClientWithCompletion:(THRRegistrationCompletion)completion;

/*!
 * Show Threads window in fullscreen mode
 */
+ (void)show;

+ (void)showAnimated:(BOOL)animated;

/*!
 * Show Threads as fragment
 */

+ (void)showInView:(UIView *)view
   parentController:(UIViewController *)parentController;
    
+ (void)showInView:(UIView *)view
   parentController:(UIViewController *)parentController
      bottomSpacing:(CGFloat)spacing __deprecated_msg("Use showInView:parentController");

/*!
 * Dismiss Threads
 */
+ (void)dismissFromCurrentView;

/*!
 * Logout current clientId
 */
+ (void)logout;

/*!
 * Logout specific clientId
 */
+ (void)logout:(NSString*)clientId;

+ (void)reloadHistory;

/*!
 * Clearing local cache of images
 */
+ (void)clearCachedFiles;


/*!
 * Return current version of Threads
 */
+ (NSString *)version;

/*!
 * Access point for showing toolbar when need (for example, after dragging side menu)
 */
+ (void)showToolbarAnimated:(BOOL)animated;

/*!
 * Access point for hiding toolbar when need (for example, after dragging side menu)
 */
+ (void)hideToolbarAnimated:(BOOL)animated;

+ (void)showKeyboard;

+ (void)hideKeyboard;

/*!
 * Set inset for messages collection
 */
+ (void)setMessageInputInset:(CGFloat)inset animated:(BOOL)animated __deprecated_msg("Do not use anymore");

/*!
 * Short push message receiver
 */
+ (THRMessageRecieveState)didReceiveShortPush:(NSDictionary *)dict
                                       handler:(thr_nullable THRShortPushHandler)handler;

/*!
 * Full push message receiver
 */
+ (THRMessageRecieveState)didReceiveFullPush:(PushNotificationMessage *)message;

+ (BOOL)isThreadsOriginPush:(NSDictionary *)pushDict;

+ (NSString *)getAppMarkerFromPush:(NSDictionary *)pushDict;

/*!
 * Return boolean value which tells about visibility of Threads
 */
- (BOOL)threadsIsVisible;

/*!
 * Return boolean value which tells about configuration of Threads
 */
- (BOOL)isConfigured;

/*!
 * Submit text outside chat
 */
- (void)submitMessageWithText:(NSString *)text completion:(THRSubmissionCompletion)completion;

/*!
 * Submit image outside chat
 */
- (void)submitMessageWithImage:(UIImage *)image completion:(THRSubmissionCompletion)completion;

@end

NS_ASSUME_NONNULL_END
