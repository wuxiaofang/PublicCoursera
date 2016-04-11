//
//  UIView+Frame.m
//  WXFCommonModule
//
//  Created by yongche_w on 16/3/26.
//  Copyright © 2016年 yongche. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView(Frame)

- (void)setV_x:(CGFloat)v_x
{
    CGRect frame = self.frame;
    frame.origin.x = v_x;
    self.frame = frame;
}

- (CGFloat)v_x
{
    return self.frame.origin.x;
}

- (void)setV_y:(CGFloat)v_y
{
    CGRect frame = self.frame;
    frame.origin.y = v_y;
    self.frame = frame;
}

- (CGFloat)v_y
{
    return self.frame.origin.y;
}

- (void)setV_width:(CGFloat)v_w
{
    CGRect frame = self.frame;
    frame.size.width = v_w;
    self.frame = frame;
}

- (CGFloat)v_width
{
    return self.frame.size.width;
}

- (void)setV_height:(CGFloat)v_h
{
    CGRect frame = self.frame;
    frame.size.height = v_h;
    self.frame = frame;
}

- (CGFloat)v_height
{
    return self.frame.size.height;
}

- (CGFloat)v_left {
    return self.frame.origin.x;
}

- (void)setV_left:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)v_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setV_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)v_top {
    return self.frame.origin.y;
}

- (void)setV_top:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)v_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setV_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)v_centerX {
    return self.center.x;
}

- (void)setV_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)v_centerY {
    return self.center.y;
}

- (void)setV_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}


@end
