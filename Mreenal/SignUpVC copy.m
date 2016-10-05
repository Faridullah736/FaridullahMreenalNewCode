//
//  SignUpVC.m
//  Mreenal
//
//  Created by Xpired on 3/7/16.
//  Copyright © 2016 Xpired. All rights reserved.
//

#import "SignUpVC.h"
#import "PickerView.h"
#import "UtilityClass.h"
#import "ActionSheet.h"
#import "UserModel.h"
#import "AFNetworkingHandler.h"
#import "HomeVC.h"

@implementation SignUpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(_isFacebookFirstTime) [self autoFillInfo];
    
    [self setTextFieldsPlaceHolderColor];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    [self setNavigationProperties];
}

- (IBAction)btnChangeImagePressed:(id)sender {
    
    ActionSheet *actionSheet = [self.storyboard instantiateViewControllerWithIdentifier:@"ActionSheet"];
    [actionSheet setDelegate:self];
    [UtilityClass addSubview:actionSheet andParentViewController:self];
    
}
//- (IBAction)btnDateOfBirthPressed:(id)sender {
//    
//    [self.view endEditing:YES];
//    
//    PickerView *pickerInstance = [[PickerView alloc]initWithViewController:self withTitle:DATE_TITLE isDatePicker:YES];
//    pickerInstance.component = 1;
//    pickerInstance.isDatePicker = YES;
//    pickerInstance.delegate = self;
//    [self.view addSubview:pickerInstance];
//    
//    
//}

//
//- (IBAction)btnHeighPressed:(id)sender {
//    
//    [self.view endEditing:YES];
//    
//    NSArray *feetsArray = [[NSArray alloc] initWithObjects:@"4'",@"5'",@"6'",@"7'",@"8'",@"9'",@"10'",nil];
//    NSArray *inchesArray = [[NSArray alloc] initWithObjects:@"1''",@"2''", @"3''", @"4''",@"5''",@"6''",@"7''",@"8''",@"9''",@"10''",@"11''",@"12''",nil];
//    
//  
//    PickerView *pickerInstance = [[PickerView alloc]initWithViewController:self withTitle:HEGHT_TITLE isDatePicker:NO];
//    pickerInstance.component = 2;
//    pickerInstance.pickerDataArray = feetsArray;
//    pickerInstance.pickerDataArray2 = inchesArray;
//    pickerInstance.isHeightPicker = YES;
//    pickerInstance.selectValue = feetsArray[0];
//    pickerInstance.selectValue2 = inchesArray[0];
//    pickerInstance.delegate = self;
//    [self.view addSubview:pickerInstance];
//}


- (IBAction)btnSignUpPressed:(id)sender {
    
//    [self.view endEditing:YES];
//    return;
    [self sendSignUpRequestWithParameters:[self getSignupDictionary]];
    
}

- (IBAction)btnCancelPressed:(id)sender {
}

#pragma mark - UINavigation Properties
- (void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setNavigationProperties
{

    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationItem.title = @"Signup";
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont fontWithName:OPEN_SANS_BOLD size:16.0], NSFontAttributeName, nil];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"btnBack"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 8, 13);
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backButton;
    
}
- (void)autoFillInfo
{
//    [_txtEmail  setText:[USER_MODEL_MANAGER email]];
//    [_txtFname  setText:[USER_MODEL_MANAGER fname]];
//    [_txtLname  setText:[USER_MODEL_MANAGER lname]];
//    [_btnGender setTitle:[USER_MODEL_MANAGER gender] forState:UIControlStateNormal];
    
}
- (void)sendSignUpRequestWithParameters :(NSMutableDictionary *)params
{
    
    [SERVER_MANAGER sendPOSTRequestToServerWithMethodName:METHOD_SIGN_UP AndParamaters:params andShowSpinner:YES AndImage:_btnChangeImage.imageView.image WithSuccess:^(id responseData, NSString *responseMessage, NSString *resposneStatusCode) {
        
        if ([resposneStatusCode  intValue] == kSuccess )
        {
             NSLog(@"Signup Succesfull.");
        }
        
    } Failuer:^(NSString *errorDescription) {
        
            [UtilityClass showAlertViewController:errorDescription withTitle:MSG_ALERT_TITLE andViewController:self];
        
    }];
//    [SERVER_MANAGER postRequestWithMethodName:METHOD_SIGN_UP AndParamaters:params andShowSpinner:YES WithSuccess:^(id responseData, NSString *responseMessage, NSString *resposneStatusCode) {
//        
//        if ([resposneStatusCode  intValue] == kSuccess )
//        {
//            NSLog(@"Signup Succesfull.");
//            [USER_MODEL_MANAGER populateUserModel:responseData];
//            HomeVC *homeInstance = [self.storyboard instantiateViewControllerWithIdentifier:ID_HOME];
//            [self.navigationController pushViewController:homeInstance animated:YES];
//        }
////        else if ([resposneStatusCode intValue] == kNoRecordForSocialId)
////        {
////            [self setUserModel];
////            SignUpVC *signUpInstance = [self.storyboard instantiateViewControllerWithIdentifier:ID_SIGNUP];
////            [signUpInstance setIsFacebookFirstTime:YES];
////            [self.navigationController pushViewController:signUpInstance animated:YES];
////        }
//        else if ([resposneStatusCode intValue] == kBadRequest)
//        {
//            [UtilityClass showAlertViewController:MSG_INCORRECT_EMAIL_MSG withTitle:MSG_ALERT_TITLE andViewController:self];
//        }
//        
//    } Failuer:^(NSString *errorDescription) {
//        
//        [UtilityClass showAlertViewController:errorDescription withTitle:MSG_ALERT_TITLE andViewController:self];
//    }];
    
}
- (NSMutableDictionary *)getSignupDictionary
{
    NSMutableDictionary *signUpDict = [NSMutableDictionary new];
    
//    [signUpDict setValue:_txtFname.text                     forKey:KEY_USER_FNAME];
//    [signUpDict setValue:_txtLname.text                     forKey:KEY_USER_LNAME];
//    [signUpDict setValue:_txtEmail.text                     forKey:KEY_USER_EMAIL];
//    [signUpDict setValue:@"abc123"                          forKey:KEY_USER_PASSWORD];
//    [signUpDict setValue:_btnDateOfBirth.titleLabel.text    forKey:KEY_USER_DOB];
//    [signUpDict setValue:_btnGender.titleLabel.text         forKey:KEY_USER_GENDER];
//    [signUpDict setValue:_btnHeight.titleLabel.text         forKey:KEY_USER_HEIGHT];
//    [signUpDict setValue:_btnWaist.titleLabel.text          forKey:KEY_USER_WAIST];
//    [signUpDict setValue:_btnShoulders.titleLabel.text      forKey:KEY_USER_SHOULDERS];
//    [signUpDict setValue:_btnArms.titleLabel.text           forKey:KEY_USER_ARMS];
//    [signUpDict setValue:_btnLegs.titleLabel.text           forKey:KEY_USER_LEGS];
//    [signUpDict setValue:_btnShoSize.titleLabel.text        forKey:KEY_USER_SHO_SIZE];
//   
//    if (_isFacebookFirstTime) {
//    [signUpDict setValue:[USER_MODEL_MANAGER fbId]          forKey:KEY_USER_FBID];
//    [signUpDict setValue:KEY_LOGIN_TYPE_FACEBOOK            forKey:KEY_USER_LOGIN_TYPE];
//    }
//    else
//    [signUpDict setValue:KEY_LOGIN_TYPE_EMAIL               forKey:KEY_USER_LOGIN_TYPE];
//    [signUpDict setValue:@"200" forKey:KEY_USER_IMAGE];
    
    return signUpDict;
}
#pragma mark - ActionSheet Delegate Methods
- (void)didRecieveImage:(UIImage *)image
{
    // [_btnChangeImage setImage:image forState:UIControlStateNormal];
}
#pragma mark - UITextField Delegate Methods
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

- (void)setTextFieldsPlaceHolderColor
{
    _txtFirstName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"First Name"
                                                                            attributes:@{
                                                                                         NSForegroundColorAttributeName: [UIColor whiteColor]
                                                                                         }
     ];
    _txtLastName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Last Name"
                                                                         attributes:@{
                                                                                      NSForegroundColorAttributeName: [UIColor whiteColor]
                                                                                      }
     ];
    _txtUsername.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Username"
                                                                         attributes:@{
                                                                                      NSForegroundColorAttributeName: [UIColor whiteColor]
                                                                                      }
                                          ];
    _txtPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password"
                                                                         attributes:@{
                                                                                      NSForegroundColorAttributeName: [UIColor whiteColor]
                                                                                      }
                                          ];
    _txtEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email"
                                                                         attributes:@{
                                                                                      NSForegroundColorAttributeName: [UIColor whiteColor]
                                                                                      }
                                          ];
    _txtConfirmEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Confirm Email"
                                                                         attributes:@{
                                                                                      NSForegroundColorAttributeName: [UIColor whiteColor]
                                                                                      }
                                          ];
}
@end
