//
//  CWeatherCell.h
//  Calendar
//
//  Created by yxiang on 2017/5/5.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CWeatherCellDelegate <NSObject>

@optional
- (void)cweatherCellAddBtnDidTouchupInside:(UIButton *)sender;

@end

@interface CWeatherCell : UITableViewCell

@property (copy, nonatomic) NSDate *date;

@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *lunarLabel;
@property (weak, nonatomic) IBOutlet UILabel *thingLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;
@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) id<CWeatherCellDelegate> delegate;

@end
