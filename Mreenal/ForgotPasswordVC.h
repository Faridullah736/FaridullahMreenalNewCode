//
//  ForgotPasswordVC.h
//  Mreedazzle
//
//  Created by Xpired on 4/18/16.
//  Copyright © 2016 Xpired. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotPasswordVC : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtEmail;

@end
