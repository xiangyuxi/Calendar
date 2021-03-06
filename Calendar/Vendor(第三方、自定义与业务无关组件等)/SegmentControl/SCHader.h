//
//  SCHader.h
//  Calendar
//
//  Created by xiangyuxi on 2017/5/29.
//  Copyright © 2017年 xyx. All rights reserved.
//

#ifndef SCHader_h
#define SCHader_h

#import <UIKit/UIKit.h>

#define DefaultTextColor ColorFromRGB(51, 51, 51, 1)
#define HighlightTextColor [UIColor whiteColor]
#define SegmentedControlBackgroundColor ColorFromRGB(237, 242, 247, 0.7)
#define SliderColor ColorFromRGB(21, 128, 226, 1)

CGFloat amount(CGFloat amo, CGFloat alpha) {
    return (1 - alpha) * 255 + alpha * amo;
}

UIColor* ColorFromRGB(CGFloat red, CGFloat green, CGFloat blue, CGFloat alpah) {
    CGFloat r = amount(red,alpah)/255;
    CGFloat g = amount(green,alpah)/255;
    CGFloat b = amount(blue,alpah)/255;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}

#endif /* SCHader_h */
