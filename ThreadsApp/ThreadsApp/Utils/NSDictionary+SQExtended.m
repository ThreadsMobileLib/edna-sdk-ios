//
//  NSDictionary+SQExtended.m
//  GeoSearch
//
//  Created by Nikolay Kagala on 04/02/16.
//  Copyright © 2016 Brooma Service. All rights reserved.
//

#import "NSDictionary+SQExtended.h"

static NSString *toString(id object) {
    return [NSString stringWithFormat: @"%@", object];
}

static NSString *urlEncode(id object) {
    NSString *string = toString(object);
    return [string stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
}

@implementation NSDictionary (SQExtended)

- (NSString*)sq_urlEncodedString {
    NSMutableArray *parts = [NSMutableArray array];
    for (id key in self) {
        id value = [self objectForKey: key];
        NSString *part = [NSString stringWithFormat: @"%@=%@", urlEncode(key), urlEncode(value)];
        [parts addObject: part];
    }
    return [parts componentsJoinedByString: @"&"];
}

- (NSArray*)sq_valuesForKeys: (NSArray*) keys {
    NSMutableArray* values = nil;
    
    for (id key in keys) {
        if (![self.allKeys containsObject: key]){
            continue;
        }
        if (!values){
            values = [NSMutableArray arrayWithObject: self[key]];
        } else {
            [values addObject: self[key]];
        }
    }
    
    return values;
}

- (NSString *) sq_jsonString {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject: self
                                                       options: NSJSONWritingPrettyPrinted
                                                         error: &error];
    if (!jsonData) {
        NSLog(@"sq_jsonString: error: %@", error.localizedDescription);
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

- (NSInteger) sq_getIntegerByKey: (NSString *) key {
    return [self sq_hasKey:key] ? [[self objectForKey:key] integerValue] : 0;
}

- (float) sq_getFloatByKey: (NSString *) key {
    return [self sq_hasKey:key] ? [[self objectForKey:key] floatValue] : 0.0f;
}

- (float) sq_getDoubleByKey: (NSString *) key {
    return [self sq_hasKey:key] ? [[self objectForKey:key] doubleValue] : 0.0f;
}

- (NSString *) sq_getStringByKey: (NSString *) key {
    return [self sq_hasKey:key] ? [self objectForKey:key] : @"";
}

- (BOOL) sq_getBoolByKey: (NSString *) key {
    return [self sq_hasKey:key] ? [[self objectForKey:key] boolValue] : NO;
}

- (NSDictionary *) sq_getDictionaryByKey: (NSString *) key {
    return [self sq_hasKey:key] ? [self objectForKey:key] : [NSDictionary dictionary];
}

- (NSArray *) sq_getArrayByKey: (NSString *) key {
    return [self sq_hasKey:key] ? [self objectForKey:key] : [NSArray array];
}

- (BOOL) sq_hasKey: (NSString *) key {
    if ([self objectForKey:key] && [self objectForKey:key] != [NSNull null])
        return YES;
    else
        return NO;
}

@end
