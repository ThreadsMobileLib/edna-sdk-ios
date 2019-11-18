//
//  IntegrationsViewController+BRS.h
//  ExampleObjC
//
//  Created by Vitaliy Kuzmenko on 12/08/2019.
//  Copyright © 2019 Threads. All rights reserved.
//

#import "IntegrationsViewController.h"
#import <Threads/Threads.h>

NS_ASSUME_NONNULL_BEGIN

@interface IntegrationsViewController (BRS)

- (THRAttributes *)getBRSAttributes;

@end

NS_ASSUME_NONNULL_END
