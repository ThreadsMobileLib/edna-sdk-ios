//
//  Storage.m
//  ThreadsDemoObjc
//
//  Created by Vitaliy Kuzmenko on 23/07/2019.
//  Copyright © 2019 Threads. All rights reserved.
//

#import "Storage.h"
#import "Client.h"

@interface Storage()

@property (nonatomic, strong) NSMutableArray<Client *> *clientsArray;

@property (nonatomic, copy, nullable) void (^clientsObserver)(NSArray<Client *> * clients);

@end

@implementation Storage

+ (instancetype)sharedInstance {
    static id instance = nil;
    static dispatch_once_t onceSecurePredicate;
    dispatch_once(&onceSecurePredicate,^{
        instance = [self new];
        [instance loadClients];
    });
    return instance;
}

- (NSURL *)dataFileURL {
    NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    return [documentsURL URLByAppendingPathComponent:@"Clients.plist"];
}

- (void)addClient:(Client *)client {
    [self.clientsArray addObject:client];
    [self saveClients];
}

- (void)removeClient:(Client *)client {
    [self.clientsArray removeObject:client];
    [self saveClients];
}

- (void)loadClients {
    NSData *data = [NSData dataWithContentsOfURL:[self dataFileURL]];
    NSArray *clients = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    self.clientsArray = [[NSMutableArray alloc] initWithArray:clients];
}

- (void)saveClients {
    NSError *error;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.clientsArray];
    [data writeToURL:[self dataFileURL] options:NSDataWritingAtomic error:&error];
    if (error) {
        NSLog(@"Writing Error: %@", error.localizedDescription);
    }
    if (self.clientsObserver) {
        self.clientsObserver(self.clientsArray);
    }
}

- (NSArray<Client *> *)getClients {
    return self.clientsArray;
}

- (void)setClientsArray:(NSMutableArray<Client *> *)clientsArray {
    _clientsArray = clientsArray;
    if (self.clientsObserver) {
        self.clientsObserver(clientsArray);
    }
}

- (void)setClientsObserver:(void (^)(NSArray<Client *> * _Nonnull clients))clientsObserver {
    _clientsObserver = clientsObserver;
    clientsObserver(self.clientsArray);
}

@end
