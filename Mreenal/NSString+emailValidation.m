//
//  NSString+emailValidation.m
//  Xtraplayte
//
//  Created by xain ul abidin on 8/11/15.
//  Copyright (c) 2015 xain. All rights reserved.
//

#import "NSString+emailValidation.h"

@implementation NSString (emailValidation)

-(BOOL)isValidEmail
{
    BOOL stricterFilter = NO; 
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

@end
