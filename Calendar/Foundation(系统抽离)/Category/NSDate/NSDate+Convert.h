//
//  NSDate+Convert.h
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/16.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Convert)

/**
 根据所需时间格式转化Date对象
 */
- (NSString *)convertToStringWithFormatter:(NSString *)fmt;
+ (NSString *)converDate:(NSDate *)date toStringWithFormatter:(NSString *)fmt;

/**
 根据日期格式将时间戳转化为字符串
 */
+ (NSString *)converToStringWithTimestamp:(NSTimeInterval)timestamp formatter:(NSString *)fmt;

@end
