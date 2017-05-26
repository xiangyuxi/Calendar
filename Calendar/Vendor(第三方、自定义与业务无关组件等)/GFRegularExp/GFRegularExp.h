//
//  GFRegularExp.h
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/21.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GFRegularExp : NSObject

/**
 判断candidate是否是regex格式的合法参数。可用于系统未提供的正则验证
 */
+ (BOOL)isCurrectRegularWithRegex:(NSString *)regex validValue:(NSString *)candidate;

/**
 邮箱地址
 */
+ (BOOL)isEmailAddress:(NSString *)candidate;

/**
 6-20位字符串
 */
+ (BOOL)isPassword:(NSString *)candidate;

/**
 合法链接
 */
+ (BOOL)isURLAddress:(NSString *)candidate;

/**
 电话号
 */
+ (BOOL)isTelephoneNumber:(NSString *)candidate;

@end
