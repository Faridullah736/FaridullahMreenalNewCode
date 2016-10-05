//
//  NSUserDefaultManager.m
//  Mreenal
//
//  Created by Xpired on 4/4/16.
//  Copyright © 2016 Xpired. All rights reserved.
//

#import "NSUserDefaultManager.h"
#import "Constants.h"

@implementation NSUserDefaultManager

+ (void)setRememberMe :(NSString *)username andPassword:(NSString *)password
{
    [[NSUserDefaults standardUserDefaults] setObject:username   forKey:KEY_USERNAME];
    [[NSUserDefaults standardUserDefaults] setObject:password   forKey:KEY_USER_PASSWORD];
    [[NSUserDefaults standardUserDefaults] setBool:TRUE         forKey:KEY_REMEMBER_ME];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL)isRememberMe
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:KEY_REMEMBER_ME];
}
+ (NSString *)getUsername
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:KEY_USERNAME];
}
+ (NSString *)getPassword
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:KEY_USER_PASSWORD];
}
@end
