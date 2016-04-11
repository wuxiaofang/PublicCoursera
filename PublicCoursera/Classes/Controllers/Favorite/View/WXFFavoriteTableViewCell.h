//
//  WXFFavoriteTableViewCell.h
//  PublicCoursera
//
//  Created by yongche_w on 16/4/10.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WXFCourses;

typedef void(^CancelFavoriteBlock)(WXFCourses* courses);

@interface WXFFavoriteTableViewCell : UITableViewCell

- (void)reloadDataWithCourses:(WXFCourses*)courses;

@property (nonatomic, copy) CancelFavoriteBlock cancelFavoriteBlock;

@end
