//
//  AFFUtility.m
//  French Press
//
//  Created by Adam F Froio on 9/24/14.
//  Copyright (c) 2014 Adam F Froio. All rights reserved.
//

#import "AFFUtility.h"

@implementation AFFUtility

// Take time in @"mm:ss" format and return the equivalent number of seconds
+ (NSNumber *)secondsForTimeString:(NSString *)string
{
    
    NSArray *components = [string componentsSeparatedByString:@":"];
    
    NSInteger minutes = [[components objectAtIndex:0] integerValue];
    NSInteger seconds = [[components objectAtIndex:1] integerValue];
    
    return [NSNumber numberWithInteger:(minutes * 60) + seconds];
}


// Take number of seconds and return the time in @"mm:ss" format
+ (NSString *)timeFormatted:(int)totalSeconds
{
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    if (minutes >= 10)
    {
        return [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
    }
    else
    {
        return [NSString stringWithFormat:@"%01d:%02d", minutes, seconds];
    }
}


@end
