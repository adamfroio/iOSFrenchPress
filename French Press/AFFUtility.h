//
//  AFFUtility.h
//  French Press
//
//  Created by Adam F Froio on 9/24/14.
//  Copyright (c) 2014 Adam F Froio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFFUtility : NSObject

+ (NSNumber *)secondsForTimeString:(NSString *)string;
+ (NSString *)timeFormatted:(int)totalSeconds;

@end
