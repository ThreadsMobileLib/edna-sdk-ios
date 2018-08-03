//
//  THRCompatibility.h
//  Threads
//
//  Created by Nikolay Kagala on 30/05/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#pragma once

#define THR_UNAVAILABLE(x) __attribute__((unavailable(x)))

#if __has_feature(nullability)
    #define thr_nullable           nullable
    #define thr_nonnull            nonnull
    #define __thr_nullable         __nullable
    #define __thr_nonnull          __nonnull
#else
    #define thr_nullable
    #define thr_nonnull
    #define __thr_nullable
    #define __thr_nonnull
#endif

#ifndef NS_ASSUME_NONNULL_BEGIN
    #define NS_ASSUME_NONNULL_BEGIN
#endif

#ifndef NS_ASSUME_NONNULL_END
    #define NS_ASSUME_NONNULL_END
#endif