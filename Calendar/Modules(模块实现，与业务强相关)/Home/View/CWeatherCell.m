//
//  CWeatherCell.m
//  Calendar
//
//  Created by yxiang on 2017/5/5.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "CWeatherCell.h"
#import "CTools.h"

@implementation CWeatherCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // 阴影
    self.mainView.cornerRadius =
    self.mainView.layer.shadowRadius = 5.f;
    self.mainView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.mainView.layer.shadowOpacity = 0.5;
    self.mainView.layer.shadowOffset = CGSizeZero;
    
    // 绑定值
    [RACObserve(self, date) subscribeNext:^(NSDate *date) {
        NSString *dateString = [NSDate converDate:date toStringWithFormatter:@"yyyy-MM-dd"];
        NSArray *dateArray = [dateString componentsSeparatedByString:@"-"];
        self.dayLabel.text = [NSString stringWithFormat:@"%@",dateArray[2]];
        self.lunarLabel.text = [[CTools sharedCTools] getCalledAtYear:[dateArray[0] integerValue] inMonth:[dateArray[1] integerValue] inDay:[dateArray[2] integerValue]];
        self.thingLabel.text = @"今日总共盈亏：￥500.00";
        self.weatherLabel.text = @"晴";
        self.typeLabel.text = @"重度污染";
        self.weatherImageView.image = [UIImage imageNamed:weatherTypeString().firstObject];
    }];
    
    // 事件回调
    @weakify(self)
    [[self.addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        if (self.delegate && [self.delegate respondsToSelector:@selector(cweatherCellAddBtnDidTouchupInside:)])
            [self.delegate cweatherCellAddBtnDidTouchupInside:x];
    }];
}

- (NSDate *)date {
    if (!_date) {
        _date = [NSDate date];
    }
    return _date;
}

@end
