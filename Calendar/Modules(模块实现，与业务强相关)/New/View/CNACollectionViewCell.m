//
//  CNACollectionViewCell.m
//  Calendar
//
//  Created by xiangyuxi on 2017/5/29.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "CNACollectionViewCell.h"

@implementation CNACollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.clipsToBounds =
    self.clipsToBounds =
    self.contentView.layer.masksToBounds =
    self.layer.masksToBounds = NO;
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.layer.cornerRadius = 4.f;
    self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.layer.shadowOpacity = 0.6;
    self.layer.shadowOffset = CGSizeMake(0, 7);
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    if (_isSelected) {
        self.backgroundColor = [UIColor colorWithHex:0x2A00FD];
        self.titleLabel.textColor = [UIColor whiteColor];
    }else {
        self.backgroundColor = [UIColor whiteColor];
        self.titleLabel.textColor = [UIColor colorWithHex:0x33333];
    }
}

@end
