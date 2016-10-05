//
//  UserModel.m
//  Mreenal
//
//  Created by Xpired on 3/21/16.
//  Copyright © 2016 Xpired. All rights reserved.
//

#import "UserModel.h"
#import "Constants.h"
@implementation UserModel

+ (UserModel *)shareManager
{
    static UserModel *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
        
        
    });
    return sharedMyManager;
}

- (void)populateUserModel :(NSDictionary *)userInfo
{
    
    _userId             = [userInfo valueForKey:KEY_USER_ID];
    _fname              = [userInfo valueForKey:KEY_USER_FNAME];
    _lname              = [userInfo valueForKey:KEY_USER_LNAME];
    _gender             = [userInfo valueForKey:KEY_USER_GENDER];
    _dob                = [userInfo valueForKey:KEY_USER_DOB];
    _phone              = [userInfo valueForKey:KEY_USER_PHONE];
    _height             = [userInfo valueForKey:KEY_USER_HEIGHT];
    _waist              = [userInfo valueForKey:KEY_USER_WAIST];
    _shoulders          = [userInfo valueForKey:KEY_USER_SHOULDERS];
    _arms               = [userInfo valueForKey:KEY_USER_ARMS];
    _legs               = [userInfo valueForKey:KEY_USER_LEGS];
    _shoSize            = [userInfo valueForKey:KEY_USER_SHO_SIZE];
    _email              = [userInfo valueForKey:KEY_USER_EMAIL];
    _username           = [userInfo valueForKey:KEY_USERNAME];
    _password           = [userInfo valueForKey:KEY_USER_PASSWORD];
    _imageUrl           = [SERVER_DP_URL stringByAppendingString:[NSString stringWithFormat:@"%@",[userInfo valueForKey:KEY_USER_IMAGE_NAME]]];
    _loginType          = [userInfo valueForKey:KEY_USER_LOGIN_TYPE];
    _fbId               = [userInfo valueForKey:KEY_USER_FBID];
    _fbToken            = [userInfo valueForKey:KEY_USER_TOKEN];
    _enabelNewsLetter   = [[userInfo valueForKey:KEY_USER_NEWSLETTER] boolValue];

}
@end
