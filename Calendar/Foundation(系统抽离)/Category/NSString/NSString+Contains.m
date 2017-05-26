//
//  NSString+Contains.m
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/21.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "NSString+Contains.h"

@implementation NSString (Contains)

- (BOOL)contains:(NSString *)subString
{
    if ([self rangeOfString:subString].location == NSNotFound)
        return NO;
    return YES;
}

+ (BOOL)completeString:(NSString *)cString contains:(NSString *)subString
{
    return [cString contains:subString];
}

@end
