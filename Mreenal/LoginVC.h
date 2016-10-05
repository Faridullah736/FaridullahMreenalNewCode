//
//  LoginVC.h
//  Mreenal
//
//  Created by Xpired on 3/7/16.
//  Copyright © 2016 Xpired. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworkingHandler.h"

@interface LoginVC : UIViewController<UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnRememberMe;
@property (retain, nonatomic) NSDictionary *facebookResult;
@property (nonatomic)       BOOL isRememberMe;


- (IBAction)btnLoginPressed:(id)sender;
- (IBAction)btnLoginFbPressed:(id)sender;
- (IBAction)btnRememberMePressed:(id)sender;


@end
