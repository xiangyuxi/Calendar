//
//  CNTitleCell.m
//  Calendar
//
//  Created by yxiang on 2017/5/9.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "CNTitleCell.h"

@interface CNTitleCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation CNTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    RAC(self.titleLabel, text) = [RACObserve(self, model.title) map:^id(NSString *x) {
        if (x.length < 1) {
            self.titleLabel.textColor = [UIColor colorWithHex:0x999999];
            x = @"请填入一个响亮的标题";
        }else {
            self.titleLabel.textColor = [UIColor blackColor];
        }
        return x;
    }];
}

@end
