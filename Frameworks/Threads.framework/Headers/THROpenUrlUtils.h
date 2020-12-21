//
//  THROpenUrlUtils.h
//  Threads
//
//  Created by Алексей Химунин on 11.12.2020.
//  Copyright © 2020 Threads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface THROpenUrlUtils : NSObject

+ (BOOL) allowOpenUrl:(NSURL *) openUrl;

+ (void) openUrl:(NSURL *) openUrl;

@end

NS_ASSUME_NONNULL_END
