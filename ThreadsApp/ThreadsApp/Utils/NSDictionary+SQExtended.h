//
//  NSDictionary+SQExtended.h
//  GeoSearch
//
//  Created by Nikolay Kagala on 04/02/16.
//  Copyright © 2016 Brooma Service. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SQExtended)

- (NSString*)sq_urlEncodedString;

- (NSArray*)sq_valuesForKeys: (NSArray*) keys;

- (NSString *)sq_jsonString;

//JSON parse functions

- (BOOL) sq_hasKey: (NSString *) key;

- (NSInteger) sq_getIntegerByKey: (NSString *) key;

- (float) sq_getFloatByKey: (NSString *) key;
- (double) sq_getDoubleByKey: (NSString *) key;

- (NSString *) sq_getStringByKey: (NSString *) key;

- (BOOL) sq_getBoolByKey: (NSString *) key;

- (NSDictionary *) sq_getDictionaryByKey: (NSString *) key;

- (NSArray *) sq_getArrayByKey: (NSString *) key;

@end
