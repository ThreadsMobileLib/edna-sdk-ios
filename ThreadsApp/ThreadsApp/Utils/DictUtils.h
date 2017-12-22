//
//  DictionaryUtils.h
//  ThreadsApp
//
//  Created by Brooma Service on 15/12/2017.
//  Copyright © 2017 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DictUtils : NSObject

+ (NSString *) getStringFrom: (NSDictionary*) dict byKey: (NSString *) key;

+ (NSArray *) getArrayFrom: (NSDictionary*) dict byKey: (NSString *) key;

+ (BOOL) checkDict: (NSDictionary*) dict hasKey: (NSString*) key;

@end
