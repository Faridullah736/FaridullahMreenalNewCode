//
//  AppDelegate.m
//  Mreenal
//
//  Created by Xpired on 3/7/16.
//  Copyright © 2016 Xpired. All rights reserved.
//

#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <Instabug/Instabug.h>
#import "HomeVC.h"
#import "LeftMenuVC.h"
#import "LoginVC.h"
#import "Constants.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    //Instabug
    [Instabug startWithToken:@"d6d03486863ac7225299bd9691077771" invocationEvent:IBGInvocationEventShake];
    
    [self setDefaultNavigationProperties];
    
    
    return YES;
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
     [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark - Facebook Delegate Methods


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

- (void)showHomeViewController
{
    UIStoryboard *mystoryboard  = [UIStoryboard storyboardWithName:ID_MAIN_STORY_BOARD bundle:nil];
    HomeVC *homeInstance        = [mystoryboard instantiateViewControllerWithIdentifier:ID_HOME_VC];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:homeInstance];
    _window.rootViewController  = navigationController;
    [SERVER_MANAGER changeRootViewController];
    [_window.rootViewController.view setNeedsDisplay];
}
- (void)showLoginViewController
{
    UIStoryboard *mystoryboard  = [UIStoryboard storyboardWithName:ID_MAIN_STORY_BOARD bundle:nil];
    LoginVC *loginInstance      = [mystoryboard instantiateViewControllerWithIdentifier:ID_LOGIN_VC];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginInstance];
    _window.rootViewController  = navigationController;
    [SERVER_MANAGER changeRootViewController];
    [_window.rootViewController.view setNeedsDisplay];
}
- (void)setupMMDrawerController
{
    UIStoryboard *mystoryboard  = [UIStoryboard storyboardWithName:ID_MAIN_STORY_BOARD bundle:nil];
    HomeVC *centerVC = [mystoryboard instantiateViewControllerWithIdentifier:ID_HOME_VC];
    UINavigationController *navController = [[MMNavigationController alloc]initWithRootViewController:centerVC];
    [navController setRestorationIdentifier:@"MMExampleCenterNavigationControllerRestorationKey"];
    
    LeftMenuVC *leftVC = [mystoryboard instantiateViewControllerWithIdentifier:ID_LEFT_MENU_VC];
    UINavigationController *leftNavController = [[MMNavigationController alloc]initWithRootViewController:leftVC];
    leftNavController.navigationBarHidden = YES;
    [leftNavController setRestorationIdentifier:@"MMExampleLeftNavigationControllerRestorationKey"];
    
    self.drawerController = [[MMDrawerController alloc]initWithCenterViewController:navController leftDrawerViewController:leftNavController];
    [self.drawerController setRestorationIdentifier:@"MMDrawer"];
    [self.drawerController setMaximumLeftDrawerWidth:240.0];
    [self.drawerController setOpenDrawerGestureModeMask :MMOpenDrawerGestureModeAll];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [self.drawerController setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
        MMDrawerControllerDrawerVisualStateBlock block;
        block = [[MMExampleDrawerVisualStateManager sharedManager] drawerVisualStateBlockForDrawerSide:drawerSide];
        if(block)
        {
            block(drawerController,drawerSide,percentVisible);
        }
    }];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self.drawerController];
    
    _window.rootViewController  = navigationController;
}
- (void)setDefaultNavigationProperties
{
    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"btnBack"]];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"btnBack"]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBackgroundColor:[UIColor clearColor]];
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    [[UINavigationBar appearance] setTranslucent:YES];
  
}
@end
