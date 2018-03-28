//
//  CellTypeHelper.h
//  ThreadsApp
//
//  Created by Tabriz Dzhavadov on 13/07/2017.
//  Copyright © 2017 Brooma Service. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    CellTypeVersion,
    CellTypeDesign,
    CellTypeDebugMode,
    CellTypeToFragmentChat,
    CellTypeToFullChat,
    CellTypeCount
} CellType;

@interface CellTypeHelper : NSObject

+ (NSString *) textByType: (CellType) type;

@end
