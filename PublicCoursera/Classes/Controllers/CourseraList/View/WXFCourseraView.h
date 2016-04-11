//
//  WXFCourseraView.h
//  PublicCoursera
//
//  Created by yongche_w on 16/4/10.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WXFCourses;

@interface WXFCourseraView : UIView

- (void)reloadDataWithCourses:(WXFCourses*)courses;

@end
