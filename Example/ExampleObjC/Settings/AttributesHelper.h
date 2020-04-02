//
//  AttributesHelper.h
//  ExampleObjC
//
//  Created by Brooma Service on 20.12.2019.
//  Copyright © 2019 Threads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Threads/Threads.h>

NS_ASSUME_NONNULL_BEGIN

@interface AttributesHelper : NSObject

+ (THRAttributes*) getDefaultAttributes;

+ (THRAttributes*) getAltAttributes;

@end

NS_ASSUME_NONNULL_END
