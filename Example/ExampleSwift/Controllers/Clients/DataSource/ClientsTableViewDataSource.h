//
//  ClientsTableViewDataSource.h
//  ExampleSwift
//
//  Created by Vitaliy Kuzmenko on 07/08/2019.
//  Copyright © 2019 Threads. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ClientsTableViewDataSource, Client;

@protocol ClientsTableViewDataSourceDelegate <NSObject>

- (BOOL)isClientSet;

- (BOOL)isActiveClient:(Client *)client;

- (void)activateClient:(Client *)client;

- (void)didDelete:(Client *)client;

@end


@interface ClientsTableViewDataSource : NSObject

@property (nonatomic, weak) IBOutlet id<ClientsTableViewDataSourceDelegate>delegate;

- (void) reactivateLastClient;

@end

NS_ASSUME_NONNULL_END
