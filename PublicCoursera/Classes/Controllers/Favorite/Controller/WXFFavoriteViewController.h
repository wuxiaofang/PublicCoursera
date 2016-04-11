//
//  WXFFavoriteViewController.h
//  PublicCoursera
//
//  Created by yongche_w on 16/4/9.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXFBaseTableViewController.h"

@class WXFCourses;

typedef void(^ShowCourseaDetailBlock)(WXFCourses* coursera);

@interface WXFFavoriteViewController : WXFBaseTableViewController

@property (nonatomic, copy) ShowCourseaDetailBlock showCourseaDetailBlock;

- (void)loadFavoriteData;

@end
