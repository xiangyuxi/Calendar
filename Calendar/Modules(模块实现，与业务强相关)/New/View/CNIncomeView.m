//
//  CNIncomeView.m
//  Calendar
//
//  Created by xiangyuxi on 2017/6/6.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "CNIncomeView.h"
#import "YBPopupMenu.h"

@interface CNIncomeView () <YBPopupMenuDelegate>

@property (weak, nonatomic) IBOutlet UIView *moneyInputView;
@property (weak, nonatomic) IBOutlet UIButton *typeButton;
@property (weak, nonatomic) IBOutlet UIImageView *downImageView;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (copy, nonatomic) NSArray *payTypeArray;

@end

@implementation CNIncomeView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.payTypeArray = @[@"现金",@"支付宝",@"微信",@"银行卡"];
    
    self.moneyInputView.layer.shadowRadius =
    self.moneyInputView.cornerRadius = 4.f;
    self.moneyInputView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.moneyInputView.layer.shadowOpacity = 0.6;
    self.moneyInputView.layer.shadowOffset = CGSizeZero;
    
    [[self.typeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *sender) {
        [YBPopupMenu showAtPoint:CGPointMake(sender.center.x+10, CGRectGetMaxY(sender.frame)+20+64)
                          titles:self.payTypeArray
                           icons:self.payTypeArray
                       menuWidth:kScrWidth-20
                        delegate:self];
    }];
}

#pragma mark -------
#pragma mark - YBPopupMenuDelegate

- (void)ybPopupMenuBeganShow {
    [UIView animateWithDuration:0.3 animations:^{
        self.downImageView.transform = CGAffineTransformRotate(self.downImageView.transform, M_PI);
    }];
}

- (void)ybPopupMenuBeganDismiss {
    [UIView animateWithDuration:0.3 animations:^{
        self.downImageView.transform = CGAffineTransformIdentity;
    }];
}

- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu {
    [self.typeButton setImage:[UIImage imageNamed:self.payTypeArray[index]] forState:UIControlStateNormal];
}

- (UITableViewCell *)ybPopupMenuWithTableView:(UITableView *)tableView image:(UIImage *)image title:(NSString *)title {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.imageView.image = image;
    cell.textLabel.text = title;
    return cell;
}

@end
