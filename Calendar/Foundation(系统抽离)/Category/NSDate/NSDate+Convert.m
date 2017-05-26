//
//  NSDate+Convert.m
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/16.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "NSDate+Convert.h"

@implementation NSDate (Convert)

- (NSString *)convertToStringWithFormatter:(NSString *)fmt
{
    return [self.class converDate:self toStringWithFormatter:fmt];
}
+ (NSString *)converDate:(NSDate *)date toStringWithFormatter:(NSString *)fmt
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = fmt;
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)converToStringWithTimestamp:(NSTimeInterval)timestamp formatter:(NSString *)fmt
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    return [self converDate:date toStringWithFormatter:fmt];
}

@end
