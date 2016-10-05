//
//  NYAlertManager.h
//  Mreedazzle
//
//  Created by Xpired on 5/5/16.
//  Copyright © 2016 Xpired. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NYAlertManager : NSObject

+ (void)showAlertViewWithMessage :(NSString *)message forViewController:(UIViewController *)vC :(void (^)(BOOL okPressed)) completionBlock;

+ (void)showTermsAndConditionsAlertViewOnViewController:(UIViewController *)vC;

@end
