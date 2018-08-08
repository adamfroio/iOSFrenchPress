//
//  AppDelegate.h
//  French Press
//
//  Created by Adam F Froio on 9/24/14.
//  Copyright (c) 2014 Adam F Froio. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const AFFSteepSecsPrefsKey;       // seconds to steep
extern NSString * const AFFBloomSecsPrefsKey;       // seconds to bloom
extern NSString * const AFFPreventSleepPrefsKey;    // prevent sleep?  YES / NO
extern NSString * const AFFEnableBloomPrefsKey;     // enable bloom timer?  YES / NO

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

