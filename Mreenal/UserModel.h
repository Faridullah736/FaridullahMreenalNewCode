//
//  UserModel.h
//  Mreenal
//
//  Created by Xpired on 3/21/16.
//  Copyright © 2016 Xpired. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject


@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *fname;
@property (strong, nonatomic) NSString *lname;
@property (strong, nonatomic) NSString *gender;
@property (strong, nonatomic) NSString *dob;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *height;
@property (strong, nonatomic) NSString *waist;
@property (strong, nonatomic) NSString *shoulders;
@property (strong, nonatomic) NSString *arms;
@property (strong, nonatomic) NSString *legs;
@property (strong, nonatomic) NSString *shoSize;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *imageUrl;
@property (strong, nonatomic) NSString *loginType;
@property (strong, nonatomic) NSString *fbId;
@property (strong, nonatomic) NSString *fbToken;
@property (assign, nonatomic) BOOL enabelNewsLetter;
@property (assign, nonatomic) BOOL userLoginFromFacebook;

+ (UserModel *)shareManager;

- (void)populateUserModel :(NSDictionary *)userInfo;

@end

