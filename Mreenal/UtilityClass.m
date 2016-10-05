//
//  UtilityClass.m
//  Mreenal
//
//  Created by Xpired on 3/7/16.
//  Copyright © 2016 Xpired. All rights reserved.
//

#import "UtilityClass.h"
#import "AppDelegate.h"

@implementation UtilityClass

+ (UtilityClass *)sharedMyManager
{
    static UtilityClass *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
        
        
    });
    return sharedMyManager;
}

+ (void)showAlertViewController:(NSString *)data withTitle:(NSString *)titile andViewController:(UIViewController *)viewcontroller
{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:titile message:data preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    [alertController dismissViewControllerAnimated:NO completion:nil];}];
    
    [alertController addAction:cancelAction];
    
    [viewcontroller presentViewController:alertController animated:YES completion:nil];
}

- (void)showSpinner:(UIViewController *)viewController
{
    UIView *backview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewController.view.frame.size.width, viewController.view.frame.size.height)];
    backview.backgroundColor = [UIColor blackColor];
    backview.tag = SPINER_TAG;
    backview.alpha = 0.3;
    RTSpinKitView *spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyleThreeBounce];
    spinner.center= backview.center;
    [backview addSubview:spinner];
    [viewController.view addSubview:backview];
}

- (void)hideSpinner:(UIViewController *)viewController
{
    [[viewController.view viewWithTag:SPINER_TAG] removeFromSuperview];
    
}

+ (void)addSubview:(UIViewController *)childVC andParentViewController:(UIViewController *)parentVC
{
    UIView * childView      = childVC.view;
    CGFloat screenHeight    = [UIScreen mainScreen].bounds.size.height;
    CGFloat screenWidth     = [UIScreen mainScreen].bounds.size.width;
    
    [childView setFrame:CGRectMake(0, screenHeight, screenWidth, screenHeight)];
    
    if (childView.superview==nil) {
        [parentVC.view addSubview:childView];
        [UIView animateWithDuration:0.3 animations:^{
        
            [childView setFrame:CGRectMake(0, 0, childView.frame.size.width, childView.frame.size.height)];
            
        } completion:^(BOOL finished) {
            if(childVC.parentViewController==nil)
            {
                [parentVC addChildViewController:childVC];
            }
        }];
    }
    

}

+ (void)removeSubViewFromParent:(UIViewController *)removeAbleViewController
{
    
    CGFloat screenHeight    = [UIScreen mainScreen].bounds.size.height;
    CGFloat screenWidth     = [UIScreen mainScreen].bounds.size.width;
    UIView * childView      = removeAbleViewController.view;
    
    if(childView.superview)
    {
        [UIView animateWithDuration:0.3 animations:^{
            
            [childView setFrame:CGRectMake(0, screenHeight, screenWidth, screenHeight)];
            
        } completion:^(BOOL finished) {
            [childView removeFromSuperview];
            if(removeAbleViewController.parentViewController)
            {
                [removeAbleViewController removeFromParentViewController];
            }
        }];
    }
    
}

+ (void)addSubviewWithBounce:(UIViewController *)childVC andParentViewController:(UIViewController *)parentVC
{
    childVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    
    [parentVC.view addSubview:childVC.view];
    
    [UIView animateWithDuration:0.3/1.5 animations:^{
        childVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            childVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                childVC.view.transform = CGAffineTransformIdentity;
                [parentVC addChildViewController:childVC];
            }];
        }];
    }];
}

+ (void)removeBounceSubViewFromParent:(UIViewController *)removeAbleViewController
{
    [removeAbleViewController.view removeFromSuperview];
    [removeAbleViewController removeFromParentViewController];
}

+ (CGFloat)getScreenWidth{
    
    CGRect mainRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = mainRect.size.width;
    return screenWidth;
    
}
+ (CGFloat)getScreenHeight
{
    
    CGRect mainRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = mainRect.size.height;
    return screenHeight;
}
+ (UIViewController *)getRootViewController
{
    AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    return [appDelegate.window rootViewController];

}
- (NSString *)formatPhoneNumber:(NSString*) simpleNumber deleteLastChar:(BOOL)deleteLastChar
{
    if(simpleNumber.length==0) return @"";
    // use regex to remove non-digits(including spaces) so we are left with just the numbers
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[\\s-\\(\\)]" options:NSRegularExpressionCaseInsensitive error:&error];
    simpleNumber = [regex stringByReplacingMatchesInString:simpleNumber options:0 range:NSMakeRange(0, [simpleNumber length]) withTemplate:@""];
    
    // check if the number is to long
    if(simpleNumber.length>10) {
        // remove last extra chars.
        simpleNumber = [simpleNumber substringToIndex:10];
    }
    
    if(deleteLastChar) {
        // should we delete the last digit?
        simpleNumber = [simpleNumber substringToIndex:[simpleNumber length] - 1];
    }
    
    // 123 456 7890
    // format the number.. if it's less then 7 digits.. then use this regex.
    if(simpleNumber.length<7)
        simpleNumber = [simpleNumber stringByReplacingOccurrencesOfString:@"(\\d{3})(\\d+)"
                                                               withString:@"($1) $2"
                                                                  options:NSRegularExpressionSearch
                                                                    range:NSMakeRange(0, [simpleNumber length])];
    
    else   // else do this one..
        simpleNumber = [simpleNumber stringByReplacingOccurrencesOfString:@"(\\d{3})(\\d{3})(\\d+)"
                                                               withString:@"($1) $2-$3"
                                                                  options:NSRegularExpressionSearch
                                                                    range:NSMakeRange(0, [simpleNumber length])];
    return simpleNumber;
}

- (NSString *)getUniqueUserImageNameFromUserName:(NSString *)username
{
    username = [username stringByAppendingString:[NSString stringWithFormat:@"%ld", (long)(100 + arc4random_uniform(1000 - 100 + 1))]];
    const char *cStr = [username UTF8String];
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(cStr, (int)strlen(cStr), result);
    NSString *sha1 = [NSString  stringWithFormat:
                   @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                   result[0], result[1], result[2], result[3], result[4],
                   result[5], result[6], result[7],
                   result[8], result[9], result[10], result[11], result[12],
                   result[13], result[14], result[15],
                   result[16], result[17], result[18], result[19]
                   ];
    sha1 = [sha1 stringByAppendingString:@".png"];
    return sha1;
}

@end
