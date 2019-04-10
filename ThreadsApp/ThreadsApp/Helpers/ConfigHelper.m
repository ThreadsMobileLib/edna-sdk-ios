//
//  ConfigHelper.m
//  ThreadsApp
//
//  Created by Brooma Service on 02/04/2019.
//  Copyright © 2019 Brooma Service. All rights reserved.
//

#import "ConfigHelper.h"
#import "PlistUtils.h"

NSString* const kTHRConfigDictKey = @"THR_APP_CONFIG";
NSString* const kTHRServerUrlKey = @"THR_SERVER_URL";

@implementation ConfigHelper

+ (NSString *) getServerUrl {
    return [PlistUtils getStringFrom: kTHRConfigDictKey byKey:kTHRServerUrlKey];
}

@end
