//
//  NSString+Date.h
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/16.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Date)

/**
 根据时间格式转化字符串为Date对象
 Note: 设定时间格式,要注意跟dateStr匹配，否则日期将无效
 */
- (NSDate *)convertToDateWithFormatter:(NSString *)fmt;
+ (NSDate *)convertString:(NSString *)dateStr toDateWithFormatter:(NSString *)fmt;

/**
 根据日期格式将时间字符串转化为时间戳
 Note: 设定时间格式,要注意跟dateStr匹配，否则日期将无效
 */
- (NSTimeInterval)timestampWithFormatter:(NSString *)fmt;
+ (NSTimeInterval)timestampWithDateString:(NSString *)dateStr forFormatter:(NSString *)fmt;

@end
