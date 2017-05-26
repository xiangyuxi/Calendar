//
//  NSString+Length.h
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/25.
//  Copyright © 2017年 xyx. All rights reserved.
//
//  http://blog.csdn.net/mickeyyb_520/article/details/50723533

#import <Foundation/Foundation.h>

@interface NSString (Length)

/**
 中文英文都按1个长度，emoji按2个长度
 */
- (NSUInteger)byteLength;
/**
 中文英文都按1个长度，emoji按4个长度
 */
- (NSUInteger)charLength;

@end
