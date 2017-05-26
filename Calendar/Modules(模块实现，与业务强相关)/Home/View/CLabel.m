//
//  CUnderLineLabel.m
//  Calendar
//
//  Created by yxiang on 2017/4/28.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "CLabel.h"

#define COLOR_NOT_NORMAL [UIColor colorWithHex:0xd81e06]

@interface CLabel ()

@property (nonatomic, copy) CALayer *toCycleLayer;

@property (nonatomic, copy) CALayer *borderCycleLayer;

/**
 下划线
 */
@property (nonatomic, copy) CALayer *underlineLayer;

/**
 下划线高度
 */
@property (nonatomic, assign) CGFloat underlineHeight;

/**
 下划线颜色
 */
@property (nonatomic, copy) UIColor *underlineColor;

@end

@implementation CLabel

@synthesize label = _label;
@synthesize lunarLabel = _lunarLabel;

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.underlineColor = COLOR_NOT_NORMAL;
        self.underlineHeight = 1;
        self.label.textAlignment =
        self.lunarLabel.textAlignment = NSTextAlignmentCenter;
        self.isCurrentDay = NO;
        self.isSelected = NO;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.label.frame = CGRectMake(4, 4, self.gf_w-8, (self.gf_h-8)*2/3);
    self.lunarLabel.frame = CGRectMake(4, self.label.gf_y+self.label.gf_h-4, self.gf_w-8, (self.gf_h-8)/3);
    
    self.underlineLayer.frame = CGRectMake((self.gf_w-self.underlineLayer.bounds.size.width)/2, self.gf_h-self.underlineHeight, self.underlineLayer.bounds.size.width, self.underlineHeight);
    
    self.toCycleLayer.frame = CGRectMake((self.gf_w-self.gf_w)/2+4, (self.gf_h-self.gf_w)/2+4, self.gf_w-8, self.gf_w-8);
    self.toCycleLayer.cornerRadius = CGRectGetWidth(self.toCycleLayer.frame)/2;
    
    self.borderCycleLayer.frame = CGRectMake((self.gf_w-self.gf_w)/2+4, (self.gf_h-self.gf_w)/2+4, self.gf_w-8, self.gf_w-8);
    self.borderCycleLayer.cornerRadius = CGRectGetWidth(self.borderCycleLayer.frame)/2;
}

- (void)setText:(NSString *)text
{
    _text = text;
    self.label.text = text;
    CGFloat width = [text boundingSizeWithFont:self.label.font constrainedToSize:CGSizeZero].width;
    self.underlineLayer.bounds = CGRectMake(0, 0, width, self.underlineLayer.bounds.size.height);
}

- (void)setLunarText:(NSString *)lunarText
{
    _lunarText = lunarText;
    self.lunarLabel.text = lunarText;
}

- (void)setUnderlineHeight:(CGFloat)underlineHeight
{
    _underlineHeight = underlineHeight;
    self.underlineLayer.bounds = CGRectMake(0, 0, self.underlineLayer.bounds.size.width, underlineHeight);
}

- (void)setUnderlineColor:(UIColor *)underlineColor
{
    if (![_underlineColor isEqual:underlineColor])
        self.underlineLayer.backgroundColor = underlineColor.CGColor;
}

- (void)setIsCurrentDay:(BOOL)isCurrentDay
{
    _isCurrentDay = isCurrentDay;
    self.underlineLayer.hidden = YES;
    self.toCycleLayer.hidden = !_isCurrentDay;
    
    self.label.textColor = _isCurrentDay?[UIColor whiteColor]:[UIColor colorWithHex:0x333333];
    self.lunarLabel.textColor = _isCurrentDay?[UIColor whiteColor]:[UIColor colorWithHex:0x999999];
}

- (void)setIsSelected:(BOOL)isSelected
{
    if (_isCurrentDay)
        return;
    _isSelected = isSelected;
    self.borderCycleLayer.hidden = !_isSelected;
}

- (void)setIsChineseNewYear:(BOOL)isChineseNewYear
{
    if (_isCurrentDay)
        return;
    _isChineseNewYear = isChineseNewYear;
    self.underlineLayer.hidden = !isChineseNewYear;
    self.underlineHeight = 2;
}

- (void)setIsLunarFirstDayInMonth:(BOOL)isLunarFirstDayInMonth
{
    if (_isChineseNewYear || _isCurrentDay)
        return;
    _isLunarFirstDayInMonth = isLunarFirstDayInMonth;
    self.underlineLayer.hidden = !isLunarFirstDayInMonth;
    self.underlineHeight = 1;
}

- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont boldSystemFontOfSize:12];
        [self addSubview:_label];
    }
    return _label;
}

- (UILabel *)lunarLabel
{
    if (!_lunarLabel) {
        _lunarLabel = [[UILabel alloc] init];
        _lunarLabel.fontSize = 8;
        [self addSubview:_lunarLabel];
    }
    return _lunarLabel;
}

- (CALayer *)toCycleLayer
{
    if (!_toCycleLayer)
    {
        _toCycleLayer = [CALayer layer];
        _toCycleLayer.backgroundColor = COLOR_NOT_NORMAL.CGColor;
        [self.layer addSublayer:_toCycleLayer];
        _toCycleLayer.zPosition = -2;
    }
    return _toCycleLayer;
}

- (CALayer *)underlineLayer
{
    if (!_underlineLayer)
    {
        _underlineLayer = [CALayer layer];
        [self.layer addSublayer:_underlineLayer];
    }
    return _underlineLayer;
}

- (CALayer *)borderCycleLayer
{
    if (!_borderCycleLayer)
    {
        _borderCycleLayer = [CALayer layer];
        _borderCycleLayer.borderColor = COLOR_NOT_NORMAL.CGColor;
        [self.layer addSublayer:_borderCycleLayer];
        _borderCycleLayer.borderWidth = 2;
    }
    return _borderCycleLayer;
}

@end
