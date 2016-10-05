//
//  SignUpVC.h
//  Mreenal
//
//  Created by Xpired on 3/7/16.
//  Copyright © 2016 Xpired. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerViewProtocol.h"
#import "ActionSheetProtocol.h"

@interface SignUpVC : UIViewController<ActionSheetProtocol,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imgUserProfileBackground;
@property (weak, nonatomic) IBOutlet UIButton    *btnChangeImage;
@property (weak, nonatomic) IBOutlet UITextField *txtFirstName;
@property (weak, nonatomic) IBOutlet UITextField *txtLastName;
@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtConfirmEmail;
@property (weak, nonatomic) IBOutlet UIButton    *btnNext;
@property (weak, nonatomic) IBOutlet UIImageView *imgTickUsername;
@property (weak, nonatomic) IBOutlet UIImageView *imgTickEmail;
@property (weak, nonatomic) IBOutlet UIImageView *imgTickConfirmEmail;
@property (nonatomic)           BOOL             isValidUsername;
@property (nonatomic)           BOOL             isValidEmail;
@property (nonatomic)           BOOL             isValidConfirmEmail;
@property (nonatomic)           BOOL             isValidImage;

- (IBAction)btnChangeImagePressed:(id)sender;
- (IBAction)btnNextPressed:(id)sender;


@end
