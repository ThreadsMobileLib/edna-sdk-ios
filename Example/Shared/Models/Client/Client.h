//
//  User.h
//  ThreadsDemoObjc
//
//  Created by Vitaliy Kuzmenko on 23/07/2019.
//  Copyright © 2019 Threads. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Client: NSObject <NSCoding>

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *appMarker;

@property (nonatomic, copy) NSString *signature;

+ (instancetype)clientWithId:(NSString *)id name:(NSString *)name appMarker:(NSString *)appMarker signature:(NSString *)signature;

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder;

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder;

@end

NS_ASSUME_NONNULL_END
