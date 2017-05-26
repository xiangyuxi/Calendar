//
//  GFTextView.m
//  Calendar
//
//  Created by yxiang on 2017/5/10.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "GFTextView.h"

@interface GFTextView () {
    // 光标起始位置，一般情况，光标位置是不会受到各种情况影响的，所以只需要获取一次
    CGPoint cursorPosition;
}

@property (strong, nonatomic) UITextView *textView;

@property (strong, nonatomic) UILabel *placeholderLabel;

@end

@implementation GFTextView

#pragma mark - 初始化

- (instancetype)init
{
    if ([super init])
    {
        [self initializationUIElements];
        [self initializationInterfaceProperties];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame])
    {
        [self initializationUIElements];
        [self initializationInterfaceProperties];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if ([super initWithCoder:aDecoder])
    {
        [self initializationUIElements];
        [self initializationInterfaceProperties];
    }
    return self;
}

+ (instancetype)new
{
    return [[self alloc] init];
}

#pragma mark - 界面设置

- (void)initializationInterfaceProperties
{
    _inputEdgeInsets = UIEdgeInsetsZero;
    _placeholder = nil;
    _text = nil;
    _textColor = [UIColor blackColor];
    _font = [UIFont systemFontOfSize:15];
}

- (void)initializationUIElements
{
    _textView = [[UITextView alloc] init];
    _textView.backgroundColor = [UIColor clearColor];
    _textView.textColor = [UIColor blackColor];
    _textView.font = [UIFont systemFontOfSize:17];
    [self addSubview:_textView];
    
    cursorPosition = [_textView caretRectForPosition:_textView.selectedTextRange.start].origin;
    
    _placeholderLabel = [[UILabel alloc] init];
    _placeholderLabel.textColor = [UIColor groupTableViewBackgroundColor];
    _placeholderLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_placeholderLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _textView.frame = CGRectMake(_inputEdgeInsets.left, _inputEdgeInsets.top, CGRectGetWidth(self.frame)-_inputEdgeInsets.left-_inputEdgeInsets.right, CGRectGetHeight(self.frame)-_inputEdgeInsets.top-_inputEdgeInsets.bottom);
    _placeholderLabel.frame = CGRectMake(_inputEdgeInsets.left+cursorPosition.x, _inputEdgeInsets.top+cursorPosition.y, CGRectGetWidth(self.frame)-_inputEdgeInsets.left-_inputEdgeInsets.right, 0);
}

#pragma mark - Setter

- (void)setInputEdgeInsets:(UIEdgeInsets)inputEdgeInsets
{
    if (!UIEdgeInsetsEqualToEdgeInsets(_inputEdgeInsets, inputEdgeInsets))
    {
        _inputEdgeInsets = inputEdgeInsets;
        [self setNeedsDisplay];
    }
}

- (void)setPlaceholder:(NSString *)placeholder
{
    if (![_placeholder isEqualToString:placeholder])
    {
        _placeholder = placeholder;
        _placeholderLabel.text = _placeholder;
    }
}

- (void)setText:(NSString *)text
{
    if (![_text isEqualToString:text])
    {
        _text = text;
        _textView.text = _text;
        _placeholderLabel.hidden = _text.length > 0;
    }
}

- (void)setTextColor:(UIColor *)textColor
{
    if (![_textColor isEqual:textColor])
    {
        _textColor = textColor;
        _textView.textColor = _textColor;
    }
}

- (void)setFont:(UIFont *)font
{
    if (![_font isEqual:font])
    {
        _font = font;
        _placeholderLabel.font =
        _textView.font = _font;
    }
}

@end
