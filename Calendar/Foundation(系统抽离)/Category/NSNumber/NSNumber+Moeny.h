//
//  NSNumber+Moeny.h
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/24.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (Moeny)

/**
 按照实际金额格式转化number对象，格式为￥12.56
 */
- (NSString *)toMoenyString;
+ (NSString *)numberToMoenyString:(NSNumber *)number;

@end
