//
//  Configuration.m
//  ThreadsDemoObjc
//
//  Created by Vitaliy Kuzmenko on 06/08/2019.
//  Copyright © 2019 Threads. All rights reserved.
//

#import "Configuration.h"
#import <Threads/Threads.h>
#import "SignatureService.h"

@implementation Configuration
    
+ (NSString *)stringForKey:(NSString *)key {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:key];
}
    
+ (BOOL)boolForKey:(NSString *)key {
    return [[[NSBundle mainBundle] objectForInfoDictionaryKey:key] isEqualToString:@"YES"] ? YES : NO;
}
    
+ (NSString *)summary {
    
    NSArray <NSString *> *array = @[NSLocalizedString(@"Configuration:", @""),
                                    @"",
                                    [NSString stringWithFormat:NSLocalizedString(@"Language: %@", @""), [self stringForKey:@"DEVELOPMENT_LANGUAGE"]],
                                    [NSString stringWithFormat:NSLocalizedString(@"Bundle Identifier: %@", @""), [self stringForKey:@"CFBundleIdentifier"]],
                                    [NSString stringWithFormat:NSLocalizedString(@"App Name: %@", @""), [self stringForKey:@"CFBundleName"]],
                                    [NSString stringWithFormat:NSLocalizedString(@"App Version: %@", @""), [self stringForKey:@"CFBundleShortVersionString"]],
                                    [NSString stringWithFormat:NSLocalizedString(@"Lib Version: %@", @""), [Threads threads].version],
                                    @"",
                                    [NSString stringWithFormat:@"debugLoggingEnabled: %@", [Threads threads].isDebugLoggingEnabled ? @"YES" : @"NO"],
                                    [NSString stringWithFormat:@"productionMSMFServerEnabled: %@", [Threads threads].isProductionMFMSServer ? @"YES" : @"NO"],
                                    [NSString stringWithFormat:@"clientIdEncrypted: %@", [Threads threads].isClientIdEncrypted ? @"YES" : @"NO"],
                                    @"",
                                    [NSString stringWithFormat:@"historyURL: %@", [Threads threads].historyURL],
                                    [NSString stringWithFormat:@"fileUploadingURL: %@", [Threads threads].fileUploadingURL],
                                    [NSString stringWithFormat:@"signatureServerURL: %@", [SignatureService sharedInstance].serverURL]];
    
    return [array componentsJoinedByString:@"\n"];
}

    
@end
