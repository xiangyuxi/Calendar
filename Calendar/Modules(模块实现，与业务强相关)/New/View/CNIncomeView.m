//
//  CNIncomeView.m
//  Calendar
//
//  Created by xiangyuxi on 2017/6/6.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "CNIncomeView.h"
#import "YBPopupMenu.h"
#import "CNIncomeCell.h"
#import "CNAFlowLayout.h"

static NSString * const CNIncomeCellIdentifier = @"CNIncomeCell";

@interface CNIncomeView () <YBPopupMenuDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *moneyInputView;
@property (weak, nonatomic) IBOutlet UIButton *typeButton;
@property (weak, nonatomic) IBOutlet UIImageView *downImageView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) JVFloatLabeledTextView *textView;

@property (copy, nonatomic) NSArray *payTypeArray;
@property (copy, nonatomic) NSArray *payOutCollectionViewImageNames;
@property (assign, nonatomic) NSInteger paySelectedFlag;

@end

@implementation CNIncomeView

#pragma mark - Properties

- (JVFloatLabeledTextView *)textView {
    if (!_textView) {
        _textView = [[JVFloatLabeledTextView alloc] initWithFrame:CGRectMake(10, 185, kScrWidth-20, 120)];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.font = [UIFont fontWithName:@".SFUIText" size:14];
        _textView.placeholder = @"请输入详细描述";
        _textView.floatingLabelTextColor = [UIColor colorWithHex:0x459BFF];
        _textView.floatingLabelFont = [UIFont fontWithName:@".SFUIText" size:11];
        _textView.floatingLabelYPadding = 5;
    }
    return _textView;
}

#pragma mark - Lifecycle

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self addSubview:self.textView];
    
    self.payTypeArray = @[@"现金",@"支付宝",@"微信",@"银行卡"];
    self.payOutCollectionViewImageNames = @[@"餐饮",@"车贷",@"房贷",@"家具",@"交通费用",@"旅游",@"日常开支",@"信用卡还贷",@"娱乐休闲",@"衣服",@"医疗保健",@"运动",@"其他"];
    
    self.collectionView.collectionViewLayout = [[CNAFlowLayout alloc] init];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerNib:[CNIncomeCell loadNib] forCellWithReuseIdentifier:CNIncomeCellIdentifier];
    
    self.moneyInputView.layer.shadowRadius =
    self.moneyInputView.cornerRadius = 4.f;
    self.moneyInputView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.moneyInputView.layer.shadowOpacity = 0.6;
    self.moneyInputView.layer.shadowOffset = CGSizeMake(0, 4);
    
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


#pragma mark - UICollectionViewDataSource
 
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.payOutCollectionViewImageNames.count;
}
 
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CNIncomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CNIncomeCellIdentifier forIndexPath:indexPath];
    NSString *imageName = self.payOutCollectionViewImageNames[indexPath.row];
    BOOL isSelected = NO;
    cell.titleLabel.text = imageName;
    if (indexPath.row == self.paySelectedFlag) {
        imageName = [imageName stringByAppendingString:@"_s"];
        isSelected = YES;
    }
    cell.typeImageView.image = [UIImage imageNamed:imageName];
    cell.isSelected = isSelected;
    return cell;
}

#pragma mark - UICollectionViewDelegate
 
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.paySelectedFlag) {
        return;
    }
    NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:self.paySelectedFlag inSection:0];
    self.paySelectedFlag = indexPath.row;
    [self.collectionView reloadItemsAtIndexPaths:@[lastIndex,indexPath]];
}

@end
