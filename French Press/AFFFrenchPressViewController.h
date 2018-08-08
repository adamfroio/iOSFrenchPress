//
//  ViewController.h
//  French Press
//
//  Created by Adam F Froio on 9/24/14.
//  Copyright (c) 2014 Adam F Froio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface AFFFrenchPressViewController : UIViewController
{
    int currMinute;                 // Used to initialize timer in roundButtonDidTap:
    int currSecond;                 // Used to initialize timer in roundButtonDidTap:
    int currBloomSecond;            // Counter for bloom timer
    int currBloomMinute;            // Counter for bloom timer
    int steepSecs;                  // Steep Time
    int bloomSecs;                  // Bloom Time
    bool preventSleep;              // Prevent Sleep
    bool enableBlooom;              // Enable Bloom Timer
    CFURLRef soundFileURLRef;       // Used to construct the path to the alarm sound file object
    SystemSoundID soundID;          // Used to construct the path to the alarm sound file object
    NSTimer *steepTimer;            // The main timer object
    NSDate *steepTimerStartDate;    // Used to initialize timer in roundButtonDidTap:
    UILocalNotification *alarm;     // Notifcation for the steep timer completing
    UILocalNotification *bloom;     // Notifcation for the bloom timer completing
}

@property (readwrite)   CFURLRef        soundFileURLRef;
@property (readonly)    SystemSoundID   soundID;

- (void)refreshFromBackground;
- (void)orientationChanged:(NSNotification *)note;
- (void)roundButtonDidTap:(UIButton *)tappedButton;
- (void)playAlarm;
- (void)canRotate;

@end

