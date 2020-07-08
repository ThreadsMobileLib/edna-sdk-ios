//
//  THRObject.h
//  Threads
//
//  Created by Nikolay Kagala on 01/06/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THRObject : NSObject

@property (copy, nonatomic, readwrite) NSString* identifier;

- (instancetype) initWithIdentifier: (NSString*) identifier NS_DESIGNATED_INITIALIZER;

@end
