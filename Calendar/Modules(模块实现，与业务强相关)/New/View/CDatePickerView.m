//
//  CDatePickerView.m
//  Calendar
//
//  Created by yxiang on 2017/5/26.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "CDatePickerView.h"

static CGFloat CDefaultConstraintLayout = 260;

@interface CDatePickerView ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *datePickerBottomConstraintLayout;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (copy, nonatomic) void (^selectedBlock) (NSDate *);
@property (copy, nonatomic) NSDate *date;

@end

@implementation CDatePickerView

+ (instancetype)loadInstanceFromNibWithSelectedBlock:(void (^)(NSDate *))block {
    CDatePickerView *pickerView = [CDatePickerView loadInstanceFromNib];
    pickerView.selectedBlock = block;
    return pickerView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.frame = CGRectMake(0, 0, kScrWidth, kScrHeight);
    self.backgroundColor = [UIColor colorWithHex:0x000000 alpha:0];
    self.datePickerBottomConstraintLayout.constant = -CDefaultConstraintLayout;
    
    self.datePicker.backgroundColor = [UIColor whiteColor];
    self.date = self.datePicker.date;
    if (self.type == CDatePickerTypeTime) {
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
        self.datePicker.locale = locale;
        self.datePicker.datePickerMode = UIDatePickerModeTime;
    }else {
        self.datePicker.datePickerMode = UIDatePickerModeDate;
    }
    [[self.datePicker rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(UIDatePicker *dPicker) {
        self.date = dPicker.date;
    }];
}

- (IBAction)sureAction:(id)sender {
    [self dismissDatePickerView];
    
    if (self.selectedBlock) {
        self.selectedBlock(self.date);
    }
}

- (IBAction)cancleAction:(id)sender {
    [self dismissDatePickerView];
}

#pragma mark - Public

- (void)showDatePickerView {
    [self _showDatePicker];
}

- (void)dismissDatePickerView {
    [self _dismissDatePicker];
}

#pragma mark - Private

- (void)_showDatePicker {
    [kCurWindow addSubview:self];
    POPBasicAnimation *constraintAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayoutConstraintConstant];
    constraintAnimation.toValue = @0;
    constraintAnimation.duration = 0.3;
    constraintAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.datePickerBottomConstraintLayout pop_addAnimation:constraintAnimation forKey:nil];
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor colorWithHex:0x000000 alpha:0.4];
    }];
}

- (void)_dismissDatePicker {
    POPBasicAnimation *constraintAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayoutConstraintConstant];
    constraintAnimation.toValue = @(-CDefaultConstraintLayout);
    constraintAnimation.duration = 0.3;
    constraintAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.datePickerBottomConstraintLayout pop_addAnimation:constraintAnimation forKey:nil];
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor colorWithHex:0x000000 alpha:0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
