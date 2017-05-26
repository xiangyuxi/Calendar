//
//  UIView+Layer.h
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/21.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Layer)

@property IBInspectable UIColor *borderColor;
@property IBInspectable CGFloat borderWidth;
@property IBInspectable CGFloat cornerRadius;
@property IBInspectable BOOL masksToBounds;

@end
