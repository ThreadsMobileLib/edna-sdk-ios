//
//  ClientTableViewCell.h
//  ThreadsDemoObjc
//
//  Created by Vitaliy Kuzmenko on 23/07/2019.
//  Copyright © 2019 Threads. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class Client;

@interface ClientTableViewCell : UITableViewCell

- (void)configureForClient:(Client *)client;

@end

NS_ASSUME_NONNULL_END
