//
//  PlistUtils.h
//  ThreadsApp
//
//  Created by Brooma Service on 02/04/2019.
//  Copyright © 2019 Brooma Service. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlistUtils : NSObject

+ (NSString *) getStringFrom: (NSString*) dictName byKey: (NSString *) key;

+ (NSString*) getStringFromPlist: (NSString*) key;

+ (NSString*) getAppVersion;

@end

NS_ASSUME_NONNULL_END
