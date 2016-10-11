//
//  LoginVC.m
//  Mreenal
//
//  Created by Xpired on 3/7/16.
//  Copyright © 2016 Xpired. All rights reserved.
//

#import "LoginVC.h"
#import "UtilityClass.h"
#import "HomeVC.h"
#import "UserModel.h"
#import "SignUpVC.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "TermsAndConditionsVC.h"
#import "NSUserDefaultManager.h"


@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    [self setTextFieldsPlaceHolderColor];
//    _txtUsername.text = @"xain";
//    _txtPassword.text = @"abc123";
}
- (void)viewWillAppear:(BOOL)animated
{
    [[UINavigationBar appearance] setHidden:YES];
    [self ifRememberMeExists];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [[UINavigationBar appearance] setHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnLoginPressed:(id)sender {
    
    
//    NSMutableDictionary *loginDict = [self getLoginDictionary];
//
//   [self sendLoginRequestWithParameters:loginDict];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate setupMMDrawerController];
}


- (IBAction)btnLoginFbPressed:(id)sender {

    [self signInUsingFacebookAccount];
}

- (IBAction)btnRememberMePressed:(id)sender {
    
    _isRememberMe = _isRememberMe ? NO : YES;
    
    if (_isRememberMe) {
        
        [_btnRememberMe setImage:[UIImage imageNamed:@"btnRadioSelected"]   forState:UIControlStateNormal];
    }
    else
        [_btnRememberMe setImage:[UIImage imageNamed:@"btnRadioNormal"]     forState:UIControlStateNormal];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
#pragma - mark UITextField Delegate Methods
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    textField.tag == TAG_USER_NAME ? [_txtPassword becomeFirstResponder] : [self btnLoginFbPressed:nil];

    return YES;
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    return YES;
    
}


- (void)sendLoginRequestWithParameters :(NSMutableDictionary *)params
{
    if (_txtUsername.text.length == 0 || _txtPassword.text.length == 0)
        return;
    
    [SERVER_MANAGER postRequestWithMethodName:METHOD_SIGN_IN AndParamaters:params andShowSpinner:YES WithSuccess:^(id responseData, NSString *responseMessage, NSString *resposneStatusCode) {
        
        if ([resposneStatusCode  intValue] == kSuccess )
        {
            NSLog(@"Login Succesfull.");
            
            _isRememberMe ? [NSUserDefaultManager setRememberMe:_txtUsername.text andPassword:_txtPassword.text] : 0;
            [USER_MODEL_MANAGER populateUserModel:responseData];
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [appDelegate setupMMDrawerController];
            
        }
        else if ([resposneStatusCode intValue] == kNoRecordForSocialId)
        {
            [self setUserModel];
            SignUpVC *signUpInstance = [self.storyboard instantiateViewControllerWithIdentifier:ID_SIGNUP_VC];
            [self.navigationController pushViewController:signUpInstance animated:YES];
        }
        else if ([resposneStatusCode intValue] == kBadRequest)
        {
            [UtilityClass showAlertViewController:MSG_INCORRECT_EMAIL_MSG withTitle:MSG_ALERT_TITLE andViewController:self];
        }
        
    } Failuer:^(NSString *errorDescription) {
        
        [UtilityClass showAlertViewController:errorDescription withTitle:MSG_ALERT_TITLE andViewController:self];
        
    }];
    
}

#pragma mark Get Facebook Information

-(void)signInUsingFacebookAccount
{
    //   FBSDKAccessToken cu
    NSLog(@"%@", [FBSDKAccessToken currentAccessToken]);
    if([FBSDKAccessToken currentAccessToken])
    {
        if([[FBSDKAccessToken currentAccessToken].permissions containsObject:KEY_USER_EMAIL])
        {
            [self fetchUserInformationAfterSuccessFullFacebookLogin:YES];
        }
        else
        {
            [self fetchUserInformationAfterSuccessFullFacebookLogin:NO];
        }
        return;
    }
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    
    [login logInWithReadPermissions:@[KEY_USER_EMAIL] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            
        } else if (result.isCancelled) {
            
        } else {
            
            if ([result.grantedPermissions containsObject:KEY_USER_EMAIL]) {
                
                NSLog(@"%@",result);
                [FBSDKAccessToken setCurrentAccessToken:result.token];
                
                [self fetchUserInformationAfterSuccessFullFacebookLogin:YES];
            }
            else
            {
                [self fetchUserInformationAfterSuccessFullFacebookLogin:NO];
            }
        }
    }];
}
-(void)fetchUserInformationAfterSuccessFullFacebookLogin:(BOOL)emailGranted
{
    NSString *paramsStrings = emailGranted ?  @"email , name" : @"name";
    
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields":paramsStrings}]
     
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
         if (error) {
             NSLog(@"Login error: %@", [error localizedDescription]);
             dispatch_async(dispatch_get_main_queue(), ^{
                 
             });
             return;
         }
         else
         {
             _facebookResult = [result mutableCopy];
             NSMutableDictionary *facebookDict = [self getFacebookLoginDictionary];
             [self sendLoginRequestWithParameters:facebookDict];
             
         }
         NSLog(@"fecthed user: %@", result);
     }];
    
}

- (NSMutableDictionary *)getLoginDictionary
{
    
    NSMutableDictionary *loginDict  =           [NSMutableDictionary new];
    [loginDict setValue:_txtUsername.text       forKey:KEY_USERNAME];
    [loginDict setValue:_txtPassword.text       forKey:KEY_USER_PASSWORD];
    [loginDict setValue:KEY_LOGIN_TYPE_EMAIL    forKey:KEY_USER_LOGIN_TYPE];
    
    return loginDict;
}

- (NSMutableDictionary *)getFacebookLoginDictionary
{
    NSMutableDictionary *loginDict  =  [NSMutableDictionary new];
    [loginDict setValue:[_facebookResult valueForKey:KEY_ID]               forKey:KEY_USER_FBID];
    [loginDict setValue:KEY_LOGIN_TYPE_FACEBOOK                            forKey:KEY_USER_LOGIN_TYPE];
    return loginDict;
}
- (void)setUserModel
{
    NSArray *fullName = [[_facebookResult valueForKey:@"name"] componentsSeparatedByString:@" "];
    
    [USER_MODEL_MANAGER setFbId:    [_facebookResult valueForKey:KEY_ID]];
    [USER_MODEL_MANAGER setEmail:   [_facebookResult valueForKey:KEY_USER_EMAIL]];
    [USER_MODEL_MANAGER setGender:  [_facebookResult valueForKey:KEY_USER_GENDER]];
    [USER_MODEL_MANAGER setFname:   [fullName objectAtIndex:0]];
    [USER_MODEL_MANAGER setLname:   [fullName objectAtIndex:1]];
    [USER_MODEL_MANAGER setUserLoginFromFacebook:YES];
    
}
- (void)setTextFieldsPlaceHolderColor
{
    [_txtUsername       setValue:[UIColor whiteColor]       forKeyPath:@"_placeholderLabel.textColor"];
    [_txtPassword       setValue:[UIColor whiteColor]       forKeyPath:@"_placeholderLabel.textColor"];
}
- (void)ifRememberMeExists
{
    if([NSUserDefaultManager isRememberMe])
    {
        _txtUsername.text = [NSUserDefaultManager getUsername];
        _txtPassword.text = [NSUserDefaultManager getPassword];
    }
}
@end
