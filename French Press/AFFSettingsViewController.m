//
//  AFFSettingsViewController.m
//  French Press
//
//  Created by Adam F Froio on 9/24/14.
//  Copyright (c) 2014 Adam F Froio. All rights reserved.
//

#import "AFFSettingsViewController.h"
#import "AFFTimeTextField.h"
#import "AFFFrenchPressViewController.h"
#import "AppDelegate.h"
#import "AFFUtility.h"

@interface AFFSettingsViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet AFFTimeTextField *steepTimeField;
@property (weak, nonatomic) IBOutlet AFFTimeTextField *bloomTimeField;
@property (weak, nonatomic) IBOutlet UILabel *steepErrorLabel;
@property (weak, nonatomic) IBOutlet UILabel *bloomErrorLabel;
@property (weak, nonatomic) IBOutlet UISwitch *enableBloomSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *preventSleepSwitch;
@property (weak, nonatomic) IBOutlet UILabel *bloomTimerTitle;

- (IBAction)backgroundTapped:(id)sender;

@end

UIColor *prettyGreen;
NSUserDefaults *defaults;
int const steepFieldTag = 101;
int const bloomFieldTag = 102;


@implementation AFFSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _steepTimeField.tag = steepFieldTag;
    _bloomTimeField.tag = bloomFieldTag;
    
    prettyGreen = [UIColor colorWithRed:93/255.0f green:174/255.0f blue:0/255.0f alpha:1.0f];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// Take action if the bloom timer is switch on or off
- (IBAction)switched
{
    // Make sure the steep field isn't in editing mode and left at 00:00
    if ([_steepTimeField.text  isEqual: @"00:00"])
    {
        _steepTimeField.text = [AFFUtility timeFormatted:(int)[defaults integerForKey:AFFSteepSecsPrefsKey]];
    }
 
    // Get current values
    int bloomSecs = [[AFFUtility secondsForTimeString:_bloomTimeField.text] intValue];
    int steepSecs = [[AFFUtility secondsForTimeString:_steepTimeField.text] intValue];

    
    // If bloom timer is switched ON
    if(_enableBloomSwitch.isOn)
    {
        [_bloomTimeField setTextColor:[UIColor blackColor]];
        [_bloomTimerTitle setTextColor:[UIColor blackColor]];
        _bloomTimeField.enabled = YES;
        
        // Check to see if the bloom timer exceeds steep timer
        if (bloomSecs >= steepSecs)
        {
            // Set to a value lower than steep timer
            _bloomErrorLabel.hidden = NO;
            _bloomTimeField.Text = [AFFUtility timeFormatted:steepSecs - 1];
            _bloomErrorLabel.Text = @"Bloom time must be less than steep time; adjusting value.";
            _bloomErrorLabel.hidden = NO;
            [_bloomErrorLabel setTextColor:[UIColor orangeColor]];
        }
        // If steep timer > bloom timer, then fine, display it normally
        else
        {
            _bloomTimeField.layer.borderColor = [[UIColor blackColor]CGColor];
            _bloomErrorLabel.hidden = YES;
        }
    }
    // If bloom timer disabled, then dim and disable the relevant controls
    else
    {
        [_bloomTimeField setTextColor:[UIColor lightGrayColor]];
        [_bloomTimerTitle setTextColor:[UIColor lightGrayColor]];
        _bloomTimeField.layer.borderColor = [[UIColor lightGrayColor]CGColor];
        _bloomErrorLabel.hidden = YES;
        _steepErrorLabel.hidden = YES;
        _bloomTimeField.enabled = NO;
    }
    
    // Save values
    [defaults setObject:[AFFUtility secondsForTimeString:_steepTimeField.text] forKey:AFFSteepSecsPrefsKey];
    [defaults setObject:[AFFUtility secondsForTimeString:_bloomTimeField.text] forKey:AFFBloomSecsPrefsKey];
    [defaults setBool:_enableBloomSwitch.on forKey:AFFEnableBloomPrefsKey];
    [defaults setBool:_preventSleepSwitch.on forKey:AFFPreventSleepPrefsKey];
    [defaults synchronize];

    [self.view endEditing:YES];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
//}


// Show two digits for minutes and highlight the active textfield in green
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.text = @"00:00";
    textField.layer.borderColor = [prettyGreen CGColor];
}


// Action to perform after text field is exited
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    // Remove 1st leading zero
    NSString *str =  textField.text;
    if ([str hasPrefix:@"0"])
    {
        textField.text = [str substringFromIndex:1];
    }
    
    // Validate bounds of data
    int steepSecs = [[AFFUtility secondsForTimeString:_steepTimeField.text] intValue];
    int bloomSecs = [[AFFUtility secondsForTimeString:_bloomTimeField.text] intValue];
    
    // If steep time is too high
    if (steepSecs > 3599)  // 59:59 minutes
    {
        _steepTimeField.text = [AFFUtility timeFormatted:(int)[defaults integerForKey:AFFSteepSecsPrefsKey]];
        _steepErrorLabel.Text = @"Maximum value for steep time is 59:59; previous value restored.";
        steepSecs = (int)[defaults integerForKey:AFFSteepSecsPrefsKey];
        [_steepErrorLabel setTextColor:[UIColor orangeColor]];
        _steepErrorLabel.hidden = NO;
    }
    // If steep time is too low
    else if (steepSecs > 0 && steepSecs < 10)
    {
        _steepTimeField.text = [AFFUtility timeFormatted:(int)[defaults integerForKey:AFFSteepSecsPrefsKey]];
        _steepErrorLabel.Text = @"Steep time must be 00:10 or more; previous value restored.";
        steepSecs = (int)[defaults integerForKey:AFFSteepSecsPrefsKey];
        [_steepErrorLabel setTextColor:[UIColor orangeColor]];
        _steepErrorLabel.hidden = NO;
    }
    // If steep time is zero, the user probably just clicked on and off of the text field.  Revert and show no message.
    else if (steepSecs == 0)
    {
        _steepTimeField.text = [AFFUtility timeFormatted:(int)[defaults integerForKey:AFFSteepSecsPrefsKey]];
        steepSecs = (int)[defaults integerForKey:AFFSteepSecsPrefsKey];
        _steepErrorLabel.hidden = YES;
    }
    // If steep time just right
    else
    {
        _steepTimeField.Text = [AFFUtility timeFormatted:steepSecs];
        _steepErrorLabel.hidden = YES;
    }
    
    // If bloom time is too high
    if (bloomSecs > 3598)  // 59:58 minutes
    {
        _bloomTimeField.Text = [AFFUtility timeFormatted:(int)[defaults integerForKey:AFFBloomSecsPrefsKey]];
        _bloomErrorLabel.Text = @"Maximum value for bloom time is 59:58; previous value restored.";
        bloomSecs = (int)[defaults integerForKey:AFFBloomSecsPrefsKey];
        [_bloomErrorLabel setTextColor:[UIColor orangeColor]];
        _bloomErrorLabel.hidden = NO;
    }
    // If bloom time is too low
    else if (bloomSecs > 0 && bloomSecs < 5)
    {
        _bloomTimeField.Text = [AFFUtility timeFormatted:(int)[defaults integerForKey:AFFBloomSecsPrefsKey]];
        _bloomErrorLabel.Text = @"Bloom time must be 00:05 or more; previous value restored.";
        bloomSecs = (int)[defaults integerForKey:AFFBloomSecsPrefsKey];
        _bloomErrorLabel.hidden = NO;
        [_bloomErrorLabel setTextColor:[UIColor orangeColor]];
    }
    // If steep time is zero, the user probably just clicked on and off of the text field.  Revert and show no message.
    else if (bloomSecs == 0)
    {
        _bloomTimeField.Text = [AFFUtility timeFormatted:(int)[defaults integerForKey:AFFBloomSecsPrefsKey]];
        bloomSecs = (int)[defaults integerForKey:AFFBloomSecsPrefsKey];
        _bloomErrorLabel.hidden = YES;
    }
    // If bloom time is just right
    else
    {
        _bloomTimeField.Text = [AFFUtility timeFormatted:bloomSecs];
        _bloomErrorLabel.hidden = YES;
    }

    // If bloom time is > steep time, figure out which text field is being edited, revert the value of the guilty text field, and explain what happened
    // Check steep time field
    if (_enableBloomSwitch.isOn)
    {
        if (steepSecs <= bloomSecs)
        {
            if (textField.tag == steepFieldTag)
            {
                _steepTimeField.text = [AFFUtility timeFormatted:(int)[defaults integerForKey:AFFSteepSecsPrefsKey]];
                _steepErrorLabel.Text = @"Steep time must be greater than bloom time; previous value restored.";
                [_steepErrorLabel setTextColor:[UIColor orangeColor]];
                _steepErrorLabel.hidden = NO;
            }
        }
    }
    // Check bloom time field
    if (_enableBloomSwitch.isOn || [defaults boolForKey:AFFEnableBloomPrefsKey])
    {
        if (steepSecs <= bloomSecs)
        {
            if (textField.tag == bloomFieldTag)
            {
                _bloomTimeField.Text = [AFFUtility timeFormatted:(int)[defaults integerForKey:AFFBloomSecsPrefsKey]];
                _bloomErrorLabel.Text = @"Bloom time must be less than steep time; previous value restored.";
                _bloomErrorLabel.hidden = NO;
                [_bloomErrorLabel setTextColor:[UIColor orangeColor]];
            }
        }
    }
    
    textField.layer.borderColor = [[UIColor blackColor] CGColor];

    // Save the values
    [defaults setObject:[AFFUtility secondsForTimeString:_steepTimeField.text] forKey:AFFSteepSecsPrefsKey];
    [defaults setObject:[AFFUtility secondsForTimeString:_bloomTimeField.text] forKey:AFFBloomSecsPrefsKey];
    [defaults setBool:_enableBloomSwitch.on forKey:AFFEnableBloomPrefsKey];
    [defaults setBool:_preventSleepSwitch.on forKey:AFFPreventSleepPrefsKey];
    [defaults synchronize];
}


// Make sure the text entered is correctly formatted
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)replacementString {
    NSString *originalNumber = textField.text;
    if([replacementString isEqualToString:@""]) {
        originalNumber = [originalNumber stringByReplacingCharactersInRange:range withString:@""];
    } else {
        originalNumber = [originalNumber stringByAppendingString:replacementString];
    }
    originalNumber = [originalNumber stringByReplacingOccurrencesOfString:@":" withString:@""];
    NSString *newString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[originalNumber doubleValue]]];
    textField.text = newString;
    
    return NO;
}


// Prep the VIEW for display
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Read USER PREFERENCES and update the controls
    defaults = [NSUserDefaults standardUserDefaults];
    
    // Update the Steep Time label
    _steepTimeField.delegate = self;
    [_steepTimeField setReturnKeyType:UIReturnKeyDone];
    
    int steepSecs = (int)[defaults integerForKey:AFFSteepSecsPrefsKey];
    _steepTimeField.text = [AFFUtility timeFormatted:steepSecs];
    
    // Update the Bloom Time label
    _bloomTimeField.delegate = self;
    [_bloomTimeField setReturnKeyType:UIReturnKeyDone];
    
    int bloomSecs = (int)[defaults integerForKey:AFFBloomSecsPrefsKey];
    _bloomTimeField.text = [AFFUtility timeFormatted:bloomSecs];
    
    // Update values of the switches
    _enableBloomSwitch.on = [defaults boolForKey:AFFEnableBloomPrefsKey];
    _preventSleepSwitch.on = [defaults boolForKey:AFFPreventSleepPrefsKey];
    
    _bloomTimeField.layer.cornerRadius = 6;
    _bloomTimeField.clipsToBounds = YES;
    [_bloomTimeField.layer setBorderWidth:1.0];
    
    _steepTimeField.layer.cornerRadius = 6;
    _steepTimeField.clipsToBounds = YES;
    [_steepTimeField.layer setBorderWidth:1.0];
    
    numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterNoStyle];
    [numberFormatter setGroupingSize:2];
    [numberFormatter setGroupingSeparator:@":"];
    [numberFormatter setUsesGroupingSeparator:YES];
    [numberFormatter setMaximumFractionDigits:0];
    [numberFormatter setMinimumIntegerDigits:4];
    [numberFormatter setMaximumIntegerDigits:4];
    
    _steepTimeField.clearsOnBeginEditing = YES;
    _bloomTimeField.clearsOnBeginEditing = YES;
    
    [_enableBloomSwitch addTarget:self action:@selector(switched) forControlEvents:UIControlEventValueChanged];
    
    if ([_enableBloomSwitch isOn])
    {
        [_bloomTimeField setTextColor:[UIColor blackColor]];
        [_bloomTimerTitle setTextColor:[UIColor blackColor]];
        _bloomTimeField.enabled = YES;
    }
    else
    {
        [_bloomTimeField setTextColor:[UIColor lightGrayColor]];
        [_bloomTimerTitle setTextColor:[UIColor lightGrayColor]];
        _bloomTimeField.layer.borderColor = [[UIColor lightGrayColor]CGColor];
        _bloomTimeField.enabled = NO;
    }
    
}


// This and backgroundTapped are needed to allow the keyboard to be dismissed by tapping the background
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}


- (IBAction)backgroundTapped:(id)sender
{
    [self.view endEditing:YES];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Incase someone presses Back or Help with a text field in edit mode
    [self.view endEditing:YES];

    // Save the values
    [defaults setObject:[AFFUtility secondsForTimeString:_steepTimeField.text] forKey:AFFSteepSecsPrefsKey];
    [defaults setObject:[AFFUtility secondsForTimeString:_bloomTimeField.text] forKey:AFFBloomSecsPrefsKey];
    [defaults setBool:_enableBloomSwitch.on forKey:AFFEnableBloomPrefsKey];
    [defaults setBool:_preventSleepSwitch.on forKey:AFFPreventSleepPrefsKey];
    [defaults synchronize];
}

@end
