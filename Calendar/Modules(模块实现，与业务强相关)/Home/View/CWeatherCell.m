//
//  CWeatherCell.m
//  Calendar
//
//  Created by yxiang on 2017/5/5.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "CWeatherCell.h"

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
    RAC(self.dayLabel,text) = RACObserve(self, cwModel.day);
    RAC(self.lunarLabel,text) = RACObserve(self, cwModel.called);
    RAC(self.thingLabel,text) = RACObserve(self, cwModel.thing);
    RAC(self.weatherLabel,text) = RACObserve(self, cwModel.weather);
    RAC(self.typeLabel,text) = RACObserve(self, cwModel.type);
    RAC(self.weatherImageView,image) = [RACObserve(self, cwModel.imageName) map:^id(NSString *value) {
        return [UIImage imageNamed:value];
    }];
    
    // 事件回调
    @weakify(self)
    [[self.addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        if (self.delegate && [self.delegate respondsToSelector:@selector(cweatherCellAddBtnDidTouchupInside:)])
            [self.delegate cweatherCellAddBtnDidTouchupInside:x];
    }];
    
}

@end
