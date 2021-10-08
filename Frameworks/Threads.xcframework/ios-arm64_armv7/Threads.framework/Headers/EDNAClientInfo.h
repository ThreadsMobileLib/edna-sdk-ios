//
//  EDNAClientInfo.h
//  Threads
//
//  Created by Anton Bulankin on 15.09.2021.
//  Copyright © 2021 Threads. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EDNAClientInfo : NSObject

@property (strong, nonatomic) NSString * clientId;
@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSString * data;
@property (strong, nonatomic) NSString * appMarker;
@property (strong, nonatomic) NSString * signature;
@property (strong, nonatomic) NSString * authToken;
@property (strong, nonatomic) NSString * authSchema;

@end

NS_ASSUME_NONNULL_END
