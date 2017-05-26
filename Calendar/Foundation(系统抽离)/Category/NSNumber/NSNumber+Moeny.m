//
//  NSNumber+Moeny.m
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/24.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "NSNumber+Moeny.h"

@implementation NSNumber (Moeny)

- (NSString *)toMoenyString
{
    return [self.class numberToMoenyString:self];
}

+ (NSString *)numberToMoenyString:(NSNumber *)number
{
    if (!number)
        return nil;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    formatter.numberStyle = kCFNumberFormatterCurrencyStyle;
    NSString *newAmount = [formatter stringFromNumber:number];
    return newAmount;
}

@end
