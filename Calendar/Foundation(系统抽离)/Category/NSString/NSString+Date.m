//
//  NSString+Date.m
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/16.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "NSString+Date.h"

@implementation NSString (Date)

- (NSDate *)convertToDateWithFormatter:(NSString *)fmt
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.dateFormat = fmt;
    return [dateFormat dateFromString:self];
}
+ (NSDate *)convertString:(NSString *)dateStr toDateWithFormatter:(NSString *)fmt
{
    return [dateStr convertToDateWithFormatter:fmt];
}

- (NSTimeInterval)timestampWithFormatter:(NSString *)fmt
{
    NSDate *date = [self convertToDateWithFormatter:fmt];
    return [date timeIntervalSince1970];
}
+ (NSTimeInterval)timestampWithDateString:(NSString *)dateStr forFormatter:(NSString *)fmt
{
    return [dateStr timestampWithFormatter:fmt];
}

@end
