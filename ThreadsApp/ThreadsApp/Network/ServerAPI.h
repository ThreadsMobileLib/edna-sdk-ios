//
//  ServerAPI.h
//  ThreadsApp
//
//  Created by Brooma Service on 02/04/2019.
//  Copyright © 2019 Brooma Service. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^THRClientIdSignatureCompletion)( NSString* _Nullable signature,  NSError* _Nullable error);

@interface ServerAPI : NSObject

+ (void) getClientIdSignature: (NSString*) clientId withCompletion: (THRClientIdSignatureCompletion) completion;

@end

NS_ASSUME_NONNULL_END
