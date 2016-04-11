//
//  WXFCourseraTableViewCell.m
//  PublicCoursera
//
//  Created by yongche_w on 16/4/10.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFCourseraTableViewCell.h"
#import "WXFCourseraView.h"

@interface WXFCourseraTableViewCell()

@property (nonatomic, strong) WXFCourseraView* courseraView;

@property (nonatomic, strong) NSIndexPath* indexPath;

@end

@implementation WXFCourseraTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.backgroundColor = [UIColor c_ffffff];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.courseraView = [[WXFCourseraView alloc] init];
        self.courseraView.backgroundColor = [UIColor c_e1e1e1];
        self.courseraView.layer.cornerRadius = 6;
        self.courseraView.layer.masksToBounds = YES;
        self.courseraView.layer.borderColor = [UIColor c_c8c8c8].CGColor;
        self.courseraView.layer.borderWidth = 0.5;
        [self addSubview:self.courseraView];
    }
    return self;
}

- (void)reloadDataWithCourses:(WXFCourses*)courses
                    indexPath:(NSIndexPath*)indexPath
{
    [self.courseraView reloadDataWithCourses:courses];
    self.indexPath = indexPath;
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.courseraView.v_left = 15;
    if(self.indexPath.row == 0){
        self.courseraView.v_top = 20;
        self.courseraView.v_height = self.v_height - 30;
    }else{
        self.courseraView.v_top = 10;
        self.courseraView.v_height = self.v_height - 20;
    }
    
    self.courseraView.v_width = self.v_width - 30;
    
}

@end
