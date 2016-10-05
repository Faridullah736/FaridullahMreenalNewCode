//
//  NSUserDefaultManager.h
//  Mreenal
//
//  Created by Xpired on 4/4/16.
//  Copyright © 2016 Xpired. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaultManager : NSObject


+ (void)setRememberMe :(NSString *)username andPassword:(NSString *)password;
+ (BOOL)isRememberMe;
+ (NSString *)getUsername;
+ (NSString *)getPassword;
@end
