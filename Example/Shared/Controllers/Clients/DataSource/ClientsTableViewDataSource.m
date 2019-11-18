//
//  ClientsTableViewDataSource.m
//  ExampleSwift
//
//  Created by Vitaliy Kuzmenko on 07/08/2019.
//  Copyright © 2019 Threads. All rights reserved.
//

#import "ClientsTableViewDataSource.h"
#import "Storage.h"
#import "ClientTableViewCell.h"
#import "Configuration.h"

@interface ClientsTableViewDataSource () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray<Client *> *clients;

@end

@implementation ClientsTableViewDataSource

- (instancetype)init {
    self = [super init];
    if (self) {
        [self configureClientsObserver];
    }
    return self;
}

- (void)configureClientsObserver {
    __weak typeof(self) weakSelf = self;
    [[Storage sharedInstance] setClientsObserver:^(NSArray<Client *> * _Nonnull clients) {
        weakSelf.clients = clients;
        if (![self activateFirstAvailableClientIfNeeded]) {
            [weakSelf.tableView reloadData];
        }
    }];
}

- (void) reactivateLastClient {
    
    for (int row = 0; row < self.clients.count; row++) {
        Client* client = self.clients[row];
        
        if ([self.delegate isActiveClient:client]) {
            [self.delegate activateClient: client];
            [self.tableView reloadRowsAtIndexPaths : @[[NSIndexPath indexPathForRow:row inSection:0]]
                                  withRowAnimation : UITableViewRowAnimationAutomatic];
        }
    }
}

- (BOOL)activateFirstAvailableClientIfNeeded {
    if (!self.clients.count) {
        return NO;
    }
    if ([self.delegate isClientSet]) { return NO; }
    Client *client = [self.clients firstObject];
    [self.delegate activateClient:client];
    [self.tableView reloadData];
    return YES;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.clients.count) {
        return self.clients.count;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.clients.count) {
        Client *client = self.clients[indexPath.row];
        ClientTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ClientTableViewCell class]) forIndexPath:indexPath];
        [cell configureForClient:client];
        cell.accessoryType = [self.delegate isActiveClient:client] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
        return cell;
    } else {
        return [tableView dequeueReusableCellWithIdentifier:@"NoClients" forIndexPath:indexPath];
    }
}

#pragma mark - UITableViewDelegate

- (BOOL)isClientIndexPath:(NSIndexPath *)indexPath {
    return [[self.tableView cellForRowAtIndexPath:indexPath] isKindOfClass:[ClientTableViewCell class]];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self isClientIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    Client *client = self.clients[indexPath.row];
    [self.delegate didDelete:client];
    [[Storage sharedInstance] removeClient:client];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (![self isClientIndexPath:indexPath]) { return; }
    Client *client = self.clients[indexPath.row];
    if (![self.delegate isActiveClient:client]) {
        [self.delegate activateClient:client];
        [self.tableView reloadData];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return [Configuration summary];
}

@end
