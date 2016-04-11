//
//  WXFCourseraTableViewCell.h
//  PublicCoursera
//
//  Created by yongche_w on 16/4/10.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WXFCourses;

@interface WXFCourseraTableViewCell : UITableViewCell

- (void)reloadDataWithCourses:(WXFCourses*)courses
                    indexPath:(NSIndexPath*)indexPath;

@end
