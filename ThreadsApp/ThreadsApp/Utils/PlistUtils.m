//
//  PlistUtils.m
//  ThreadsApp
//
//  Created by Brooma Service on 02/04/2019.
//  Copyright © 2019 Brooma Service. All rights reserved.
//

#import "PlistUtils.h"

@implementation PlistUtils

+ (NSString *) getStringFrom: (NSString*) dictName byKey: (NSString *) key {
    
    NSString* value = nil;
    
    NSDictionary* plistDict = [[NSBundle mainBundle] objectForInfoDictionaryKey: dictName];
    
    if (plistDict && ![plistDict isEqual: [NSNull null]]) {
        value = [plistDict objectForKey: key];
    }
    
    return value;
}

+ (NSString*) getStringFromPlist: (NSString*) key {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey: key];
}

+ (NSString*) getAppVersion {
    return [self getStringFromPlist:@"CFBundleShortVersionString"];
}

@end
