//
//  THROpenUrlUtils.h
//  Threads
//
//  Copyright © 2020 edna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface THROpenUrlUtils : NSObject

+ (BOOL) allowOpenUrl:(NSURL *) openUrl;

+ (void) openUrl:(NSURL *) openUrl;

@end

NS_ASSUME_NONNULL_END
