//
//  UIButton+ImgTitleEdge.h
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/20.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GFButtonITStyle) {
    GFButtonITStyleTop,     // image在上，label在下
    GFButtonITStyleleLeft,  // image在左，label在右
    GFButtonITStyleBottom,  // image在下，label在上
    GFButtonITStyleRight    // image在右，label在左
};

@interface UIButton (ImgTitleEdge)

/**
 在设置时注意是imageView，而不是backgroundImageView
 */
@property (nonatomic, assign) GFButtonITStyle itStyle;

/**
 标题和图片的间距
 */
@property (nonatomic, assign) IBInspectable CGFloat itSpacing;

@end
