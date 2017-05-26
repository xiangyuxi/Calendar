//
//  NSString+Size.h
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/16.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (Size)

/**
 根据字体及约束大小计算文本大小
 */
- (CGSize)boundingSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

@end
