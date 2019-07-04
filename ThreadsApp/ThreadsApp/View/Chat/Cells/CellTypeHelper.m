//
//  CellTypeHelper.m
//  ThreadsApp
//
//  Created by Tabriz Dzhavadov on 13/07/2017.
//  Copyright © 2017 Brooma Service. All rights reserved.
//

#import "CellTypeHelper.h"
#import <Threads/Threads.h>
#import "PlistUtils.h"

@implementation CellTypeHelper

+ (NSString *) textByType: (CellType) type {
    if (type == CellTypeVersion) {
        return [NSString stringWithFormat: @"ThreadsLib - v%@\nThreadsApp - v%@", [Threads version], [PlistUtils getAppVersion]];
    } else if (type == CellTypeDebugMode) {
        return @"Debug-mode";
    } else if (type == CellTypeDesign) {
        return @"Design";
    } else if (type == CellTypeToFragmentChat) {
        return [NSString stringWithFormat: @"%@ %@",
                NSLocalizedString(@"show_chat_title", nil),
                NSLocalizedString(@"chat_fragment_title", nil)];
    } else if (type == CellTypeToFullChat) {
        return [NSString stringWithFormat: @"%@ %@",
                NSLocalizedString(@"show_chat_title", nil),
                NSLocalizedString(@"chat_full_controller_title", nil)];
    } else if (type == CellTypeToOtherChats) {
        return @"Other Chat Integrations";
    } else if (type == CellTypeToOutsideTextMessage) {
        return @"Outside Text Message";
    } else if (type == CellTypeToOutsideImageMessage) {
        return @"Outside Image Message";
    } else {
        return @"unknown type";
    }
}

@end
