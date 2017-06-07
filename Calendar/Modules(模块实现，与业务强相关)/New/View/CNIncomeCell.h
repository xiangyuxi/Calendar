//
//  CNIncomeCell.h
//  Calendar
//
//  Created by xiangyuxi on 2017/6/7.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CNIncomeCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (assign, nonatomic) BOOL isSelected;

@end
