//
//  CMonthView.h
//  Calendar
//
//  Created by yxiang on 2017/5/3.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CMonthView;

@protocol CMonthViewDelegate <NSObject>

@optional
- (void)cmonthView:(CMonthView *)aView didLayoutSubview:(CGRect)rect;
- (void)cmonthView:(CMonthView *)aView didItemSelected:(NSString *)dayString withTouchCount:(NSInteger)count;

@end

@interface CMonthView : UIView

@property (weak, nonatomic) id<CMonthViewDelegate> delegate;

- (void)updateUIElementsWithYear:(NSInteger)year atMonth:(NSInteger)month atDay:(NSInteger)day;

@end
