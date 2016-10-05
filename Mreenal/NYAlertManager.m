//
//  NYAlertManager.m
//  Mreedazzle
//
//  Created by Xpired on 5/5/16.
//  Copyright © 2016 Xpired. All rights reserved.
//
#import "NYAlertView.h"
#import "NYAlertViewController.h"
#import "NYAlertManager.h"
#import "Constants.h"

@implementation NYAlertManager

+ (void)showAlertViewWithMessage :(NSString *)message forViewController:(UIViewController *)vC :(void (^)(BOOL okPressed)) completionBlock
{
    NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithNibName:nil bundle:nil];
    
    alertViewController.backgroundTapDismissalGestureEnabled = YES;
    alertViewController.swipeDismissalGestureEnabled = YES;
    
    alertViewController.title = NSLocalizedString(@"Mreedazle", nil);
    alertViewController.message = NSLocalizedString(message, nil);
    
    alertViewController.buttonCornerRadius = 20.0f;
    alertViewController.view.tintColor = vC.view.tintColor;
    
    alertViewController.titleFont = [UIFont fontWithName:OPEN_SANS_BOLD size:18.0f];
    alertViewController.messageFont = [UIFont fontWithName:OPEN_SANS_MEDIUM size:16.0f];
    alertViewController.buttonTitleFont = [UIFont fontWithName:OPEN_SANS size:alertViewController.buttonTitleFont.pointSize];
    alertViewController.cancelButtonTitleFont = [UIFont fontWithName:OPEN_SANS_MEDIUM size:alertViewController.cancelButtonTitleFont.pointSize];
    
    alertViewController.alertViewBackgroundColor = [UIColor colorWithWhite:0.19f alpha:1.0f];
    alertViewController.alertViewCornerRadius = 10.0f;
    
    alertViewController.titleColor = [UIColor colorWithRed:230.0/255 green:167.0/255 blue:50.0/255 alpha:1];
    
    alertViewController.messageColor = [UIColor colorWithWhite:0.92f alpha:1.0f];
    
    alertViewController.buttonColor = [UIColor colorWithRed:230.0/255 green:167.0/255 blue:50.0/255 alpha:1];

    alertViewController.buttonTitleColor = [UIColor colorWithWhite:0.19f alpha:1.0f];
    
    alertViewController.cancelButtonColor = [UIColor colorWithRed:230.0/255 green:167.0/255 blue:50.0/255 alpha:1];
    alertViewController.cancelButtonTitleColor = [UIColor colorWithWhite:0.19f alpha:1.0f];
    
    [alertViewController addAction:[NYAlertAction actionWithTitle:NSLocalizedString(@"Ok", nil)
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(NYAlertAction *action) {
                                                              completionBlock(YES);
                                                          }]];
    
    [alertViewController addAction:[NYAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                            style:UIAlertActionStyleCancel
                                                          handler:^(NYAlertAction *action) {
                                                              completionBlock(NO);

                                                          }]];
    
    [vC presentViewController:alertViewController animated:YES completion:nil];
}

+ (void)showTermsAndConditionsAlertViewOnViewController:(UIViewController *)vC {
    NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithNibName:nil bundle:nil];
    
    alertViewController.title = NSLocalizedString(@"Terms And Conditions", nil);
    alertViewController.message = NSLocalizedString(@"Terms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And ConditionsTerms And Conditions", nil);
    
    alertViewController.transitionStyle = NYAlertViewControllerTransitionStyleSlideFromBottom;
    alertViewController.cancelButtonColor = [UIColor colorWithRed:230.0/255 green:167.0/255 blue:50.0/255 alpha:1];
    [alertViewController addAction:[NYAlertAction actionWithTitle:NSLocalizedString(@"Close", nil)
                                                            style:UIAlertActionStyleCancel
                                                          handler:^(NYAlertAction *action) {
                                                              [vC dismissViewControllerAnimated:YES completion:nil];
                                                          }]];
    
    [vC presentViewController:alertViewController animated:YES completion:nil];
}
@end
