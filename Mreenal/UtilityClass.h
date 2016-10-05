//
//  UtilityClass.h
//  Mreenal
//
//  Created by Xpired on 3/7/16.
//  Copyright © 2016 Xpired. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
#import "RTSpinKitView.h"
#import "Constants.h"

@interface UtilityClass : NSObject


+ (UtilityClass *)sharedMyManager;
+ (CGFloat)getScreenWidth;
+ (CGFloat)getScreenHeight;
+ (UIViewController *)getRootViewController;
+ (void)showAlertViewController:(NSString *)data withTitle:(NSString *)titile andViewController:(UIViewController *)viewcontroller;
+ (void)addSubview:(UIViewController *)childVC andParentViewController:(UIViewController *)parentVC;
+ (void)removeSubViewFromParent:(UIViewController *)removeAbleViewController;
+ (void)addSubviewWithBounce:(UIViewController *)childVC andParentViewController:(UIViewController *)parentVC;
+ (void)removeBounceSubViewFromParent:(UIViewController *)removeAbleViewController;
- (void)showSpinner:(UIViewController *)viewController;
- (void)hideSpinner:(UIViewController *)viewController;
- (NSString *)getUniqueUserImageNameFromUserName:(NSString *)username;
- (NSString *)formatPhoneNumber:(NSString*) simpleNumber deleteLastChar:(BOOL)deleteLastChar;
@end
