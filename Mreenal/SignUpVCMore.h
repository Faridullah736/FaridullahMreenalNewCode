//
//  SignUpVCMore.h
//  Mreenal
//
//  Created by Xpired on 4/11/16.
//  Copyright © 2016 Xpired. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerViewProtocol.h"
#import "PickerView.h"

@interface SignUpVCMore : UIViewController<PickerViewProtocol,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtDateOfBirth;
@property (weak, nonatomic) IBOutlet UITextField *txtPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtGender;
@property (weak, nonatomic) IBOutlet UITextField *txtHeight;
@property (weak, nonatomic) IBOutlet UITextField *txtWaist;
@property (weak, nonatomic) IBOutlet UITextField *txtShoulders;
@property (weak, nonatomic) IBOutlet UITextField *txtArms;
@property (weak, nonatomic) IBOutlet UITextField *txtLegs;
@property (weak, nonatomic) IBOutlet UITextField *txtShoes;
@property (weak, nonatomic) IBOutlet UIButton *btnSubscribeNewsLetter;
@property (weak, nonatomic) IBOutlet UIButton *btnTermsAndConditions;
@property (strong, nonatomic) NSMutableDictionary *signUpDict;
@property (nonatomic)       BOOL subscribeNewsletter;
@property (nonatomic)       BOOL agreedWithTermsAndConditions;



- (IBAction)btnDateOfBirthPressed:(id)sender;
- (IBAction)btnGenderPressed:(id)sender;
- (IBAction)btnHeightPressed:(id)sender;
- (IBAction)btnWaistPressed:(id)sender;
- (IBAction)btnShouldersPressed:(id)sender;
- (IBAction)btnArmsPressed:(id)sender;
- (IBAction)btnLegsPressed:(id)sender;
- (IBAction)btnShoezPressed:(id)sender;
- (IBAction)btnSubscribeNewsLetterPressed:(id)sender;
- (IBAction)btnTermsAndConditionsPressed:(id)sender;
- (IBAction)btnSignUpPressed:(id)sender;
- (IBAction)btnTermsShowPressed:(id)sender;

- (void)assignSignUpDictionaryWithDict :(NSMutableDictionary *)signUpStepOneDict;
@end
