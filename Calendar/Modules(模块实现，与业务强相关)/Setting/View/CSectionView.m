//
//  CSectionView.m
//  Calendar
//
//  Created by xiangyuxi on 2017/6/5.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "CSectionView.h"

@interface CSectionView ()

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UIImageView *userSexImageView;
@property (weak, nonatomic) IBOutlet UILabel *userWorkLabel;
@property (weak, nonatomic) IBOutlet UILabel *userAgeLabel;

@end

@implementation CSectionView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headerImageView.clipsToBounds = YES;
    self.headerImageView.cornerRadius = kScrWidth * 164 / 375 / 4;
}

@end
