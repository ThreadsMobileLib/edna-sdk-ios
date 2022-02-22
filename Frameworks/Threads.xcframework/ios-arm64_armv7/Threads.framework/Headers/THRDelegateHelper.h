//
//  THRDelegateHelper.h
//  Threads
//
//  Created by Алексей Химунин on 18.01.2022.
//  Copyright © 2022 Threads. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface THRDelegateHelper : NSObject
+ (void)callDidReceiveResponse:(NSDictionary * _Nullable)response;
@end

NS_ASSUME_NONNULL_END
