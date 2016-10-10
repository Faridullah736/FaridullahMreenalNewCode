//
//  payementVC.h
//  Mreedazzle
//
//  Created by Faridullah on 10/9/16.
//  Copyright © 2016 Xpired. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayPalMobile.h"
@interface payementVC : UIViewController<PayPalPaymentDelegate,UIPopoverControllerDelegate>

@property(nonatomic, strong, readwrite) NSString *environment;
@property(nonatomic, strong, readwrite) NSString *resultText;
- (IBAction)backBtnAction:(id)sender;
- (IBAction)checkOutAction:(id)sender;
@end
