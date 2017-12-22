//
//  TAStorage.m
//  ThreadsApp
//
//  Created by Brooma Service on 31/10/2017.
//  Copyright © 2017 Brooma Service. All rights reserved.
//

#import "TAStorage.h"
#import "DictUtils.h"

static NSString* kTAMainFolder             = @"TAMainFolder";

static NSString* kClientsInfoFolder          = @"TAClientsInfo";
static NSString* kClientIdsFile              = @"TAClients.json";

static NSString* kClientsKey = @"clients";


@implementation TAStorage

+ (instancetype) sharedInstance {
    static id instance = nil;
    static dispatch_once_t onceSecurePredicate;
    dispatch_once(&onceSecurePredicate,^{
        instance = [self new];
    });
    [instance createClientDirectoryIfNeed];
    return instance;
}

- (void) createClientDirectoryIfNeed {
    BOOL isDir;
    NSString *directory = [self clientDirectory];
    if (!directory)
        return;
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath: directory isDirectory: &isDir])
        [fm createDirectoryAtPath: directory
      withIntermediateDirectories: YES
                       attributes: nil
                            error: nil];
}

#pragma mark - Folders

- (NSString *) appDirectory {
    NSString *appDirectory = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    return appDirectory;
}

- (NSString *) thrDirectory {
    NSString *thrDirectory = [self.appDirectory stringByAppendingPathComponent:kTAMainFolder];
    return thrDirectory;
}

- (NSString *) clientDirectory {
    return [self directoryWithFolder: kClientsInfoFolder inRoot: YES];
}

- (NSString *) directoryWithFolder: (NSString*) folder {
    return [self directoryWithFolder: folder inRoot: NO];
}

- (NSString *) directoryWithFolder: (NSString*) folder inRoot: (BOOL) inRoot {
    NSString *directory = (inRoot) ? self.thrDirectory : self.clientDirectory;
    if (!directory)
        return nil;
    NSString* directoryPath = [directory stringByAppendingPathComponent: folder];
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSError* error = nil;
    if (![fileManager createDirectoryAtPath: directoryPath
                withIntermediateDirectories: YES
                                 attributes: nil
                                      error: &error]){
        NSLog(@"Create directory error: %@", error);
    }
    return directoryPath;
}

- (void) setClients: (NSArray<Client*>*) clients {
    
    NSString *path = [self.clientDirectory stringByAppendingPathComponent: kClientIdsFile];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[kClientsKey] = clients;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL created = [fileManager createFileAtPath: path
                                        contents: [NSKeyedArchiver archivedDataWithRootObject:params]
                                      attributes: nil];
    NSLog(@"created = %@", @(created));
}

- (NSMutableArray<Client*>*) getClients {
    
    NSString *path = [self.clientDirectory stringByAppendingPathComponent: kClientIdsFile];
    NSDictionary *params = [self getJSONContentOfFile:path];
    
    if(params[kClientsKey]){
        return [[DictUtils getArrayFrom: params byKey: kClientsKey] mutableCopy];
    }
    return [@[] mutableCopy];
}

- (void) addClient: (Client*) newClient {
    
    NSMutableArray<Client*>* clients = [self getClients];
    [clients addObject: newClient];
    [self setClients: clients];
}

- (void) removeClient: (Client*) clientToRemove {
    
    NSMutableArray<Client*>* clients = [self getClients];
    
    for (NSInteger index =0; index < clients.count; index++) {
        Client* client = [clients objectAtIndex: index];
        if ([client.clientId isEqualToString: clientToRemove.clientId]) {
            [clients removeObject: client];
            index--;
        }
    }
    
    [self setClients: clients];
}

#pragma mark - Helpers

- (void) log {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    for (NSString *item in [fileManager contentsOfDirectoryAtPath:self.appDirectory error:&error]) {
        NSString *fullPath = [self.appDirectory stringByAppendingPathComponent:item];
        NSLog(@"item = %@", item);
        BOOL isDirectory;
        if ([fileManager fileExistsAtPath:fullPath isDirectory:&isDirectory]) {
            if (isDirectory) {
                for (NSString *jtem in [fileManager contentsOfDirectoryAtPath:fullPath error:&error]) {
                    NSLog(@"\tjtem = %@", jtem);
                }
            }
        }
        //NSData *data = [NSData dataWithContentsOfFile:[self.messagesDirectory stringByAppendingPathComponent:item]];
        //NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        //NSLog(@"content = %@", dict);
    }
}

- (NSMutableDictionary *) getJSONContentOfFile:(NSString *)path{
    NSData *data = [NSData dataWithContentsOfFile: path];
    if(data) {
        NSMutableDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData: data];
        return dict;
    }
    return [NSMutableDictionary dictionary];
}

@end

