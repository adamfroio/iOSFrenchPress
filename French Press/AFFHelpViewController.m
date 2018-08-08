//
//  AFFHelpViewController.m
//  French Press
//
//  Created by Adam F Froio on 9/24/14.
//  Copyright (c) 2014 Adam F Froio. All rights reserved.
//

#import "AFFHelpViewController.h"

@interface AFFHelpViewController ()
@property (weak, nonatomic) IBOutlet UITextView *helpText;

@end

@implementation AFFHelpViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Write and format the help text
    UIFont *boldFontName = [UIFont fontWithName:@"Helvetica-Bold" size:16.0];
    UIFont *normalFontName = [UIFont fontWithName:@"Helvetica" size:16.0];
    UIFont *largeFontName = [UIFont fontWithName:@"Helvetica" size:18.0];
    
    // Help Contents
    NSString *displayText = @"French Press Help\n\nI.\t\tUsage\nII.\t\tControls\nIII.\t\tDefinitions\nIV.\t\tNotes\n\n\n\n";
    
    NSMutableAttributedString *fancyText = [[NSMutableAttributedString alloc] initWithString:displayText];
    NSRange boldRange = NSMakeRange(0, 12);
    NSRange normalRange = NSMakeRange(13, fancyText.length - 15);
    [fancyText beginEditing];
    [fancyText addAttribute:NSFontAttributeName
                      value:largeFontName
                      range:boldRange];
    [fancyText addAttribute:NSFontAttributeName
                      value:normalFontName
                      range:normalRange];
    [fancyText endEditing];
    NSMutableAttributedString *finalText = [[NSMutableAttributedString alloc] initWithAttributedString:fancyText];
    
    // Usage, without bloom
    displayText = @"I. USAGE\n\nWithout bloom timer\n1. add coffee to carafe\n2. add hot water to carafe\n3. stir the grounds\n4. press the app's Start button\n5. afix the lid to the carafe\n6. when the alarm sounds, press the plunger.\n\n";
    fancyText = [[NSMutableAttributedString alloc] initWithString:displayText];
    normalRange = NSMakeRange(0, 8);
    boldRange = NSMakeRange(10, 19);
    [fancyText beginEditing];
    [fancyText addAttribute:NSFontAttributeName
                      value:normalFontName
                      range:normalRange];
    [fancyText addAttribute:NSFontAttributeName
                      value:boldFontName
                      range:boldRange];
    normalRange = NSMakeRange(28, fancyText.length - 30);
    [fancyText addAttribute:NSFontAttributeName
                      value:normalFontName
                      range:normalRange];
    [fancyText endEditing];
    [finalText appendAttributedString:fancyText];

    // Usage, with bloom
    displayText = @"With bloom timer\n1. Enable the bloom timer\n2. Add coffee to carafe\n3. add hot water to carafe\n4. press the app's Start button\n5. when the \"Bloom\" alert sounds, stir the grounds\n6. afix the lid to the carafe\n7. when the \"Ready\" alert sounds, press the plunger.\n\n\n\n";
    fancyText = [[NSMutableAttributedString alloc] initWithString:displayText];
    boldRange = NSMakeRange(0, 16);
    [fancyText beginEditing];
    [fancyText addAttribute:NSFontAttributeName
                      value:boldFontName
                      range:boldRange];
    normalRange = NSMakeRange(17, fancyText.length - 19);
    [fancyText addAttribute:NSFontAttributeName
                      value:normalFontName
                      range:normalRange];
    [fancyText endEditing];
    [finalText appendAttributedString:fancyText];
    
    // Steep timer
    displayText = @"II. CONTROLS\n\nSteep time\nTotal steep time for coffee. Enter 400 for 4 minutes, 330 for 3½ minutes, etc.\n\n";
    fancyText = [[NSMutableAttributedString alloc] initWithString:displayText];
    normalRange = NSMakeRange(0, 12);
    boldRange = NSMakeRange(13, 12);
    [fancyText beginEditing];
    [fancyText addAttribute:NSFontAttributeName
                      value:normalFontName
                      range:normalRange];
    [fancyText addAttribute:NSFontAttributeName
                      value:boldFontName
                      range:boldRange];
    normalRange = NSMakeRange(24, fancyText.length - 25);
    [fancyText addAttribute:NSFontAttributeName
                      value:normalFontName
                      range:normalRange];
    [fancyText endEditing];
    [finalText appendAttributedString:fancyText];
    
    // Bloom timer
    displayText = @"Bloom time\nSets an alert to stir the grounds if you wish to let them soak a bit before stirring. Bloom time must be less than steep time.\n\n";
    fancyText = [[NSMutableAttributedString alloc] initWithString:displayText];
    boldRange = NSMakeRange(0, 10);
    normalRange = NSMakeRange(11, fancyText.length - 13);
    [fancyText beginEditing];
    [fancyText addAttribute:NSFontAttributeName
                      value:boldFontName
                      range:boldRange];
    [fancyText addAttribute:NSFontAttributeName
                      value:normalFontName
                      range:normalRange];
    [fancyText endEditing];
    [finalText appendAttributedString:fancyText];
    
    // Enable bloom timer
    displayText = @"Enable bloom timer\nAllows the bloom time to be set. This must be set to On (green) to receive a bloom timer alert.\n\n";
    fancyText = [[NSMutableAttributedString alloc] initWithString:displayText];
    boldRange = NSMakeRange(0, 18);
    normalRange = NSMakeRange(19, fancyText.length - 21);
    [fancyText beginEditing];
    [fancyText addAttribute:NSFontAttributeName
                      value:boldFontName
                      range:boldRange];
    [fancyText addAttribute:NSFontAttributeName
                      value:normalFontName
                      range:normalRange];
    [fancyText endEditing];
    [finalText appendAttributedString:fancyText];
    
    // Prevent auto-lock
    displayText = @"Prevent auto-lock\nPrevents the device from auto-locking while the timer is running.\n\n\n\n";
    fancyText = [[NSMutableAttributedString alloc] initWithString:displayText];
    boldRange = NSMakeRange(0, 17);
    normalRange = NSMakeRange(18, fancyText.length - 20);
    [fancyText beginEditing];
    [fancyText addAttribute:NSFontAttributeName
                      value:boldFontName
                      range:boldRange];
    [fancyText addAttribute:NSFontAttributeName
                      value:normalFontName
                      range:normalRange];
    [fancyText endEditing];
    [finalText appendAttributedString:fancyText];
    
    // Definitions
    // Steep time definition
    displayText = @"III. DEFINITIONS\n\nSteep time\nThis is the total amount of time from the moment you add water to the grounds until the coffee is ready to serve.  This time is unaffected by the use of the bloom timer.\n\n";
    fancyText = [[NSMutableAttributedString alloc] initWithString:displayText];
    normalRange = NSMakeRange(0, 16);
    boldRange = NSMakeRange(17, 11);
    [fancyText beginEditing];
    [fancyText addAttribute:NSFontAttributeName
                      value:normalFontName
                      range:normalRange];
    [fancyText addAttribute:NSFontAttributeName
                      value:boldFontName
                      range:boldRange];
    normalRange = NSMakeRange(28, fancyText.length - 28);
    [fancyText addAttribute:NSFontAttributeName
                      value:normalFontName
                      range:normalRange];
    [fancyText endEditing];
    [finalText appendAttributedString:fancyText];
    
    // Bloom time definition
    displayText = @"Bloom time\nThis is an optional step in which the coffee grounds are allowed to soak for a short period (usually a minute) after which they are stirred; the top of the french press is then afixed, leaving the coffee to continue to steep normally before pressing the plunger down.\n\n";
    fancyText = [[NSMutableAttributedString alloc] initWithString:displayText];
    boldRange = NSMakeRange(0, 10);
    normalRange = NSMakeRange(11, fancyText.length - 13);
    [fancyText beginEditing];
    [fancyText addAttribute:NSFontAttributeName
                      value:boldFontName
                      range:boldRange];
    [fancyText addAttribute:NSFontAttributeName
                      value:normalFontName
                      range:normalRange];
    [fancyText endEditing];
    [finalText appendAttributedString:fancyText];
    
    // Auto-lock definition
    displayText = @"Auto-lock\nThis is the feature on an iOS device that causes the screen to dim and finally turn off, requiring the you to swipe the screen to access the app again.  If you wish to prevent this from happening while the timer is displayed and running, you can set the Prevent Auto-lock switch to On (green).\n\n";
    fancyText = [[NSMutableAttributedString alloc] initWithString:displayText];
    boldRange = NSMakeRange(0, 9);
    normalRange = NSMakeRange(10, fancyText.length - 12);
    [fancyText beginEditing];
    [fancyText addAttribute:NSFontAttributeName
                      value:boldFontName
                      range:boldRange];
    [fancyText addAttribute:NSFontAttributeName
                      value:normalFontName
                      range:normalRange];
    [fancyText endEditing];
    [finalText appendAttributedString:fancyText];
    
    // Notificaitons definition
    displayText = @"Notifications\nNotifications must be enabled in order to receive alarms while the app is in the background or the phone is locked.\n\nIf you chose not to allow French Press to send notifications when you first installed the app, you can re-enable them by doing the following:\n1. exit French Press\n2. go to Settings > Notifications > French Press\n3. enable Allow Notifications.\n\n";
    fancyText = [[NSMutableAttributedString alloc] initWithString:displayText];
    boldRange = NSMakeRange(0, 13);
    normalRange = NSMakeRange(14, fancyText.length - 16);
    [fancyText beginEditing];
    [fancyText addAttribute:NSFontAttributeName
                      value:boldFontName
                      range:boldRange];
    [fancyText addAttribute:NSFontAttributeName
                      value:normalFontName
                      range:normalRange];
    [fancyText endEditing];
    [finalText appendAttributedString:fancyText];

    // Notes
    // Definitions
    displayText = @"\n\nIV. NOTES\n\nThe Settings (gear) button is disabled on iPhone and iPod Touch in landscape orientation.\n\nTap anywhere outside of a text box to dismiss the keyboard.\n\nMinimum & maximum values\nSteep time - min: 00:10  max: 59:59\nBloom time - min: 00:05  max: 59:58\n\nValues up to 99 may be entered in the seconds field so that, for instance, 90 may be entered as shorthand for 01:30.\n\n\n\n";
    fancyText = [[NSMutableAttributedString alloc] initWithString:displayText];
    normalRange = NSMakeRange(0, fancyText.length);
    [fancyText beginEditing];
    [fancyText addAttribute:NSFontAttributeName
                      value:normalFontName
                      range:normalRange];
    [fancyText endEditing];
    [finalText appendAttributedString:fancyText];
    _helpText.attributedText = finalText;

    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDict objectForKey:@"CFBundleShortVersionString"]; // example: 1.0.0
//    NSNumber *buildNumber = [infoDict objectForKey:@"CFBundleVersion"]; // example: 42
    NSString *dateStr = [NSString stringWithUTF8String:__DATE__];
//    NSString *timeStr = [NSString stringWithUTF8String:__TIME__];
    
    displayText = [NSString stringWithFormat:@"Version %@,\nbuilt on %@", appVersion,  dateStr];
    
    fancyText = [[NSMutableAttributedString alloc] initWithString:displayText];
    normalRange = NSMakeRange(0, fancyText.length);
    [fancyText beginEditing];
    [fancyText addAttribute:NSFontAttributeName
                      value:[UIFont fontWithName:@"Courier" size:12.0]
                      range:normalRange];
    [fancyText endEditing];
    [finalText appendAttributedString:fancyText];
    _helpText.attributedText = finalText;
    
    // Set to display from the top
    [_helpText scrollRangeToVisible:NSMakeRange(0, 0)];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
