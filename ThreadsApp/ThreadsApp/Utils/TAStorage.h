//
//  TAStorage.h
//  ThreadsApp
//
//  Created by Brooma Service on 31/10/2017.
//  Copyright © 2017 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Client.h"

@interface TAStorage : NSObject

+ (instancetype)sharedInstance;

- (void) setClients: (NSArray<Client*>*) clients;

- (NSMutableArray<Client*>*) getClients;

- (void) addClient: (Client*) client;

- (void) removeClient: (Client*) client;

@end
