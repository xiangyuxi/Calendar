//
//  CDatePickerView.h
//  Calendar
//
//  Created by yxiang on 2017/5/26.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CDatePickerType) {
    CDatePickerTypeTime,
    CDatePickerTypeDate
};

@interface CDatePickerView : UIView

+ (instancetype)loadInstanceFromNibWithSelectedBlock:(void (^) (NSDate *))block;

@property (assign, nonatomic) CDatePickerType type;

- (void)showDatePickerView;

- (void)dismissDatePickerView;

@end
