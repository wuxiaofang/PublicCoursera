//
//  WXFPartnersDetailTableViewCell.h
//  PublicCoursera
//
//  Created by yongche_w on 16/4/10.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXFCourses.h"
#import "WXFPartners.h"

@interface WXFPartnersDetailTableViewCell : UITableViewCell

- (void)loadCourses:(WXFCourses*)courses;

+ (CGFloat)cellheigthForCoursera:(WXFCourses*)coursera width:(CGFloat)width;

@end


@interface WXFPartnersView : UIView

- (void)reloadPartner:(WXFPartners*)partners;

@end