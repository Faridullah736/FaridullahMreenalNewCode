//
//  AppDelegate.h
//  Mreenal
//
//  Created by Xpired on 3/7/16.
//  Copyright © 2016 Xpired. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMDrawerController.h"
#import "MMNavigationController.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "UIViewController+MMDrawerController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) MMDrawerController *drawerController;

- (void)showHomeViewController;
- (void)showLoginViewController;
- (void)setupMMDrawerController;
@end

