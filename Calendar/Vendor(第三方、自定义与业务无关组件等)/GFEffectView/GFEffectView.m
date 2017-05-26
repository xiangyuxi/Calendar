//
//  GFEffectView.m
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/17.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "GFEffectView.h"

@interface GFEffectView ()

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
@property(strong, nonatomic) UIVisualEffectView *effectView;
#else
@property(strong, nonatomic) UIToolbar *effectBar;
#endif

@end

@implementation GFEffectView

- (instancetype)init
{
    if ([super init])
    {
        self.translucent = YES;
        self.effect = GFEffectViewStyleDefault;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame])
    {
        self.translucent = YES;
        self.effect = GFEffectViewStyleDefault;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if ([super initWithCoder:aDecoder])
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    _effectView.frame = self.bounds;
#else
    _effectBar.frame = self.bounds;
#endif
}

- (void)setTranslucent:(BOOL)translucent
{
    _translucent = translucent;
    if (translucent)
    {
        self.backgroundColor = [UIColor clearColor];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
        [self insertSubview:self.effectView atIndex:0];
#else
        [self insertSubview:self.effectBar atIndex:0];
#endif
    }
    else
    {
        self.backgroundColor = [UIColor whiteColor];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
        [self.effectView removeFromSuperview];
#else
        [self.effectBar removeFromSuperview];
#endif
    }
}

- (void)setEffect:(GFEffectViewStyle)style
{
    if (!_translucent)
    {
#ifdef DEBUG
        NSLog(@"警告⚠️: 当设置`style`时, 请务必保证`translucent`为YES，否则无效。");
#endif
        return;
    }
    _style = style;
    switch (_style) {
        case GFEffectViewStyleLight:
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
            _effectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
#else
            _effectBar.barStyle = UIBarStyleDefault;
#endif
            break;
        default:
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
            _effectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
#else
            _effectBar.barStyle = UIBarStyleBlack;
#endif
            break;
    }
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
- (UIVisualEffectView *)effectView
{
    if (_effectView) return _effectView;
    _effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    _effectView.frame = self.bounds;
    _effectView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    return _effectView;
}
#else
- (UIToolbar *)effectBar
{
    if (_effectBar) return _effectBar;
    _effectBar = [[UIToolbar alloc] initWithFrame:self.bounds];
    for (UIView *view in [_effectBar subviews])
    {
        if ([view isKindOfClass:[UIImageView class]] && [[view subviews] count] == 0)
        {
            [view setHidden:YES];
        }
    }
    _effectBar.barStyle = UIBarStyleDefault;
    _effectBar.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    return _effectBar;
}
#endif

@end
