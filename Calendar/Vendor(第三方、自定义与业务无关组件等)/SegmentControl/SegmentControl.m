//
//  SegmentControl.m
//  Calendar
//
//  Created by xiangyuxi on 2017/5/29.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "SegmentControl.h"
#import "UIView+Shadow.h"
#import "SCHader.h"

#pragma mark ----------------------------- SliderView -----------------------------

@interface SliderView : UIView

@property (strong, nonatomic) UIView *sliderMaskView;

@property (assign, nonatomic) CGFloat conerRadius;

@end

@implementation SliderView

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.sliderMaskView.frame = frame;
}

- (void)setConerRadius:(CGFloat)conerRadius {
    self.layer.cornerRadius =
    self.sliderMaskView.layer.cornerRadius = conerRadius;
}

- (void)setCenter:(CGPoint)center {
    [super setCenter:center];
    self.sliderMaskView.center = center;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.sliderMaskView = [UIView new];
    self.layer.masksToBounds = YES;
    self.sliderMaskView.backgroundColor = [UIColor blackColor];
    [self.sliderMaskView addShadowWithColor:[UIColor blackColor]];
}

@end

#pragma mark ----------------------------- SegmentControl -----------------------------

#define segmentWidth CGRectGetWidth(self.backgroundView.frame)/self.segments.count

@interface SegmentControl ()

@property (strong, nonatomic) UIView *containerView;
@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UIView *selectedContainerView;
@property (strong, nonatomic) SliderView *sliderView;
@property (strong, nonatomic) NSArray *segments;
@property (assign, nonatomic) CGFloat correction;
@end

@implementation SegmentControl

#pragma mark - Properties

- (void)setDefaultTextColor:(UIColor *)defaultTextColor {
    _defaultTextColor = defaultTextColor;
    if (!_defaultTextColor) {
        _defaultTextColor = DefaultTextColor;
    }
    [self updateLabelsColor:defaultTextColor selected:NO];
}

- (void)setHighlightTextColor:(UIColor *)highlightTextColor {
    _highlightTextColor = highlightTextColor;
    if (!_highlightTextColor) {
        _highlightTextColor = HighlightTextColor;
    }
    [self updateLabelsColor:highlightTextColor selected:YES];
}

- (void)setSegmentsBackgroundColor:(UIColor *)segmentsBackgroundColor {
    _segmentsBackgroundColor = segmentsBackgroundColor;
    if (!_segmentsBackgroundColor) {
        _segmentsBackgroundColor = SegmentedControlBackgroundColor;
    }
    self.backgroundView.backgroundColor = segmentsBackgroundColor;
}

- (void)setSliderBackgroundColor:(UIColor *)sliderBackgroundColor {
    _sliderBackgroundColor = sliderBackgroundColor;
    if (!_sliderBackgroundColor) {
        _sliderBackgroundColor = SliderColor;
    }
    if (!_isSliderShadowHidden) {
        [self.selectedContainerView addShadowWithColor:sliderBackgroundColor];
    }
}

- (void)setFont:(UIFont *)font {
    _font = font;
    [self updateLabelsFont:font];
}

- (void)setIsSliderShadowHidden:(BOOL)isSliderShadowHidden {
    _isSliderShadowHidden = isSliderShadowHidden;
    [self updateShadoWithColor:self.sliderBackgroundColor hidden:isSliderShadowHidden];
}

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark - Setup

- (void)setup {
    
    self.containerView = [UIView new];
    self.backgroundView = [UIView new];
    self.selectedContainerView = [UIView new];
    self.sliderView = [[SliderView alloc] init];
    
    self.sliderView.sliderMaskView.layer.shadowRadius = CGRectGetHeight(self.bounds)/2;
    
    [self addSubview:self.containerView];
    [self.containerView addSubview:self.backgroundView];
    [self.containerView addSubview:self.selectedContainerView];
    [self.containerView addSubview:self.sliderView];
    
    self.selectedContainerView.layer.mask = self.sliderView.sliderMaskView.layer;
    [self addTapGesture];
    [self addDragGesture];
    
    self.font = [UIFont systemFontOfSize:15];
    self.isSliderShadowHidden = YES;
    self.defaultTextColor = DefaultTextColor;
    self.highlightTextColor = HighlightTextColor;
    self.segmentsBackgroundColor = SegmentedControlBackgroundColor;
    self.sliderBackgroundColor = SliderColor;
}

- (void)configureViews {
    
    CGFloat height = 30;
    CGFloat topBottomMargin = 5;
    CGFloat leadingTrailingMargin = 10;
    self.containerView.frame = CGRectMake(leadingTrailingMargin, topBottomMargin, self.bounds.size.width-leadingTrailingMargin*2, height);
    CGRect frame = self.containerView.bounds;
    self.backgroundView.frame = frame;
    self.selectedContainerView.frame = frame;
    self.sliderView.frame = CGRectMake(0, 0, segmentWidth, CGRectGetHeight(self.backgroundView.frame));

    CGFloat cornerRadius = CGRectGetHeight(self.backgroundView.frame)/2;
    self.backgroundView.layer.cornerRadius =
    self.selectedContainerView.layer.cornerRadius =
    self.sliderView.cornerRadius = cornerRadius;
    
    self.backgroundColor = [UIColor clearColor];
    self.backgroundView.backgroundColor = self.segmentsBackgroundColor;
    self.selectedContainerView.backgroundColor = self.sliderBackgroundColor;
    
    if (!self.isSliderShadowHidden) {
        [self.selectedContainerView addShadowWithColor:self.sliderBackgroundColor];
    }
}

- (void)setupAutoresizingMasks {
    self.containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.selectedContainerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.sliderView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
}

- (void)updateShadoWithColor:(UIColor* )color hidden:(BOOL)flag {
    if (flag) {
        [self.selectedContainerView removeShadow];
        [self.sliderView.sliderMaskView removeShadow];
    }else {
        [self.selectedContainerView addShadowWithColor:self.sliderBackgroundColor];
        [self.sliderView.sliderMaskView addShadowWithColor:[UIColor blackColor]];
    }
}

#pragma mark - Public

- (void)setSegmentItems:(NSArray *)segments {
    self.segments = segments;
    [self configureViews];
    
    [self clearLabels];
    for (int i = 0; i < self.segments.count; ++ i) {
        UILabel *baseLabel = [self createLabel:self.segments[i] index:i selected:NO];
        UILabel *selectedLabel = [self createLabel:self.segments[i] index:i selected:YES];
        
        [self.backgroundView addSubview:baseLabel];
        [self.selectedContainerView addSubview:selectedLabel];
    }
    
    [self setupAutoresizingMasks];
}

#pragma mark - Private
#pragma mark - Labels

- (void)clearLabels {
    for (UIView *view in self.selectedContainerView.subviews) {
        [view removeFromSuperview];
    }
    for (UIView *view in self.backgroundView.subviews) {
        [view removeFromSuperview];
    }
}

- (UILabel *)createLabel:(NSString *)text index:(NSInteger)index selected:(BOOL)flag {
    CGRect rect = CGRectMake(index * segmentWidth, 0, segmentWidth, CGRectGetHeight(self.backgroundView.frame));
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.text = text;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = flag ? self.highlightTextColor : self.defaultTextColor;
    label.font = self.font;
    label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    return label;
}

- (void)updateLabelsColor:(UIColor *)color selected:(BOOL)flag {
    UIView *containerView = flag ? self.selectedContainerView : self.backgroundView;
    for (UILabel *label in containerView.subviews) {
        if ([label isKindOfClass:[UILabel class]]) {
            label.textColor = color;
        }
    }
}

- (void)updateLabelsFont:(UIFont *)font {
    for (UILabel *label in self.selectedContainerView.subviews) {
        if ([label isKindOfClass:[UILabel class]]) {
            label.font = font;
        }
    }
    for (UILabel *label in self.backgroundView.subviews) {
        if ([label isKindOfClass:[UILabel class]]) {
            label.font = font;
        }
    }
}

#pragma mark - Tap gestures

- (void)addTapGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
    [self addGestureRecognizer:tap];
}

- (void)addDragGesture {
    UIPanGestureRecognizer *drag = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
    [self.sliderView addGestureRecognizer:drag];
}

- (void)didTap:(UITapGestureRecognizer *)tapGesture {
    [self moveToNearestPointBasedOn:tapGesture velocity:CGPointZero];
}

- (void)didPan:(UIPanGestureRecognizer *)panGesture {
    switch (panGesture.state) {
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
            [self moveToNearestPointBasedOn:panGesture velocity:[panGesture velocityInView:self.sliderView]];
            break;
        case UIGestureRecognizerStateBegan:
            
            self.correction = [panGesture locationInView:self.sliderView].x - CGRectGetWidth(self.sliderView.frame)/2;
            break;
        case UIGestureRecognizerStateChanged: {
            CGPoint location = [panGesture locationInView:self];
            self.sliderView.center = CGPointMake(location.x - self.correction, self.sliderView.center.y);
        }
            break;
        case UIGestureRecognizerStatePossible:
        default:
            break;
    }
}

#pragma mark - Slider position

- (void)moveToNearestPointBasedOn:(UIGestureRecognizer *)gesture velocity:(CGPoint)velocity {
    CGPoint location = [gesture locationInView:self];
    if (!CGPointEqualToPoint(velocity, CGPointZero)) {
        CGFloat offset = velocity.x / 12;
        location.x += offset;
    }
    NSInteger index = [self segmentIndex:location];
    [self moveToIndex:index];
    if (self.delegate) {
        [self.delegate segmentControl:self didSelected:index];
    }
}

- (NSInteger)segmentIndex:(CGPoint)point {
    NSInteger index = point.x / CGRectGetWidth(self.sliderView.frame);
    if (index < 0) { index = 0; }
    if (index > self.segments.count - 1) { index = self.segments.count - 1; }
    return index;
}

- (void)moveToIndex:(NSInteger)index {
    CGFloat correctOffset = [self centerAtIndex:index];
    [self animateToPosition:correctOffset];
//    selectedSegmentIndex = index
}

- (CGFloat)centerAtIndex:(NSInteger)index {
    CGFloat xOffset = (index + 0.5) * CGRectGetWidth(self.sliderView.frame);
    return xOffset;
}

- (void)animateToPosition:(CGFloat)position {
    [UIView animateWithDuration:0.2 animations:^{
        self.sliderView.center = CGPointMake(position, self.sliderView.center.y);
    }];
}

@end
