//
//  GFTextView.h
//  Calendar
//
//  Created by yxiang on 2017/5/10.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFTextView : UIView

/**
 输入框的上下左右边距，默认为Zero，也就是和GFTextView一样的大小
 */
@property (assign, nonatomic) UIEdgeInsets inputEdgeInsets;

/**
 提示语句，默认为nil
 */
@property (copy, nonatomic) IBInspectable NSString *placeholder;

/**
 字符串，默认为nil
 */
@property (copy, nonatomic) NSString *text;

/**
 字体颜色，默认为黑色
 */
@property (copy, nonatomic) IBInspectable UIColor *textColor;

/**
 字号，默认为15号字
 */
@property (copy, nonatomic) UIFont *font;

/**
 附加属性，包括了placeholder的颜色
 */
@property (copy, nonatomic) NSDictionary *attibutes;

@end
