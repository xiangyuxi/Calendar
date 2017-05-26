//
//  CUnderLineLabel.h
//  Calendar
//
//  Created by yxiang on 2017/4/28.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLabel : UIButton

@property (nonatomic, copy) NSString *text;

@property (nonatomic, copy, readonly) UILabel *label;

@property (nonatomic, copy) NSString *lunarText;

@property (nonatomic, copy, readonly) UILabel *lunarLabel;

/**
 是否是本天，默认为NO
 */
@property (nonatomic, assign) BOOL isCurrentDay;

@property (nonatomic, assign) BOOL isSelected;

/// 当isCurrentDay为NO时才有效
/**
 是否为新年，默认为NO
 */
@property (nonatomic, assign) BOOL isChineseNewYear;

/// 当isCurrentDay、isChineseNewYear同时为NO时才有效
/**
 是否为农历的初一，默认为NO
 */
@property (nonatomic, assign) BOOL isLunarFirstDayInMonth;

@end
