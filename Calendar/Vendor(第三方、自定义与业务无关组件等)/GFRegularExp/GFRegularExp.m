//
//  GFRegularExp.m
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/21.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "GFRegularExp.h"

@implementation GFRegularExp

+ (BOOL)isCurrectRegularWithRegex:(NSString *)regex validValue:(NSString *)candidate
{
    if (!regex || !candidate)
        return NO;
    
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [test evaluateWithObject:candidate];
}

+ (BOOL)isEmailAddress:(NSString *)candidate
{
    return [self isCurrectRegularWithRegex:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}" validValue:candidate];
}

+ (BOOL)isPassword:(NSString *)candidate
{
    return [self isCurrectRegularWithRegex:@"(^[A-Za-z0-9]{6,20}$)" validValue:candidate];
}

+ (BOOL)isURLAddress:(NSString *)candidate
{
    return [self isCurrectRegularWithRegex:@"http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?" validValue:candidate];
}

+ (BOOL)isTelephoneNumber:(NSString *)candidate
{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    return
    [regextestmobile evaluateWithObject:candidate]   ||
    [regextestphs evaluateWithObject:candidate]      ||
    [regextestct evaluateWithObject:candidate]       ||
    [regextestcu evaluateWithObject:candidate]       ||
    [regextestcm evaluateWithObject:candidate];
}

@end
