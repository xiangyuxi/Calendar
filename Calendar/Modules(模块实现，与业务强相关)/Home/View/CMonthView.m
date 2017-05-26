//
//  CMonthView.m
//  Calendar
//
//  Created by yxiang on 2017/5/3.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "CMonthView.h"
#import "CLabel.h"
#import "CTools.h"

@interface CMonthView ()

@property (weak, nonatomic) IBOutlet GFEffectView *contentView;

@property (strong, nonatomic) NSMutableArray *labels;

@end

@implementation CMonthView

- (void)awakeFromNib
{
    [super awakeFromNib];
    if (!_labels)
        _labels = [NSMutableArray arrayWithCapacity:42];
    NSInteger tag = 10;
    for (int i = 0; i < 6; ++ i)
    {
        for (int j = 0; j < 7; ++ j)
        {
            CLabel *label = [[CLabel alloc] init];
            // 点击操作
            [label addTarget:self action:@selector(tabButtonTapped:forEvent:) forControlEvents:UIControlEventTouchDown];
            // 双击操作
            [label addTarget:self action:@selector(repeatBtnTapped:forEvent:) forControlEvents:UIControlEventTouchDownRepeat];
            label.tag = tag;
            [self.contentView addSubview:label];
            [_labels addObject:label];
            ++ tag;
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSInteger index = 0;
    CGFloat startY = 25;
    CGFloat width = (self.gf_w-80)/7;
    CGFloat endY = 0;
    for (int i = 0; i < 6; ++ i)
    {
        for (int j = 0; j < 7; ++ j)
        {
            CLabel *label = self.labels[index];
            label.bounds = CGRectMake(0, 0, width, width);
            label.center = CGPointMake((self.gf_w/14)*(2*j+1), startY+width/2);
            if (label.hidden == NO)
                endY = label.gf_y+label.gf_h+2;
            ++ index;
        }
        startY += 2+width;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cmonthView:didLayoutSubview:)] && self.gf_h != endY)
        [self.delegate cmonthView:self didLayoutSubview:CGRectMake(self.gf_x, self.gf_y, self.gf_w, endY)];
    
    self.gf_h = endY;
}

- (void)tabButtonTapped:(UIButton *)sender forEvent:(UIEvent *)event
{
    [self performSelector:@selector(tabButtonTap:) withObject:sender afterDelay:0.2];
}

- (void)tabButtonTap:(CLabel *)sender
{
    if (sender.isSelected)
        return;
    [self.labels enumerateObjectsUsingBlock:^(CLabel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.isSelected = NO;
    }];
    sender.isSelected = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(cmonthView:didItemSelected:withTouchCount:)])
        [self.delegate cmonthView:self didItemSelected:sender.text withTouchCount:1];
}

- (void)repeatBtnTapped:(CLabel *)sender forEvent:(UIEvent *)event
{
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(tabButtonTap:) object:sender];
    if (self.delegate && [self.delegate respondsToSelector:@selector(cmonthView:didItemSelected:withTouchCount:)])
        [self.delegate cmonthView:self didItemSelected:sender.text withTouchCount:2];
}

- (void)selctedBtnRepeatTapped:(CLabel *)sender
{
}

- (void)updateUIElementsWithYear:(NSInteger)year atMonth:(NSInteger)month atDay:(NSInteger)day
{
    
    NSInteger index = 0;
    NSInteger firstWeek = [[CTools sharedCTools] firstDayisWeekAtYear:year inMonth:month];
    NSInteger tDay = [[CTools sharedCTools] totalDayAtYear:year inMonth:month];
    NSArray *cDay = [[CTools sharedCTools] currentDay];
    NSArray *cFDay = [[CTools sharedCTools] chinaFirstDayAtYear:year inMonth:month];
    NSArray *cCalled = [[CTools sharedCTools] chinaCalledAtYear:year inMonth:month];
    
    for (int i = 0; i < 6; ++ i)
    {
        for (int j = 0; j < 7; ++ j)
        {
            CLabel *label = self.labels[index];
            label.isSelected = NO;
            label.isCurrentDay = NO;
            label.isLunarFirstDayInMonth = NO;
            if (index < firstWeek || index > firstWeek+tDay-1)
                label.hidden = YES;
            else {
                label.hidden = NO;
                label.text = [@(index-firstWeek+1) stringValue];
                label.lunarText = cCalled[index-firstWeek];
            }
            ++ index;
        }
    }
    
    [cFDay enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger i = [obj.allKeys.firstObject integerValue]+firstWeek-1;
        CLabel *label = self.labels[i];
        label.isChineseNewYear = [obj.allValues.firstObject boolValue];
        label.isLunarFirstDayInMonth = YES;
    }];
    
    if ([cDay[0] integerValue] == year && [cDay[1] integerValue] == month)
    {
        NSInteger i = [cDay[2] integerValue]+firstWeek-1;
        CLabel *label = self.labels[i];
        label.isCurrentDay = YES;
    }
    
    CLabel *label = self.labels[day+firstWeek-1];
    label.isSelected = YES;
    
    [self setNeedsLayout];
}

@end
