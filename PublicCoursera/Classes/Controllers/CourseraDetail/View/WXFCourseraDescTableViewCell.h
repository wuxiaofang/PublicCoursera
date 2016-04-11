//
//  WXFCourseraDescTableViewCell.h
//  PublicCoursera
//
//  Created by yongche_w on 16/4/11.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXFCourses.h"
@interface WXFCourseraDescTableViewCell : UITableViewCell

- (void)loadCourses:(WXFCourses*)courses;

+ (CGFloat)cellheigthForCoursera:(WXFCourses*)coursera width:(CGFloat)width;

@end
