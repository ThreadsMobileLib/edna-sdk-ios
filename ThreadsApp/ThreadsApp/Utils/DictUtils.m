//
//  DictionaryUtils.m
//  ThreadsApp
//
//  Created by Brooma Service on 15/12/2017.
//  Copyright © 2017 Sequenia. All rights reserved.
//

#import "DictUtils.h"

@implementation DictUtils

+ (NSString *) getStringFrom: (NSDictionary*) dict byKey: (NSString *) key {
    return [self checkDict:dict hasKey:key] ? [dict objectForKey:key] : @"";
}

+ (NSArray *) getArrayFrom: (NSDictionary*) dict byKey: (NSString *) key {
    return [self checkDict: dict hasKey:key] ? [dict objectForKey:key] : [NSArray array];
}

+ (BOOL) checkDict: (NSDictionary*) dict hasKey: (NSString*) key {
    if ([dict objectForKey:key] && [dict objectForKey:key] != [NSNull null])
        return YES;
    else
        return NO;
}

@end
