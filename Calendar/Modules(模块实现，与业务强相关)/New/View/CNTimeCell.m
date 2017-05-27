//
//  CNTimeCell.m
//  Calendar
//
//  Created by yxiang on 2017/5/9.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "CNTimeCell.h"

@interface CNTimeCell ()

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation CNTimeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    RAC(self.timeLabel, text) = [RACObserve(self, model.date) map:^id(NSDate *value) {
        return [value convertToStringWithFormatter:@"HH:mm"];
    }];
}

@end
