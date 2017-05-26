//
//  NSString+Length.m
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/25.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "NSString+Length.h"

@implementation NSString (Length)

- (NSUInteger)byteLength
{
    NSUInteger len = self.length;
    NSString *pattern = @"[\u4e00-\u9fa5]";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger numMatch = [regex numberOfMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, len)];
    return len+numMatch;
}

- (NSUInteger)charLength
{
    int strLength = 0;
    char *p = (char *)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i = 0; i < [self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i ++)
    {
        if (*p)
        {
            ++ p;
            ++ strLength;
        }
        else
            ++ p;
    }
    return strLength;
}

@end
