//
//  Constants.h
//  Mreenal
//
//  Created by Xpired on 3/7/16.
//  Copyright © 2016 Xpired. All rights reserved.
//

#ifndef Constants_h
#define Constants_h


//Server Path
#define SERVER_INDEX_PATH @"http://a1datatech.com/classes/index.php?"
#define SERVER_DP_URL @"http://a1datatech.com/classes/images/"
//Western clothing Product API
#define WESTERN_Product_API    @"http://api.shopstyle.com/api/v2/products?pid=uid0-36072800-63&fts=red+dress&offset=0&limit=10"

//Server response keys
#define KEY_ID      @"id"
#define KEY_USER_ID @"user_id"
#define KEY_USERNAME   @"username"
#define KEY_USER_FNAME @"fname"
#define KEY_USER_LNAME @"lname"
#define KEY_USER_GENDER @"gender"
#define KEY_USER_DOB @"dob"
#define KEY_USER_PHONE @"phone"
#define KEY_USER_HEIGHT @"height"
#define KEY_USER_WAIST @"waist"
#define KEY_USER_SHOULDERS @"shoulders"
#define KEY_USER_ARMS @"arms"
#define KEY_USER_LEGS @"legs"
#define KEY_USER_SHO_SIZE @"sho_size"
#define KEY_USER_NEWSLETTER @"newsletter"
#define KEY_USER_EMAIL @"email"
#define KEY_USER_PASSWORD @"password"
#define KEY_REMEMBER_ME @"rememberMe"
#define KEY_USER_IMAGE_NAME @"image"
#define KEY_USER_IMAGE_DATA @"imageData"
#define KEY_USER_IS_LOGIN  @"login"
#define KEY_USER_LOGIN_TYPE  @"type"
#define KEY_USER_FBID @"fbid"
#define KEY_USER_TOKEN @"token"
#define KEY_LOGIN_TYPE_EMAIL @"user"
#define KEY_LOGIN_TYPE_FACEBOOK @"fb"
#define KEY_USER_SUBSCRIBE_NEWSLETTER   @"1"
#define KEY_USER_NOT_SUBSCRIBE_NEWSLETTER   @"0"
//Methods
#define METHOD_SIGN_UP @"adduser"
#define METHOD_SIGN_IN @"signIn"
#define METHOD_UESR_EXIST @"userExits"
#define METHOD_EMAIL_EXIST @"emailExits"
///Resposne Handlers
#define RESPONSE_DATA_KEY @"data"
#define RESPONSE_MESSAGE_KEY @"message"
#define RESPONSE_STATUS_KEY @"status"
#define RESPONSE_NO_DATA_ERROR @"Some problem in getting Data."

//Define Managers
#define SERVER_MANAGER      [AFNetworkingHandler shareManager]
#define USER_MODEL_MANAGER  [UserModel shareManager]
#define UTILITY_MANAGER     [UtilityClass sharedMyManager]
#define APPMENU_MANAGER     [AppMenuManager sharedMyManager]
//Default Response Messages
#define MSG_ALERT_TITLE                          @"Mreenal"
#define MSG_CANCEL_BTN_TITLE                     @"OK"
#define MSG_FORGOTPASSWORD_SUCCESSFULL_MSG       @"Password sent to your Email!"
#define MSG_WRONG_PASSWORD_MSG                   @"Password you entered is all wrong."
#define MSG_INCORRECT_EMAIL_MSG                  @"Please enter a valid Email."
#define MSG_INCORRECT_NAME_MSG                   @"Please enter a valid username."
#define MSG_INCORRECT_ABOUT_MSG                  @"Please enter some description regarding yourself."
#define MSG_INCORRECT_NUMBER_MSG                 @"That aint even a real number."
#define MSG_INCORRECT_PROFILE_IMAGE_MSG          @"Please select your profile image."
#define MSG_EXIST_EMAIL_MSG                      @"That Email already has an account!"
#define MSG_EXIST_NAME_MSG                       @"That Name already has an account!"
#define MSG_INVALID_PASSWORD_MSG                 @"Password must be 6 to 12 characters."
#define MSG_INVALID_EMAIL_MSG                    @"Please use a valid Email address."
#define MSG_WRONG_CODE_MSG                       @"Invalid Code! Try again please."
#define MSG_ERROR_INTERNET                       @"There seems to be a connection Error.Please check your internet and try again."
#define MSG_LOGOUT_MSG                           @"Are you sure you want to logout?"
#define MSG_PASSWORD_EMPTYFIELDS_MSG             @"Please enter your old and new password to continue."
#define MSG_PASSWORD_NOT_MATCHED                 @"Sorry, your passwords don’t match. Please retry."
#define MSG_CURRENT_WRONG_PASSWORD_MSG           @"Current password you entered is all wrong."
#define MSG_PRO_ACCOUT_CONFIG_MSG                @"Congratulations! Your Certified account has been configured successfully."
#define MSG_ACCOUNT_DELETE_MSG                   @"Your account has been deleted.Please Sign up again!"
#define MSG_USER_ACCOUNT_DELETE_MSG              @"This user account has been deleted."
#define MSG_RETRY_LATER_MSG                      @"Please try registering after an hour. Thanks!"
#define MSG_EMAIL_ERROR_MSG                      @"You can't Email right now, make sure your device has an internet connection and you have at least one Email account setup."
#define MSG_EMAIL_FAIL_MSG                       @"Seems your connection isn't working.Email failed."



// Date Formate

#define DATE_FORMATE    @"MM/dd/yyyy"



//PickerView Titles
#define DATE_TITLE      @"D.O.B"
#define HEGHT_TITLE     @"Height"
#define GENDER_TITLE    @"Gender"
#define HEGHT_TITLE     @"Height"
#define WAIST_TITLE     @"Waist"
#define SHOULDERS_TITLE @"Shoulders"
#define ARMS_TITLE      @"Arms"
#define LEGS_TITLE      @"Legs"
#define SHOEZ_TITLE     @"Shoes"
//defination of UIViewControllers Identifier
#define ID_LOGIN_VC                @"LoginVC"
#define ID_SIGNUP_VC               @"SignUpVC"
#define ID_SIGNUP_MORE_VC          @"SignUpVCMore"
#define ID_HOME_VC                 @"HomeVC"
#define ID_DressDetail_Popup_VC    @"DressDetailVC" 
#define ID_TRYON_VC                @"TryOnVC"
#define ID_PAYEMENT_VC             @"payementVC"
#define ID_PHOTOGALLERY_VC         @"galleryPhoto"
#define ID_LEFT_MENU_VC            @"LeftMenuVC"
#define ID_FORGOT_PASSWORD_VC      @"ForgotPasswordVC"
#define ID_ACTION_SHEET_VC         @"ActionSheet"
#define ID_TERMS_CONDITIONS_VC     @"TermsAndConditionsVC"

//storboard identifier

#define ID_MAIN_STORY_BOARD    @"Main"
//Font Name

#define OPEN_SANS_BOLD          @"OpenSans-Bold"
#define OPEN_SANS_MEDIUM        @"OpenSans-Semibold"
#define OPEN_SANS               @"OpenSans-Regular"

//Login tags

#define SPINER_TAG                  1337
#define TAG_USER_NAME               100
#define TAG_PASSWORD                102
#define PICKER_VIEW_TOOL_BAR_HEIGHT 44
#define USERNAME_MAX_LENGTH         20
#define PASSWORD_MAX_LENGTH         15
//SignUp Tags

#define TAG_FNAME_SIGNUP           200
#define TAG_LNAME_SIGNUP           201
#define TAG_USERNAME_SIGNUP        202
#define TAG_PASSWORD_SIGNUP        203
#define TAG_EMAIL_SIGNUP           204
#define TAG_CONFIRM_EMAIL_SIGNUP   205
#define TAG_PHONE_NUMBER           212
#endif /* Constants_h */

//Server response codes
typedef enum {
    kBadRequest = 400,  //Bad Request The request cannot be fulfilled due to bad syntax
    kAccepted = 202, // 2: 202 Accepted
    kNoContent = 204, //3: 204 No Content
    kNotAcceptable = 406, //    4: 406 Not Acceptable
    kInternalServerError = 500, //    5: 500 Internal Server Error
    kBadGateway = 502,//    6: 502 Bad Gateway
    kHTTPVersionNotSupported = 505, //    7 : 505 HTTP Version Not Supported
    kCreated = 201,//    8: 201 Created
    kOtherSource = 401,//    9: 401 The request has been successfully processed, but is returning information that may be from another source
    kSuccess = 200, //   10:200  The request is OK (this is the standard response for successful HTTP requests)
    kNoRecordForSocialId = 203   // message = "First time facebook signIn.";
} kServerResponseState;

// UIPickerView enums

typedef enum {
    
    kDatePicker     = 1,
    kGenderPicker   = 2,
    kHeightPicker   = 3,
    kWaistPicker    = 4,
    kShoulderPicker = 5,
    kArmsPicker     = 6,
    kLegsPicker     = 7,
    kShoePicker     = 8
    
}   kPickerType;

typedef enum {
    
    kTypeCoats      = 0,
    kTypeDresses    = 1,
    kTypeEvenings   = 2,
    kTypeJackets    = 3,
    kTypeJeans      = 4,
    kTypeJumpSuits  = 5,
    kTypeNighty     = 6,
    kTypeSkirts     = 7,
    kTypeSweaters   = 8,
    kTypeSwimWear   = 9,
    kTypeTops       = 10
    
}   kTypeDressSelection;

typedef enum {
    
    kOptionBySeason               = 0,
    kOptionBrands                 = 1,
    kOptionDesignerBrands         = 2,
    kOptionType                   = 3,
    kOptionColor                  = 4,
    kOptionGallery                = 5,
    kOptionListByOccasion         = 6,
    kOptionListByMood             = 7,
    kOptionAskFashionExpert       = 8,
    kOptionSetting                = 9,
    kOptionShare                  = 10,
    kOptionLogout                 = 11
    
}   kOptionLeftMenu;



