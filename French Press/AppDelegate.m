//
//  AppDelegate.m
//  French Press
//
//  Created by Adam F Froio on 9/24/14.
//  Copyright (c) 2014 Adam F Froio. All rights reserved.
//
////////////////////////////////// TO DO ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
//  DONE - 1. Implement the bloom timer
//
//  DONE - 2. Provide functionality to disable sleep while the timer is active
//
//  DONE - 3. Implement input masks for the text fields
//
//  DONE - 4. Handle the suspension of NSTimer when the app goes into the background.
//            Use AppDelegate's applicationWillEnterForeground to associate the timer
//            with alarmDate - now.
//            Handle returning from Settings view similarly.
//
//  DONE - 5. Create a notification for the bloom timer as well
//
//  DONE - 6. Create an alarm when the timer expires ( Notification Center )
//            a)  timer should sound even if phone automatically locks
//            b)  timer should display a notification
//
//  Done - 7. Very brief tips on Settings screen
//
//  Done - 8. Clear notifications and re-enable sleep when launching the app, in case
//            the app crashes.
//
//  Done - 9. Bloom alarm calculation incorrect.  Must base it on alarmTime - bloomTime.
//            Handle instances where  alarmTime < bloomTime
//
//  Done - 10. Constrain bloom time to be less than steep time?
//
//  No  -  11. Use vector graphics to render the logo
//
//  No  -  12. Allow the user to select the alert sounds?  PITA.
//
//  Done - 13. Handle Lanscape modes
//
//  Done - 14. Change the background to a blank image and use a UIImage to display the logo
//
//  Done - 15. Change the alert to a sound so that the alarm plays the same sound even if the
//             app is in the background.
//
//  Done - 16. Implement UI changes for iPads in upsideDown orientation
//
//  Done - 17. Set opacity of the small title bar icon to 75%
//
//  Done - 18. Cancel navigation to main screen if bloom time > steep time
//
//  Done - 19. Fix constraints on Help screen
//
//  Done - 20. Allow the settings screen to rotate if iPad
//
//  Done - 21. Ensure neither bloom nor steep times are set to zero
//
//  Done - 22. Consider swapping in a smaller logo (padded on the bottom) if the device is an iPhone 4
//
//  Done - 23. Double check the timing of the bloom notification.  Seems to be off.
//             Steep set to 4:00
//             Bloom set to 1:00
//             Bloom alarm went off as expected
//             I dismissed the app but left the timer running
//             At 1:00 I received a notification to stir the coffee
//
//  Done - 24. When on ' ? ' screen, remove '? ' on upper right corner so User doesn't get confused about the ' ? ' anymore
//
//  Done - 25. Stir time can never be greater than the Steep time.
//
//  Done - 26. Pressing on 'Back' link (which is currently arrow)  on the upper left corner on ' ? ' screen should take the user back to the SETTINGS screen and not the Main screen.
//             Though, when on SETTINGS screen, user can see ' ? ' and 'Back' links.
//
//  Done - 27. When click on SETTINGS button after the timer is ON and running, and then click on the 'Back' link ('Arrow' link based on defect #3),
//             the timer displays initial time set and then immediately goes back to the current running time.
//             Need to fix this flaw as the timer should display the current running time Only instead the initial set time.
//
//  Done - 28. Find a more reliable way to zero out the timer fields when clicked.
//
//  Done - 29. Disable and grey out "Bloom time (mm:ss)" when "Enable bloom time?" is set to 'No'.
//
//  Done - 30. User set the timer to 00:25 and got back to Main screen, later the user changed their mind to ale it 00:35 instead and went back to SETTING screen
//             and click on the Steep time (mm:ss) box, observed - timer setting stays as previously set time,
//             which is 00:25, click on the Steep timer box, and find that, whatever they enter is being modified to below:
//
//             Actual test result:
//             00:25 is converted to 25:35
//
//             Expected result:
//             00:35
//
//  Done - 31. Notification sound should work when the app is minimized and when Steep/Stir timer goes off.
//
//  Done - 32. Clicking on "Reset" button on the Main screen when the timer was previously set on SETTINGS screen ------------ kind of creates some sort of confusion.
//             Unable to reproduce all times but please play around to get to know what this is.
//
//  No - 33. This may not be possible; Apple doesn't allow the number pad to display a Done or Return button.  Lame.
//           Need 'Done' button on the iPhone keypad or somewhere on the app, on SETTINGS Screen, so, when the user sets the timer(s) using keypad,
//           they can click on 'Done' button. Click on 'Done' button should display the Main screen with the time set.
//
//  No - 34. The keyboard covers the bloom timer field if it is lowered too far.  The dimming of the Bloom time field makes the dependence clear.
//           Perhaps move everything up a bit?
//           Move the "Enable bloom timer?" to top and move "Bloom time(mm:ss) to below so "Enable bloom timer?" would be the gate way to set Bloom time.
//
//  Done - 35. Remove arrow on upper left corner of the app and make it "Back" or something nicer.
//
//  Done - 36. "Prevent sleep while time active?" -- Suggest to change the word "sleep" to "phone screen lock" so it self-explains it all. Thanks! :-)
//
//  Done - 37. Ready to press" should be the message when:
//             a. The app is running and the steep timer goes off.
//             b. The app is minimized and the Steep timer goes off.
//
//  Done - 38. More information need to be added on the ' ? ' screen about the way the app works and the lingo.
//
//  Done - 39. Need more definition to Steep time in Settings screen like -- "Total time set for the coffee to be ready to press and serve."
//
//  Done - 40. Add a small line next to the existing line for BLOOM TIME like -- "Sets an alert to stir the grounds, before Steep time (press the plunger on the French press)".
//
//
///////////////////////////////// TO DO ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
//  Done - 41. When setting the bloom timer to 0:00 and disabling the timer, re-enabling it causes the error msg to dissapear.
//             and re-enables the back button.
//
//  Done - 42. Entering 99:99 into the timer field shows up as 40:39 on the timer and reverts to 40:39 in settings.
//             It's getting converted to hours but hours is cut off.
//             Limit timers to 60:00
//
//  Done - 43. Entering 00:90 in the timer fields actually works
//
//  Done - 44. Change the text box border to green for the field being edited
//
//  Done - 45. Mention that Enable Bloom Timer must be enabled to set bloom time
//
//  Done - 46. Prevent Auto-lock - capitalize the O in on.  And that the app must be active for this feature to work
//
//  Done - 47. Setting bloom to 0:00 and then disabling the timer and re-enabling activates the back button :(
//
//  Done - 48. Consider swapping in a larger logo if the device is an iPad.
//             Increased the timer size.
//
//  Done - 49. Setting timer to 60:00 causes it to flip and show 00:00
//
//  Done - 50. Clicking Back after setting a value rather than dismissing the key pad prevents the value from being saved.
//
//  Done - 51. Clicking a switch while having a texfield open prevents the value from being saved.
//
//  Done - 52. Clicking the back button while having a texfield open causes the value to be saved, regardless of validity.
//
//  Done - 53. Enter 3:00 in steep
//             Enable bloom timer (set to On)
//             Enter 2:00 in bloom
//             Click to edit steep, but don't enter anything -- just leave it at 00:00
//             The steep value is saved at 0:00
//             Click Enable bloom timer to disable it
//             Re-enable bloom timer
//             Bloom now appears as 0:-1
//
//  Done - 54. Rename Bloom time to bloom timer
//             Rename Steep time to steep timer
//             Rearrange the UI a bit to accomodate this; Bloom timer doesn't fit on the label.
//
//  Done - 55. Raise the timerStatus label a bit on landscape mode for iPads.
//
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#import "AppDelegate.h"
#import "AFFFrenchPressViewController.h"

@interface AppDelegate ()
@end

NSString * const AFFSteepSecsPrefsKey = @"SteepSecs";        // user preferences
NSString * const AFFBloomSecsPrefsKey = @"BloomSecs";        // user preferences
NSString * const AFFPreventSleepPrefsKey = @"PreventSleep";  // user preferences
NSString * const AFFEnableBloomPrefsKey = @"EnableBloom";    // user preferences

@implementation AppDelegate


+ (void)initialize
{
    // Load DEFAULT VALUES into user settings, these are overwritten by any saved user settings
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *factorySettings = @{AFFSteepSecsPrefsKey: @240,       // 4 minutes
                                      AFFBloomSecsPrefsKey: @60,        // 1 minute bloom timer
                                      AFFPreventSleepPrefsKey: @NO,    // Prevent sleep enabled
                                      AFFEnableBloomPrefsKey: @NO};     // Bloom timer disabled
    [defaults registerDefaults:factorySettings];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        UIUserNotificationSettings* notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeSound categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes: (UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    }
    
    // Generate notificaitons to update on ORIENTATION
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    
    // Set the Navigation Bar items to appear in dark gray
    self.window.tintColor = [UIColor darkGrayColor];
    
    return YES;
}


// Disable VIEW ROTATION by default and enable it only in views with the canRotate method declared. (following three methods)
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    // Get topmost/visible view controller
    UIViewController *currentViewController = [self topViewController];
    NSString *model = [[UIDevice currentDevice] model];
    
    // Check whether it implements a dummy methods called canRotate or is an iPad
    if ([currentViewController respondsToSelector:@selector(canRotate)] | [model isEqual:@"iPad"] | [model isEqual:@"iPad Simulator"])
    {
        // Unlock landscape view orientations for this view controller
        return UIInterfaceOrientationMaskAll;
    }
    // Only allow portrait (standard behaviour)
    return UIInterfaceOrientationMaskPortrait;
}


- (UIViewController*)topViewController
{
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}


- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController
{
    if ([rootViewController isKindOfClass:[UITabBarController class]])
    {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    }
    else if ([rootViewController isKindOfClass:[UINavigationController class]])
    {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    }
    else if (rootViewController.presentedViewController)
    {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    }
    else
    {
        return rootViewController;
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
