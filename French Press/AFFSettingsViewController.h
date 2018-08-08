//
//  AFFSettingsViewController.h
//  French Press
//
//  Created by Adam F Froio on 9/24/14.
//  Copyright (c) 2014 Adam F Froio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AFFSettingsViewController : UIViewController
{
    NSString *savedSteepTime;           // The string last saved in USER PREFERENCES
    NSString *savedBloomTime;           // The string last saved in USER PREFERENCES
    NSNumberFormatter *numberFormatter; // Used to auto-format the timer text
}

@end
