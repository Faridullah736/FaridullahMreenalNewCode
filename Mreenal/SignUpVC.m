//
//  SignUpVC.m
//  Mreenal
//
//  Created by Xpired on 3/7/16.
//  Copyright © 2016 Xpired. All rights reserved.
//

#import "SignUpVC.h"
#import "SignUpVCMore.h"
#import "PickerView.h"
#import "UtilityClass.h"
#import "ActionSheet.h"
#import "UserModel.h"
#import "AFNetworkingHandler.h"
#import "HomeVC.h"
#import "NSString+emailValidation.h"
@implementation SignUpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(USER_MODEL_MANAGER.userLoginFromFacebook) [self autoFillInfo];
    
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
- (void)autoFillInfo
{
        [_txtEmail              setText:[USER_MODEL_MANAGER email]];
        [_txtConfirmEmail       setText:[USER_MODEL_MANAGER email]];
        [_txtFirstName          setText:[USER_MODEL_MANAGER fname]];
        [_txtLastName           setText:[USER_MODEL_MANAGER lname]];
    
    if ([USER_MODEL_MANAGER email]) {
        _isValidEmail = YES;
        _isValidConfirmEmail = YES;
        [_imgTickEmail setHidden:NO];
        [_imgTickConfirmEmail setHidden:NO];
    }
    
}
- (IBAction)btnChangeImagePressed:(id)sender {
    
    ActionSheet *actionSheet = [self.storyboard instantiateViewControllerWithIdentifier:ID_ACTION_SHEET_VC];
    [actionSheet setDelegate:self];
    [UtilityClass addSubview:actionSheet andParentViewController:self];
    
}

- (IBAction)btnNextPressed:(id)sender {
    
    
    SignUpVCMore  *signUpMore = [self.storyboard instantiateViewControllerWithIdentifier:ID_SIGNUP_MORE_VC];
    [signUpMore assignSignUpDictionaryWithDict:[self getSignupDictionary]];
    [self.navigationController pushViewController:signUpMore animated:YES];
}


- (void)confirmEmail
{
    if (_txtConfirmEmail.text.length == 0) {
        return;
    }
    if ([_txtEmail.text isEqualToString:_txtConfirmEmail.text]) {
        
        [self setConfirmEmailMatched];
        _isValidConfirmEmail = YES;
    }
    else
    {
        [self setConfirmEmailNotMatched];
        _isValidConfirmEmail = NO;
    }
}

- (void)setTextFieldsPlaceHolderColor
{
    [_txtFirstName      setValue:[UIColor whiteColor]       forKeyPath:@"_placeholderLabel.textColor"];
    [_txtLastName       setValue:[UIColor whiteColor]       forKeyPath:@"_placeholderLabel.textColor"];
    [_txtUsername       setValue:[UIColor whiteColor]       forKeyPath:@"_placeholderLabel.textColor"];
    [_txtPassword       setValue:[UIColor whiteColor]       forKeyPath:@"_placeholderLabel.textColor"];
    [_txtEmail          setValue:[UIColor whiteColor]       forKeyPath:@"_placeholderLabel.textColor"];
    [_txtConfirmEmail   setValue:[UIColor whiteColor]       forKeyPath:@"_placeholderLabel.textColor"];

}
#pragma mark - Check User if exists
- (void)checkifUsernameExists
{
    NSMutableDictionary *userParam  =           [NSMutableDictionary new];
    [userParam setValue:_txtUsername.text       forKey:KEY_USERNAME];
    
    [SERVER_MANAGER postRequestWithMethodName:METHOD_UESR_EXIST AndParamaters:userParam andShowSpinner:YES WithSuccess:^(id responseData, NSString *responseMessage, NSString *resposneStatusCode) {
        
        if ([resposneStatusCode  intValue] == kSuccess )
        {
            NSLog(@"Response: %@",responseMessage);
            [self showTickForUsername:YES];
            [self enableNextButton];
        }
        else if([resposneStatusCode  intValue] == kBadRequest)
        {
            [self showTickForUsername:NO];
            [self enableNextButton];
        }
        else
            [UtilityClass showAlertViewController:MSG_INCORRECT_EMAIL_MSG withTitle:MSG_ALERT_TITLE andViewController:self];
        
    } Failuer:^(NSString *errorDescription) {
        
        [UtilityClass showAlertViewController:errorDescription withTitle:MSG_ALERT_TITLE andViewController:self];
    }];

}
- (void)showTickForUsername:(BOOL)isUserExists
{
    if (isUserExists) {
        [self setUsernameAvailable];
        _isValidUsername = YES;
    }
    else
    {
        [self setUsernameNotAvailable];
        _isValidUsername = NO;
    }
}
#pragma mark - Check email if exits
- (void)checkifEmailExists
{
    [self confirmEmail];
    
    if ([_txtEmail.text isValidEmail]) {
        
    NSMutableDictionary *userParam  =           [NSMutableDictionary new];
    [userParam setValue:_txtEmail.text          forKey:KEY_USER_EMAIL];
    
    [SERVER_MANAGER postRequestWithMethodName:METHOD_EMAIL_EXIST AndParamaters:userParam andShowSpinner:YES WithSuccess:^(id responseData, NSString *responseMessage, NSString *resposneStatusCode) {
        
        if ([resposneStatusCode  intValue] == kSuccess )
        {
            NSLog(@"Response: %@",responseMessage);
            [self showTickForEmail:YES];
            [self enableNextButton];
        }
        else if([resposneStatusCode  intValue] == kBadRequest)
        {
            [self showTickForEmail:NO];
            [self enableNextButton];
        }
        else
            [UtilityClass showAlertViewController:MSG_INCORRECT_EMAIL_MSG withTitle:MSG_ALERT_TITLE andViewController:self];
        
    } Failuer:^(NSString *errorDescription) {
        
        [UtilityClass showAlertViewController:errorDescription withTitle:MSG_ALERT_TITLE andViewController:self];
    }];

    }
    else
    {
        [self setEmailNotAvailable];
        _isValidEmail = NO;
    }
}
- (void)showTickForEmail:(BOOL)isEmailExists
{
    if (isEmailExists) {
        [self setEmailAvailable];
        _isValidEmail = YES;
    }
    else
    {
        [self setEmailNotAvailable];
        _isValidEmail = NO;
    }
}
#pragma mark - ActionSheet Delegate Methods
- (void)didRecieveImage:(UIImage *)image
{
    UIImage *resixedImage = [self imageWithImage:image scaledToSize:_btnChangeImage.imageView.frame.size];
    [_btnChangeImage.imageView.layer            setCornerRadius: _btnChangeImage.imageView.frame.size.height/2];
    [_btnChangeImage.imageView.layer            setMasksToBounds: YES];
    [_btnChangeImage.imageView.layer            setBorderWidth:10.0];
    [_btnChangeImage.imageView.layer            setBorderColor: [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5f].CGColor];
    [_btnChangeImage setImage:resixedImage      forState:UIControlStateNormal];
    _isValidImage = YES;
    [self enableNextButton];
}


#pragma mark - UITextField Delegate Methods
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"%@",textField.text);
    switch (textField.tag) {
            
        case TAG_USERNAME_SIGNUP:
            if(_txtUsername.text.length > 0)
            {
                [self checkifUsernameExists];
            }
            else
            {
                _isValidUsername = NO;
                [_imgTickUsername setHidden:YES];
            }
            break;
            
        case TAG_EMAIL_SIGNUP:
            if(_txtEmail.text.length > 0)
            {
                [self checkifEmailExists];
                
            }
            else
            {
                _isValidEmail = NO;
                [_imgTickEmail setHidden:YES];
            }
            break;
        case TAG_CONFIRM_EMAIL_SIGNUP:
            if(_txtConfirmEmail.text.length > 0)
            {
                [self confirmEmail];
                
            }
            else
            {
                _isValidConfirmEmail = NO;
                [_imgTickConfirmEmail setHidden:YES];
            }
            break;
        default:
            break;
    }
    [self enableNextButton];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    switch (textField.tag) {
        case TAG_FNAME_SIGNUP:
            [_txtLastName       becomeFirstResponder];
            break;
            
        case TAG_LNAME_SIGNUP:
            [_txtUsername       becomeFirstResponder];
            break;
            
        case TAG_USERNAME_SIGNUP:
            [_txtPassword       becomeFirstResponder];
            break;
            
        case TAG_PASSWORD_SIGNUP:
            [_txtEmail          becomeFirstResponder];
            break;
            
        case TAG_EMAIL_SIGNUP:
            [_txtConfirmEmail   becomeFirstResponder];
            break;
            
        case TAG_CONFIRM_EMAIL_SIGNUP:
            [textField resignFirstResponder];
            break;
            
        default:
            break;
    }
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == TAG_USERNAME_SIGNUP || textField.tag == TAG_EMAIL_SIGNUP || textField.tag == TAG_CONFIRM_EMAIL_SIGNUP) {
        
        NSRange spaceRange = [string rangeOfString:@" "];
        
        if (spaceRange.location != NSNotFound)
        {
            return NO;
        } else
        {
            return YES;
        }
        
    }
    if (textField.text.length >= USERNAME_MAX_LENGTH && range.length == 0 && textField.tag == TAG_USER_NAME)
    {
        return NO;
    }
    
    else if (textField.text.length >= PASSWORD_MAX_LENGTH && range.length == 0 && textField.tag == TAG_PASSWORD)
    {
        return NO;
    }
    else
    {
        return YES;
    }
    

    return YES;
}

#pragma mark - UINavigation Properties

- (void)setNavigationProperties
{

    self.navigationItem.title = @"Signup";
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont fontWithName:OPEN_SANS_BOLD size:16.0], NSFontAttributeName, nil];
    
}

- (void)enableNextButton
{
    if (_txtFirstName.text.length > 0 && _txtLastName.text.length > 0 && _txtPassword.text.length > 0 && _isValidUsername && _isValidEmail && _isValidConfirmEmail && _isValidImage) {
        [_btnNext setEnabled:YES];
    }
    else
        [_btnNext setEnabled:NO];
}

- (NSMutableDictionary *)getSignupDictionary
{
    NSMutableDictionary *signUpDict =   [NSMutableDictionary new];
    NSString *uniqueNameForImage    =   [UTILITY_MANAGER getUniqueUserImageNameFromUserName:_txtUsername.text];
        [signUpDict setValue:_txtFirstName.text                                                                         forKey:KEY_USER_FNAME];
        [signUpDict setValue:_txtLastName.text                                                                          forKey:KEY_USER_LNAME];
        [signUpDict setValue:_txtUsername.text                                                                          forKey:KEY_USERNAME];
        [signUpDict setValue:_txtPassword.text                                                                          forKey:KEY_USER_PASSWORD];
        [signUpDict setValue:_txtEmail.text                                                                             forKey:KEY_USER_EMAIL];
        [signUpDict setValue:uniqueNameForImage                                                                         forKey:KEY_USER_IMAGE_NAME];
        [signUpDict setValue:[self getDataFromImage]                                                                    forKey:KEY_USER_IMAGE_DATA];
        if(USER_MODEL_MANAGER.userLoginFromFacebook)
        {
        [signUpDict setValue:KEY_LOGIN_TYPE_FACEBOOK                                                                    forKey:KEY_USER_LOGIN_TYPE];
        [signUpDict setValue:USER_MODEL_MANAGER.fbId                                                                    forKey:KEY_USER_FBID];
        }
        else
        [signUpDict setValue:KEY_LOGIN_TYPE_EMAIL                                                                       forKey:KEY_USER_LOGIN_TYPE];
    
    return signUpDict;
}
- (NSData *)getDataFromImage
{
    return UIImageJPEGRepresentation(_btnChangeImage.imageView.image, 0.6);
    
}
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


- (void)setUsernameAvailable
{
    [_imgTickUsername setHidden:NO];
    [_imgTickUsername setImage:[UIImage imageNamed:@"imgTick"]];
}
- (void)setUsernameNotAvailable
{
    [_imgTickUsername setHidden:NO];
    [_imgTickUsername setImage:[UIImage imageNamed:@"imgCross"]];
}
- (void)setEmailAvailable
{
    [_imgTickEmail setHidden:NO];
    [_imgTickEmail setImage:[UIImage imageNamed:@"imgTick"]];
}
- (void)setEmailNotAvailable
{
    [_imgTickEmail setHidden:NO];
    [_imgTickEmail setImage:[UIImage imageNamed:@"imgCross"]];
}
- (void)setConfirmEmailMatched
{
    [_imgTickConfirmEmail setHidden:NO];
    [_imgTickConfirmEmail setImage:[UIImage imageNamed:@"imgTick"]];
}
- (void)setConfirmEmailNotMatched
{
    [_imgTickConfirmEmail setHidden:NO];
    [_imgTickConfirmEmail setImage:[UIImage imageNamed:@"imgCross"]];
}
@end
