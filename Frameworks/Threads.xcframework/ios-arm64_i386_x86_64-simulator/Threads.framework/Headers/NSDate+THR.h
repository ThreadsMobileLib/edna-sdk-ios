//
//  NSDate+THR.h
//  Threads
//
//  Created by Tabriz Dzhavadov on 24/05/2017.
//  Copyright © 2017 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (THR)

- (NSDate * _Nonnull) thr_toLocalTime;

- (NSDate * _Nonnull) thr_toGlobalTime;

+ (NSDate *) thr_dateFromServerString: (NSString*) serverDateString;

@end

@interface NSDateFormatter (THR)

+ (NSDateFormatter *) thr_formatterWithFormat: (NSString*) format;

+ (NSDateFormatter* _Nonnull) thr_severDateFormatter;

+ (NSDateFormatter * _Nonnull) thr_dateFormatterMessageDate;

@end
