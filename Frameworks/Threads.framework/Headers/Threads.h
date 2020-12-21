//
//  Threads.h
//  Threads
//
//  Created by Nikolay Kagala on 30/05/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Threads/THRAttributes.h>
#import <MFMSPushLite/MFMSPushLite.h>

NS_ASSUME_NONNULL_BEGIN

#if __IPHONE_OS_VERSION_MIN_REQUIRED < 80000
#error "Threads minimum iOS version is 8.0"
#endif

//! Project version number for Threads.
FOUNDATION_EXPORT double ThreadsVersionNumber;

//! Project version string for Threads.
FOUNDATION_EXPORT const unsigned char ThreadsVersionString[];

FOUNDATION_EXPORT void THRLog(NSString *format, ...) NS_FORMAT_FUNCTION(1,2) NS_NO_TAIL_CALL;

@class THRSendMessageResponse;

typedef void(^THRMessageSubmissionCompletion)(THRSendMessageResponse *response);

typedef void(^THROperationCompletion)(NSError * _Nullable error);

typedef void(^THRRemoteNotificationsRegistrationCompletion)(NSData * _Nullable deviceToken);

static NSInteger const THRErrorNoErrors                     = 0;
static NSInteger const THRErrorEmptyClientIdCode            = -1;
static NSInteger const THRErrorEmptyClientNameCode          = -2;
static NSInteger const THRErrorOutsideMessageTextIsEmpty    = -3;
static NSInteger const THRErrorOutsideMessageTextIsTooLong  = -4;
static NSInteger const THRErrorOutsideMessageImageIsNil     = -5;
static NSInteger const THRErrorOutsideMessageImageTooBig    = -6;
static NSInteger const THRErrorClientDataUnparsedCode = -7;

typedef NS_ENUM(NSUInteger, THRMessageRecieveState) {
    THRMessageRecieveStateAccepted,
    THRMessageRecieveStateNotAccepted
};

typedef NS_ENUM(NSUInteger, ThreadsTrasportProtocol) {
    ThreadsTrasportProtocolPushLib,
    ThreadsTrasportProtocolThreadsGate
};

@class Threads;

@protocol ThreadsDelegate <NSObject>

@optional

- (void)threads:(Threads *)threads didReceiveFullMessages:(NSArray<PushNotificationMessage *> *)messages;

- (void)threads:(Threads *)threads didReceiveError:(NSError *)error;

- (void)threads:(Threads *)threads unreadMessagesCount:(NSUInteger)unreadMessagesCount;

- (id<PushServerApiConfigDataSource>)threads:(Threads *)threads configurePushServerApiFor:(MFMSPushLite *)mfmsPushLite;

- (void)threads:(Threads *)threads didChangeDeviceAddress:(NSString *)deviceAddress;

- (BOOL)threads:(Threads *)threads allowOpenUrl:(NSURL *)url;

@end

@interface Threads: NSObject


/**
 Access to MFMSPushLite instance
 */
@property (readonly, nullable) MFMSPushLite *mfmsPush;

@property (nonatomic, weak, nullable) id <ThreadsDelegate> delegate;

/**
 Switch between test and production mfms server. Default value is NO
 */
@property (nonatomic, assign, readonly) BOOL isProductionMFMSServer;

/**
 Client id encryption information
 */
@property (nonatomic, assign) BOOL isClientIdEncrypted;


/**
 Boolean parameneter, which enable or disable Google Analytics
 */
@property (nonatomic, assign) BOOL isAnalyticsEnabled;


/**
 Debug logging enabling paramter
 */
@property (nonatomic, assign) BOOL isDebugLoggingEnabled;


@property (nonatomic, assign) BOOL isSocketAdditionalDebugLoggingEnabled;

/**
 Status bar network activity indicator
 */
@property (nonatomic, assign) BOOL isShowsNetworkActivity;


/**
 Unique client identifier, required parameter.
 */
@property (nonatomic, copy, nullable, readonly) NSString *clientId;


/**
 Name of user
 */
@property (nonatomic, copy, nullable, readonly) NSString *clientName;


/**
 Threads support connecting multiple apps to a single server.
 Configure the appMarker identifier on the server and in app.
 As appMarker can be any unique string. appMarker should be the same for corresponding Android and iOS applications.
 */
@property (nonatomic, copy, nullable, readonly) NSString *appMarker;


/**
 The clientId authorization signature, the signature should be generated on your server
 based on the clientId using the RSA private key, then encrypted in Base64.
 Under the general scheme of work with the signature, see the documentation for Threads-API.
 */
@property (nonatomic, copy, nullable, readonly) NSString *clientSignature;


/**
 Check for setting client
 */
@property (nonatomic, assign, readonly) BOOL isClientSet;


/**
 Custom data. See more details in Threads-API documentation.
 */
@property (nonatomic, copy, nullable, readonly) NSString *data;

/**
 File size limit in bytes.
 Default value is 30 MB (30 * 1024 * 1024).
 */
@property (nonatomic, readwrite) NSInteger fileSizeLimit;


#pragma mark - Chat Configuration

@property (strong, nonatomic, readonly) THRAttributes *attributes;


/**
 Histoly URL
 */
@property (nonatomic, copy, nullable) NSURL *historyURL;


/**
 File uploading URL
 */
@property (nonatomic, copy, nullable) NSURL *fileUploadingURL;


/*!
 * Returns Threads singletone
 */
+ (instancetype)threads NS_SWIFT_NAME(threads());

#pragma mark - Integration


/**
 Initial MFMS configuration

 @param delegate Threads delegate object
 @param productionMFMSServer Switch between test and production MFMS server
 @param historyURL History server url
 @param fileUploadingURL File uploading server url
 */
- (void)configurePushTransportProtocolWithDelegate:(id<ThreadsDelegate> _Nullable)delegate productionMFMSServer:(BOOL)productionMFMSServer historyURL:(NSURL *)historyURL fileUploadingURL:(NSURL *)fileUploadingURL;

/**
 Initial Threads Gate configuration

 @param delegate Threads delegate object
 @param historyURL History server url
 @param webSocketURL WebSocket server url
 @param providerUid Provider Uid
 @param fileUploadingURL File uploading server url
 */
- (void)configureThreadsGateTransportProtocolWithDelegate:(id<ThreadsDelegate> _Nullable)delegate webSocketURL:(NSURL *)webSocketURL providerUid:(NSString *)providerUid historyURL:(NSURL *)historyURL fileUploadingURL:(NSURL *)fileUploadingURL;

/**
 Register application for APNS remote notification

 @param authorizationStatusDenied callback will be called when user decline push notification authorization request
 @param completionHandler callback will be called when user accept push notification authorization request. Callback will be called with device token if it is successfully received
 */
- (void)registerApplicationForRemoteNotificationsStandartOptionsWithAuthorizationStatusDenied:(void (^)(void))authorizationStatusDenied completionHandler:(THRRemoteNotificationsRegistrationCompletion _Nonnull)completionHandler;


/**
 Call only in AppDelegate method:
 - (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings

 @param notificationSettings Put received data from parameter notificationSettings
 */
- (void)applicationDidRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings;


/**
 Call only in AppDelegate method:
 - (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken

 @param deviceToken Put received data from parameter deviceToken
 */
- (void)applicationDidRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;


/**
 Call only in AppDelegate method:
 - (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error

 @param error Put received data from parameter error
 */
- (void)applicationDidFailToRegisterForRemoteNotificationsWithError:(NSError *)error;


/**
 Call only in AppDelegate method:
 - (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo

 @param userInfo Put received data from parameter userInfo
 */
- (void)applicationDidReceiveRemoteNotification:(NSDictionary *)userInfo;


/**
 Call only in AppDelegate methods:
 - (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
 - (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler

 @param userInfo Put received data from parameter userInfo
 @param completionHandler Put received data from parameter completionHandler
 */
- (void)applicationDidReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(THRMessageRecieveState state))completionHandler;


#pragma mark - Client Registration


/**
 Client configuration

 @param id Unique client identifier, required parameter. For example, you can use the user’s phone number.
 @param name Name of user
 @param data custom data, json key-value pairs string
 @param appMarker hreads support connecting multiple apps to a single server. Configure the appMarker identifier on the server and in app. As appMarker can be any unique string. appMarker should be the same for corresponding Android and iOS applications.
 @param signature The clientId authorization signature, the signature should be generated on your server based on the clientId using the RSA private key, then encrypted in Base64. Under the general scheme of work with the signature, see the documentation for Threads-API.
 */
- (void)setClientWithId:(NSString *)id name:(NSString * _Nullable)name data:(NSString * _Nullable)data appMarker:(NSString * _Nullable)appMarker signature:(NSString * _Nullable)signature;


/**
 Logout client and delete all stored data
 */
- (void)logout;


/**
 Logout client with specific id

 @param clientId Unique client identifier, required parameter.
 */
- (void)logoutWithClientId:(NSString *)clientId;

#pragma mark - Chat UIViewController


/**
 Get Chat UIViewController without completion handler

 @param attributes chat attributes
 @return chat UIViewController
 */
- (UIViewController *)chatViewControllerWithAttributes:(THRAttributes *)attributes;


/**
 Get Chat UIViewController

 @param attributes chat attributes
 @param completionHandler chat initialization and registration result
 @return chat UIViewController
 */
- (UIViewController *)chatViewControllerWithAttributes:(THRAttributes *)attributes completionHandler:(THROperationCompletion _Nullable)completionHandler;

#pragma mark - Utilites


/**
 Get current Threads lib version

 @return String value like 0.0.0
 */
- (NSString *)version;

- (NSUInteger) unreadMessagesCount;

/**
 Delete all cached images
 */
- (void)clearCachedFiles;


/**
 Check push userInfo for Threads

 @param userInfo push notification userInfo
 @return BOOL
 */
- (BOOL)isThreadsOriginPushUserInfo:(NSDictionary *)userInfo;


/**
 Get appMarker parameter from push userInfo

 @param userInfo push userInfo
 @return appMareker
 */
- (NSString *)getAppMarkerFromPushUserInfo:(NSDictionary *)userInfo;


/**
 Send text message from user programmaticaly

 @param text message text
 @param completion message submission result
 */
- (void)sendMessageWithText:(NSString *)text completion:(nullable THROperationCompletion)completion;


/**
 Send picture message from user programmaticaly

 @param image message image
 @param completion message submission result
 */
- (void)sendMessageWithImage:(UIImage *)image completion:(nullable THROperationCompletion)completion;

@end

NS_ASSUME_NONNULL_END
