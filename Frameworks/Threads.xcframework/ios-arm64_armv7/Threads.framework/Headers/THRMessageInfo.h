//
//  THRMessageInfo.h
//  Threads
//
//  Created by Anton Grishin on 13.12.2021.
//  Copyright © 2021 Threads. All rights reserved.
//

#ifndef THRMessageInfo_h
#define THRMessageInfo_h

@interface THRMessageInfo : NSObject

@property (nonatomic, readonly) NSString* senderName;
@property (nonatomic, readonly) NSString* text;

@end
#endif /* THRMessageInfo_h */
