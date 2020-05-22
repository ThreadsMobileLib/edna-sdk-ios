//
//  Storage.h
//  ThreadsDemoObjc
//
//  Created by Vitaliy Kuzmenko on 23/07/2019.
//  Copyright © 2019 Threads. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class Client;

@interface Storage : NSObject

+ (instancetype)sharedInstance;

- (void)addClient:(Client *)client;

- (void)removeClient:(Client *)client;

- (NSArray<Client *> *)getClients;

- (void)setClientsObserver:(void (^)(NSArray<Client *> * _Nonnull clients))clientsObserver;

@end

NS_ASSUME_NONNULL_END
