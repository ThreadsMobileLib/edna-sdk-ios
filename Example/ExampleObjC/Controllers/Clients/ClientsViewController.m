//
//  ClientsViewController.m
//  ThreadsDemoObjc
//
//  Created by Vitaliy Kuzmenko on 22/07/2019.
//  Copyright © 2019 Threads. All rights reserved.
//

#import "ClientsViewController.h"
#import <Threads/Threads.h>
#import "Client.h"
#import "ClientsTableViewDataSource.h"

@interface ClientsViewController () <ClientsTableViewDataSourceDelegate>

@property (nonatomic, strong) IBOutlet ClientsTableViewDataSource *clientsTableViewDataSource;

@end

@implementation ClientsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.clientsTableViewDataSource reactivateLastClient];
}
    
- (BOOL)isClientSet {
    return [Threads threads].isClientSet;
}

- (BOOL)isActiveClient:(Client *)client {
    return [[Threads threads].clientId isEqualToString:client.id];
}

- (void)activateClient:(Client *)client {
    [[Threads threads] setClientWithId:client.id
                                  name:client.name
                                  data:@"{\"param1\": \"value1\"}"
                             appMarker:client.appMarker
                             signature:client.signature];
}

- (void)didDelete:(Client *)client {
    if ([self isActiveClient:client]) {
        [[Threads threads] logout];
    } else {
        [[Threads threads] logoutWithClientId:client.id];
    }
}

@end
