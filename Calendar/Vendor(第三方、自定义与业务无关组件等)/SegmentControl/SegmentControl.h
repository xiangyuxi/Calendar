//
//  SegmentControl.h
//  Calendar
//
//  Created by xiangyuxi on 2017/5/29.
//  Copyright © 2017年 xyx. All rights reserved.
//

// From: TwicketSegmentedControl

#import <UIKit/UIKit.h>

@class SegmentControl;

@protocol SegmentedControlDelegate <NSObject>

- (void)segmentControl:(SegmentControl *)segment didSelected:(NSInteger)index;

@end

@interface SegmentControl : UIControl

@property (weak, nonatomic) id<SegmentedControlDelegate> delegate;

@property (copy, nonatomic) UIColor *defaultTextColor;

@property (copy, nonatomic) UIColor *highlightTextColor;

@property (copy, nonatomic) UIColor *segmentsBackgroundColor;

@property (copy, nonatomic) UIColor *sliderBackgroundColor;

@property (copy, nonatomic) UIFont *font;

@property (assign, nonatomic)BOOL isSliderShadowHidden;

- (void)setSegmentItems:(NSArray *)segments;

@end
