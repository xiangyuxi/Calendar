//
//  NSString+Contains.h
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/21.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Contains)

- (BOOL)contains:(NSString *)subString;
+ (BOOL)completeString:(NSString *)cString contains:(NSString *)subString;

@end
