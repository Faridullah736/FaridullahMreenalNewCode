//
//  SignUpVCMore.m
//  Mreenal
//
//  Created by Xpired on 4/11/16.
//  Copyright © 2016 Xpired. All rights reserved.
//
#import "Constants.h"
#import "SignUpVCMore.h"
#import "UtilityClass.h"
#import "AFNetworkingHandler.h"
#import "UserModel.h"
#import "HomeVC.h"
#import "NYAlertManager.h"
#import "TermsAndConditionsVC.h"

@interface SignUpVCMore ()

@end

@implementation SignUpVCMore

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTextFieldsPlaceHolderColor];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    
    [self setNavigationProperties];
}

- (void)viewWillDisappear:(BOOL)animated
{
 
    [self.navigationItem setTitle:@""];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


- (IBAction)btnDateOfBirthPressed:(id)sender {
    
    [self.view endEditing:YES];
    
    PickerView *pickerInstance = [[PickerView alloc]initWithViewController:self withTitle:DATE_TITLE withPickerType:kDatePicker];
    pickerInstance.component = 1;
    pickerInstance.delegate = self;
    [self.view addSubview:pickerInstance];
}

- (IBAction)btnGenderPressed:(id)sender {
    
    [self.view endEditing:YES];
    
    NSArray *genderArray            =   [NSArray arrayWithObjects:@"Male",@"Female",@"Other", nil];
    
    PickerView *pickerInstance      = [[PickerView alloc]initWithViewController:self withTitle:GENDER_TITLE withPickerType:kGenderPicker];
    pickerInstance.component        = 1;
    pickerInstance.pickerDataArray  = genderArray;
    pickerInstance.selectValue      = genderArray[0];
    pickerInstance.delegate         = self;
    [self.view addSubview:pickerInstance];
}

- (IBAction)btnHeightPressed:(id)sender {
    
    [self.view endEditing:YES];
    
    NSArray *feetsArray             =   [self getFeetsArrayWithMin:4    andMaxValue:10];
    NSArray *inchesArray            =   [self getInchesArrayWithMin:1   andMaxValue:12];
    
    PickerView *pickerInstance      = [[PickerView alloc]initWithViewController:self withTitle:HEGHT_TITLE withPickerType:kHeightPicker];
    pickerInstance.component        = 2;
    pickerInstance.pickerDataArray  = feetsArray;
    pickerInstance.pickerDataArray2 = inchesArray;
    pickerInstance.selectValue      = feetsArray[0];
    pickerInstance.selectValue2     = inchesArray[0];
    pickerInstance.delegate         = self;
    [self.view addSubview:pickerInstance];
}

- (IBAction)btnWaistPressed:(id)sender {
    
    [self.view endEditing:YES];
    
    NSArray *inchesArray            =  [self getInchesArrayWithMin:15 andMaxValue:40];
    
    PickerView *pickerInstance      = [[PickerView alloc]initWithViewController:self withTitle:WAIST_TITLE withPickerType:kWaistPicker];
    pickerInstance.component        = 1;
    pickerInstance.pickerDataArray  = inchesArray;
    pickerInstance.selectValue      = inchesArray[0];
    pickerInstance.delegate         = self;
    [self.view addSubview:pickerInstance];
}

- (IBAction)btnShouldersPressed:(id)sender {
    
    [self.view endEditing:YES];
    
    NSArray *inchesArray            =  [self getInchesArrayWithMin:15 andMaxValue:40];
    
    PickerView *pickerInstance      = [[PickerView alloc]initWithViewController:self withTitle:SHOULDERS_TITLE withPickerType:kShoulderPicker];
    pickerInstance.component        = 1;
    pickerInstance.pickerDataArray  = inchesArray;
    pickerInstance.selectValue      = inchesArray[0];
    pickerInstance.delegate         = self;
    [self.view addSubview:pickerInstance];
}

- (IBAction)btnArmsPressed:(id)sender {
    
    [self.view endEditing:YES];
    
    NSArray *inchesArray            =  [self getInchesArrayWithMin:15 andMaxValue:40];
    
    PickerView *pickerInstance      = [[PickerView alloc]initWithViewController:self withTitle:ARMS_TITLE withPickerType:kArmsPicker];
    pickerInstance.component        = 1;
    pickerInstance.pickerDataArray  = inchesArray;
    pickerInstance.selectValue      = inchesArray[0];
    pickerInstance.delegate         = self;
    [self.view addSubview:pickerInstance];
}

- (IBAction)btnLegsPressed:(id)sender {
    
    [self.view endEditing:YES];
    
    NSArray *inchesArray            =  [self getInchesArrayWithMin:15 andMaxValue:40];
    
    PickerView *pickerInstance      = [[PickerView alloc]initWithViewController:self withTitle:LEGS_TITLE withPickerType:kLegsPicker];
    pickerInstance.component        = 1;
    pickerInstance.pickerDataArray  = inchesArray;
    pickerInstance.selectValue      = inchesArray[0];
    pickerInstance.delegate         = self;
    [self.view addSubview:pickerInstance];
}

- (IBAction)btnShoezPressed:(id)sender {
    
    [self.view endEditing:YES];
    
    NSArray *inchesArray            =  [self getInchesArrayWithMin:5 andMaxValue:15];
    
    PickerView *pickerInstance      = [[PickerView alloc]initWithViewController:self withTitle:SHOEZ_TITLE withPickerType:kShoePicker];
    pickerInstance.component        = 1;
    pickerInstance.pickerDataArray  = inchesArray;
    pickerInstance.selectValue      = inchesArray[0];
    pickerInstance.delegate         = self;
    [self.view addSubview:pickerInstance];
}

- (IBAction)btnSubscribeNewsLetterPressed:(id)sender {
    
    _subscribeNewsletter = _subscribeNewsletter ? NO : YES;
    
    if (_subscribeNewsletter) {
        
        [_btnSubscribeNewsLetter setImage:[UIImage imageNamed:@"btnRadioSelected"] forState:UIControlStateNormal];
    }
    else
        [_btnSubscribeNewsLetter setImage:[UIImage imageNamed:@"btnRadioNormal"] forState:UIControlStateNormal];
    
    
}

- (IBAction)btnTermsAndConditionsPressed:(id)sender {
    
    _agreedWithTermsAndConditions = _agreedWithTermsAndConditions ? NO : YES;
    
    if (_agreedWithTermsAndConditions) {
        
        [_btnTermsAndConditions setImage:[UIImage imageNamed:@"btnRadioSelected"] forState:UIControlStateNormal];
    }
    else
        [_btnTermsAndConditions setImage:[UIImage imageNamed:@"btnRadioNormal"] forState:UIControlStateNormal];
}

- (IBAction)btnSignUpPressed:(id)sender {
    
    __weak NSMutableDictionary *signUpDic = [self getSignupDictionary];
    [self sendSignUpRequestWithParameters:signUpDic];
    
}

- (IBAction)btnTermsShowPressed:(id)sender {
    
    [NYAlertManager showTermsAndConditionsAlertViewOnViewController:self];
    
}

- (void)sendSignUpRequestWithParameters :(NSMutableDictionary *)params
{
    
    [SERVER_MANAGER sendPOSTRequestToServerWithMethodNameAndImage:METHOD_SIGN_UP AndParamaters:params andShowSpinner:YES WithSuccess:^(id responseData, NSString *responseMessage, NSString *resposneStatusCode) {
        
        if ([resposneStatusCode  intValue] == kCreated )
        {
            NSLog(@"Signup Succesfull.");
            [USER_MODEL_MANAGER populateUserModel:responseData];
            AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
            [appDelegate setupMMDrawerController];
        }
        
    } Failuer:^(NSString *errorDescription) {
        
        [UtilityClass showAlertViewController:errorDescription withTitle:MSG_ALERT_TITLE andViewController:self];
        
    }];
    
}

- (void)setTextFieldsPlaceHolderColor
{
    
    
    [_txtDateOfBirth        setValue:[UIColor whiteColor]       forKeyPath:@"_placeholderLabel.textColor"];
    [_txtPhoneNumber        setValue:[UIColor whiteColor]       forKeyPath:@"_placeholderLabel.textColor"];
    [_txtGender             setValue:[UIColor whiteColor]       forKeyPath:@"_placeholderLabel.textColor"];
    [_txtHeight             setValue:[UIColor whiteColor]       forKeyPath:@"_placeholderLabel.textColor"];
    [_txtWaist              setValue:[UIColor whiteColor]       forKeyPath:@"_placeholderLabel.textColor"];
    [_txtShoulders          setValue:[UIColor whiteColor]       forKeyPath:@"_placeholderLabel.textColor"];
    [_txtArms               setValue:[UIColor whiteColor]       forKeyPath:@"_placeholderLabel.textColor"];
    [_txtLegs               setValue:[UIColor whiteColor]       forKeyPath:@"_placeholderLabel.textColor"];
    [_txtShoes              setValue:[UIColor whiteColor]       forKeyPath:@"_placeholderLabel.textColor"];
    
    
}
#pragma mark - UINavigation Properties

- (void)setNavigationProperties
{
    self.navigationItem.title = @"Optional";
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont fontWithName:OPEN_SANS_BOLD size:16.0], NSFontAttributeName, nil];
    self.navigationController.navigationBar.topItem.title = @"";
    
}

#pragma mark - PickerViewDelegate Method

-(void)didDone:(NSString *)selectedValueFromPicker :(kPickerType)pickerType
{
    
    switch (pickerType) {
        case kDatePicker:
            [_txtDateOfBirth    setText:selectedValueFromPicker];
            break;
        case kGenderPicker:
            [_txtGender         setText:selectedValueFromPicker];
            break;
        case kHeightPicker:
             [_txtHeight        setText:selectedValueFromPicker];
            break;
        case kWaistPicker:
             [_txtWaist         setText:selectedValueFromPicker];
            break;
        case kShoulderPicker:
             [_txtShoulders     setText:selectedValueFromPicker];
            break;
        case kArmsPicker:
             [_txtArms          setText:selectedValueFromPicker];
            break;
        case kLegsPicker:
             [_txtLegs          setText:selectedValueFromPicker];
            break;
        case kShoePicker:
             [_txtShoes         setText:selectedValueFromPicker];
            break;
            
        default:
            break;
    }
    
}

#pragma mark - UITextField Delegate Methods
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if(textField.tag == TAG_PHONE_NUMBER)
    {

        NSString* totalString = [NSString stringWithFormat:@"%@%@",textField.text,string];
        if([string isEqualToString:@""])
        {
            return YES;
        }
        if([string intValue]||[string isEqualToString:@"0"])
        {
            if (range.length == 1)
            {
                // Delete button was hit.. so tell the method to delete the last char.
                textField.text = [[UtilityClass sharedMyManager] formatPhoneNumber:totalString deleteLastChar:YES];
            }
            else
            {
                textField.text = [[UtilityClass sharedMyManager] formatPhoneNumber:totalString deleteLastChar:NO];
            }
            
            if(textField.text.length == 14)
            {
               
            }
        }
        
        return false;
        
    }
    return YES;
}

- (NSMutableDictionary *)getSignupDictionary
{
 
        [_signUpDict setValue:_txtDateOfBirth.text      forKey:KEY_USER_DOB];
        [_signUpDict setValue:_txtGender.text           forKey:KEY_USER_GENDER];
        [_signUpDict setValue:_txtHeight.text           forKey:KEY_USER_HEIGHT];
        [_signUpDict setValue:_txtWaist.text            forKey:KEY_USER_WAIST];
        [_signUpDict setValue:_txtShoulders.text        forKey:KEY_USER_SHOULDERS];
        [_signUpDict setValue:_txtArms.text             forKey:KEY_USER_ARMS];
        [_signUpDict setValue:_txtLegs.text             forKey:KEY_USER_LEGS];
        [_signUpDict setValue:_txtShoes.text            forKey:KEY_USER_SHO_SIZE];
        [_signUpDict setValue:_txtPhoneNumber.text      forKey:KEY_USER_PHONE];
    
        if(_subscribeNewsletter)
        [_signUpDict setValue:KEY_USER_SUBSCRIBE_NEWSLETTER         forKey:KEY_USER_NEWSLETTER];
        else
        [_signUpDict setValue:KEY_USER_NOT_SUBSCRIBE_NEWSLETTER     forKey:KEY_USER_NEWSLETTER];
    
    return _signUpDict;
}

- (void)assignSignUpDictionaryWithDict :(NSMutableDictionary *)signUpStepOneDict
{
    
    _signUpDict = [signUpStepOneDict mutableCopy];
}

- (NSArray *)getInchesArrayWithMin :(int)minValue andMaxValue :(int)maxValue
{
    NSMutableArray *inchesArray = [NSMutableArray new];
    for (; minValue <= maxValue; minValue ++) {
        
        __weak NSString *inch = [NSString stringWithFormat:@"%d''",minValue];
        [inchesArray addObject:inch];
    }
    
    return  [inchesArray mutableCopy];
}
- (NSArray *)getFeetsArrayWithMin :(int)minValue andMaxValue :(int)maxValue
{
    NSMutableArray *feetsArray = [NSMutableArray new];
    for (; minValue <= maxValue; minValue ++) {
        
        __weak NSString *inch = [NSString stringWithFormat:@"%d\"",minValue];
        [feetsArray addObject:inch];
    }
    
    return  [feetsArray mutableCopy];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
