	//
//  ViewController.m
//  French Press
//
//  Created by Adam F Froio on 9/24/14.
//  Copyright (c) 2014 Adam F Froio. All rights reserved.
//

#import "AFFFrenchPressViewController.h"
#import "AppDelegate.h"
#import "AFFUtility.h"

@interface AFFFrenchPressViewController ()
@property (weak, nonatomic) IBOutlet UIButton *startButton;                                 // Start button
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;                                // Logo image
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;                                   // Timer label
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;                                  // Status Label
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timerLabelVerticalConstraint;      // Constraint that may need to be modified
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *startButtonVerticalConstraint;     // Constraint that may need to be modified
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *statusLabelVerticalConstraint;     // Constraint that may need to be modified
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timerLabelHeight;                  // Constraint that may need to be modified

@end

@implementation AFFFrenchPressViewController
@synthesize soundFileURLRef;
@synthesize soundID;

#define ROUND_BUTTON_WIDTH_HEIGHT 80    // Start button height
NSString *model;                        // Used to determine device type
UIColor *prettyGreen;                   // A pretty shade of green for the start button


// Prep the VIEW for display
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Read USER PREFERENCES
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    steepSecs = (int)[defaults integerForKey:AFFSteepSecsPrefsKey];         // get Steep Time
    bloomSecs = (int)[defaults integerForKey:AFFBloomSecsPrefsKey];         // get Bloom Time
    preventSleep = [defaults boolForKey:AFFPreventSleepPrefsKey];           // get Prevent Sleep
    enableBlooom = [defaults boolForKey:AFFEnableBloomPrefsKey];            // get Enable Bloom
    
    // Only update timer label if the timer is not running
    if ([[_startButton titleForState:UIControlStateNormal]  isEqual: @"Start"])
    {
        _timerLabel.text =  [AFFUtility timeFormatted:steepSecs];
    }
    
    NSURL *alarmSound   = [[NSBundle mainBundle] URLForResource: @"Alarm"
                                                  withExtension: @"aiff"];
    self.soundFileURLRef = (__bridge CFURLRef) alarmSound;
    AudioServicesCreateSystemSoundID (soundFileURLRef, &soundID);
    soundID = 1005;     // Alarm system sound
    
    // Run refreshFromBackground when the app is RESTORED FROM BACKGROUND
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshFromBackground)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    
    // Process notifications regarding ORIENTATION
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:[UIDevice currentDevice]];
    
    if ([[_startButton titleForState:UIControlStateNormal]  isEqual: @"Start"])
    {
        _statusLabel.hidden = YES;
    }
    
    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation))
    {
        self.navigationItem.titleView.hidden = YES;
        _logoImage.hidden = NO;
        self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"Gear.png"];
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
    else
    {
        self.navigationItem.titleView.hidden = NO;
        _logoImage.hidden = YES;
        if ([model isEqual:@"iPhone"] | [model isEqual:@"iPhone Simulator"] | [model isEqual:@"iPod touch"])
        {
            self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"Disabled.png"];
            self.navigationItem.rightBarButtonItem.enabled = NO;
        }
    }
    
    // See if we're dealing with a small screen (iPhone 4 or iPod touch)
    int boundsy = self.view.bounds.size.height;
    if (boundsy < 500)
    {
        _logoImage.image = [UIImage imageNamed:@"FPress100small.png"];
    }
    
    // Use a larger timer font if we're on an iPad
    if ([model isEqual:@"iPad"] | [model isEqual:@"iPad Simulator"])
    {
        _timerLabelHeight.constant = 130;
        [_timerLabel setFont:[UIFont systemFontOfSize:160]];
    }
    
    
    // Make the NAV BAR pretty
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1]];
}


// VIEW DID LOAD
- (void)viewDidLoad {
    [super viewDidLoad];    // Do any additional setup after loading the view, typically from a nib.

    // START BUTTON creation
    prettyGreen = [UIColor colorWithRed:93/255.0f green:174/255.0f blue:0/255.0f alpha:1.0f];
    [_startButton setTitle:@"Start"
                  forState:UIControlStateNormal];
    [_startButton setTitleColor:prettyGreen
                       forState:UIControlStateNormal];
    [_startButton setBackgroundColor:[UIColor whiteColor]];
    [_startButton addTarget:self
                     action:@selector(roundButtonDidTap:)
           forControlEvents:UIControlEventTouchUpInside];
    //width and height should be same value
    _startButton.frame = CGRectMake(120, 440, ROUND_BUTTON_WIDTH_HEIGHT, ROUND_BUTTON_WIDTH_HEIGHT);
    //Clip/Clear the other pieces whichever outside the rounded corner
    _startButton.clipsToBounds = YES;
    //half of the width
    _startButton.layer.cornerRadius = ROUND_BUTTON_WIDTH_HEIGHT / 2.0f;
    _startButton.layer.borderColor = [prettyGreen CGColor];
    _startButton.layer.borderWidth = 2.0f;
    
    [self.view addSubview:_startButton];
    
    // ICON for title view in LANDSCAPE
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"FPressTitle.png"]];
    self.navigationItem.titleView.hidden = YES;
    
    // Zap any existing French Press notifications upon loading the app
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    
    model = [[UIDevice currentDevice] model];
    
    if ([model isEqual:@"iPad"] | [model isEqual:@"iPad Simulator"])
    {
        self.statusLabelVerticalConstraint.constant = 100;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// Detect and handle device orientation changes
- (void) orientationChanged:(NSNotification *)note
{
    UIDevice * device = note.object;
    
    switch(device.orientation)
    {
        case UIDeviceOrientationPortrait:
            self.navigationItem.titleView.hidden = YES;
            _logoImage.hidden = NO;
            self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"Gear.png"];
            self.navigationItem.rightBarButtonItem.enabled = YES;
            break;
            
        case UIDeviceOrientationPortraitUpsideDown:
            // Support UpsideDown orientation on iPads only
            if ([model isEqual:@"iPad"] | [model isEqual:@"iPad Simulator"])
            {
                self.navigationItem.titleView.hidden = YES;
                _logoImage.hidden = NO;
                self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"Gear.png"];
                self.navigationItem.rightBarButtonItem.enabled = YES;
            }
            break;
            
        case UIDeviceOrientationLandscapeLeft:
            self.navigationItem.titleView.hidden = NO;
            _logoImage.hidden = YES;
            if ([model isEqual:@"iPhone"] | [model isEqual:@"iPhone Simulator"] | [model isEqual:@"iPod touch"])
            {
                self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"Disabled.png"];
                self.navigationItem.rightBarButtonItem.enabled = NO;
            }
            break;
            
        case UIDeviceOrientationLandscapeRight:
            self.navigationItem.titleView.hidden = NO;
            _logoImage.hidden = YES;
            if ([model isEqual:@"iPhone"] | [model isEqual:@"iPhone Simulator"] | [model isEqual:@"iPod touch"])
            {
                self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"Disabled.png"];
                self.navigationItem.rightBarButtonItem.enabled = NO;
            }
            break;
            
        default:
            break;
    };
}


// Handle cleanup when the view disappears
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidBecomeActiveNotification
                                                  object:nil];
}


// START BUTTON behavior
-(void)roundButtonDidTap:(UIButton*)tappedButton
{
    // START button pushed
    if ([[tappedButton titleForState:UIControlStateNormal]  isEqual: @"Start"])
    {
        [tappedButton setTitle:@"Reset"
                      forState:UIControlStateNormal];
        [tappedButton setTitleColor:[UIColor redColor]
                           forState:UIControlStateNormal];
        tappedButton.layer.borderColor=[UIColor redColor].CGColor;
        // start TIMER
        steepTimerStartDate = [NSDate date];
        
        int bloomAlertSecs = 0;
        int seconds = steepSecs % 60;
        int minutes = (steepSecs / 60) % 60;
        currMinute = minutes;
        currSecond = seconds;
        
        steepTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                      target:self
                                                    selector:@selector(timerFired)
                                                    userInfo:nil
                                                     repeats:YES];
        
        // Set the main ALARM notification
        alarm = [[UILocalNotification alloc] init];
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        NSDate *alarmDate = [steepTimerStartDate dateByAddingTimeInterval:steepSecs];
        alarm.fireDate = alarmDate;
        alarm.timeZone = [NSTimeZone localTimeZone];
        alarm.alertBody = @"Ready to press";
        alarm.alertAction = @"Details";
        alarm.soundName = @"Alarm.aiff";
        alarm.applicationIconBadgeNumber = 0;
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"someValue" forKey:@"someKey"];
        alarm.userInfo = userInfo;
        [[UIApplication sharedApplication] scheduleLocalNotification:alarm];
        
        // BLOOM TIMER; only set this bloom time is less than alarm time, greater then 0, and bloom is enabled
        if ((bloomSecs > 0) && (bloomSecs < steepSecs) && (enableBlooom))
        {
            // Set the BLOOM ALERT
            bloomAlertSecs = steepSecs - bloomSecs;
            seconds = bloomAlertSecs % 60;
            minutes = (bloomAlertSecs / 60) % 60;
            currBloomMinute = minutes;
            currBloomSecond = seconds;
            
            // Set the BLOOM notificaiton
            bloom = [[UILocalNotification alloc] init];
            NSDate *bloomDate = [steepTimerStartDate dateByAddingTimeInterval:bloomSecs];
            bloom.fireDate = bloomDate;
            bloom.timeZone = [NSTimeZone localTimeZone];
            bloom.alertBody = @"Stir grounds";
            bloom.alertAction = @"Details";
            bloom.soundName = @"Alarm.aiff";
            bloom.applicationIconBadgeNumber = 0;
            bloom.userInfo = userInfo;
            [[UIApplication sharedApplication] scheduleLocalNotification:bloom];
        }
    }
    else
    {
        // RESET button pushed
        [tappedButton setTitle:@"Start"
                      forState:UIControlStateNormal];
        [tappedButton setTitleColor:prettyGreen
                           forState:UIControlStateNormal];
        tappedButton.layer.borderColor=[prettyGreen CGColor];
        // Silence alert
        AudioServicesDisposeSystemSoundID(soundID);
        // stop TIMER
        steepTimerStartDate = nil;
        [steepTimer invalidate];
        steepTimer = nil;
        _timerLabel.text = [AFFUtility timeFormatted:(steepSecs)];
        [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        _statusLabel.hidden = YES;
    }
}


// Update the steepTimer when returning from the background or the Settings view as it does not update automatically
- (void)refreshFromBackground
{
    if (steepTimer)
    {
        NSTimeInterval secs = [alarm.fireDate timeIntervalSinceDate:[NSDate date]];
        
        int refreshedSteepSecs = (int)secs;
        if (refreshedSteepSecs > 0)          // Only do this if the timer hasn't already expired
        {
            int seconds = refreshedSteepSecs % 60;
            int minutes = (refreshedSteepSecs / 60) % 60;
            currMinute = minutes;
            currSecond = seconds;
            
            if (refreshedSteepSecs <= bloomSecs)
            {
                [_statusLabel setTextColor:[UIColor orangeColor]];
                [_statusLabel setText:@"Ready to stir"];
                _statusLabel.hidden = NO;
            }
            
            [steepTimer invalidate];
            steepTimer = nil;
            _timerLabel.text = [AFFUtility timeFormatted:refreshedSteepSecs];
            steepTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                          target:self
                                                        selector:@selector(timerFired)
                                                        userInfo:nil
                                                         repeats:YES];
        }
        else
        {
            [_statusLabel setTextColor:prettyGreen];
            _statusLabel.text = @"Ready to press";
            _statusLabel.hidden = NO;
            [steepTimer invalidate];
            steepTimer = nil;
            _timerLabel.text = @"0:00";
            AudioServicesDisposeSystemSoundID(soundID);
        }
    }
}



// TIMER behavior
-(void)timerFired
{
    // See if we should prevent sleep mode
    if (preventSleep)
    {
        [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    }
    
    if ((currMinute > 0 || currSecond >= 0) && currMinute >= 0)
    {
        if (currSecond == 0)
        {
            currMinute -= 1;
            currSecond = 59;
        }
        else if (currSecond > 0)
        {
            currSecond -= 1;
        }
        
        if (currMinute >- 1)
        {
            [_timerLabel setText:[NSString stringWithFormat:@"%01d:%02d",currMinute, currSecond]];
        }
        
        // If the timer reached Bloom time, sound the bloom alert
        if (enableBlooom)
        {
            if ((currMinute == currBloomMinute) && (currSecond == currBloomSecond))
            {
                // Play BLOOM TIMER alert sound
                _statusLabel.hidden = NO;
                [_statusLabel setTextColor:[UIColor orangeColor]];
                [_statusLabel setText:@"Ready to stir"];
                [self playAlarm];
            }
        }
        
        if ((currMinute == 0) && (currSecond == 0))
        {
            [steepTimer invalidate];    // add more cleanup code here
            
            // Play "READY" alert sound
            _statusLabel.hidden = NO;
            [_statusLabel setTextColor:prettyGreen];
            [_statusLabel setText:@"Ready to press"];
            [self playAlarm];
            [self performSelector:@selector(playAlarm) withObject:nil afterDelay:2.5];  // Play the alert sound again in 2.5 seconds
            
            if (preventSleep)
            {
                [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
            }
        }
    }
}


// PLAY the ALARM sound
- (void)playAlarm
{
    // Do not play sound if the Reset button has been pushed
    if ([[_startButton titleForState:UIControlStateNormal]  isEqual: @"Reset"])
    {
        AudioServicesPlaySystemSound(soundID);
    }
}


// Empty stub method to enable rotation (disabled by default in
- (void)canRotate { }


// ADJUST the SPACING of controls based upon device type and orientation
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    
        if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        self.timerLabelVerticalConstraint.constant = 10;
        self.startButtonVerticalConstraint.constant = 20;
        if ([model isEqual:@"iPad"] | [model isEqual:@"iPad Simulator"])
        {
            self.statusLabelVerticalConstraint.constant = 100;
        }

    }else{
        self.timerLabelVerticalConstraint.constant = -10;
        self.startButtonVerticalConstraint.constant = 35;
        self.statusLabelVerticalConstraint.constant = 5;
        if ([model isEqual:@"iPad"] | [model isEqual:@"iPad Simulator"])
        {
            self.statusLabelVerticalConstraint.constant = 100;
        }
    }
    
    [self.view setNeedsUpdateConstraints];
}

@end
