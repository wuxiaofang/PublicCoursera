//
//  WXFCourseraDescTableViewCell.m
//  PublicCoursera
//
//  Created by yongche_w on 16/4/11.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFCourseraDescTableViewCell.h"

#define kLeftPadding   120

@interface WXFCourseraDescTableViewCell()

@property (nonatomic, strong) UILabel* descTagLabel;

@property (nonatomic, strong) UILabel* descLabel;
@property (nonatomic, strong) WXFCourses* courses;

@end

@implementation WXFCourseraDescTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.backgroundColor = [UIColor c_e1e1e1];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)loadCourses:(WXFCourses*)courses
{
    self.courses = courses;

    NSString* desc = [NSString stringWithFormat:@"%@ ",self.courses.c_description];
    CGSize descSize = [desc sizeForFont:[UIFont systemFontOfSize:18.0f] size:CGSizeMake(kScreenWidth - 10 - kLeftPadding, 9999) mode:NSLineBreakByWordWrapping];
    self.descLabel.text = desc;
    self.descLabel.v_width = kScreenWidth - 10 - kLeftPadding;
    self.descLabel.v_height = descSize.height;

    
}

+ (CGFloat)cellheigthForCoursera:(WXFCourses*)coursera width:(CGFloat)width
{
    CGFloat heigth = 0;
    NSString* desc = [NSString stringWithFormat:@"%@ ",coursera.c_description];
    CGSize descSize = [desc sizeForFont:[UIFont systemFontOfSize:18.0f] size:CGSizeMake(width - 10 - kLeftPadding, 9999) mode:NSLineBreakByWordWrapping];
    heigth += descSize.height + 5;

    
    return heigth;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.descTagLabel.v_left = 10;
    self.descTagLabel.v_top =  0;
    self.descTagLabel.v_width = kLeftPadding - 10;
    
    self.descLabel.v_left = self.descTagLabel.v_right;
    self.descLabel.v_top =  0;
    
}

- (UILabel*)descTagLabel
{
    if(_descTagLabel == nil){
        _descTagLabel = [[UILabel alloc] init];
        _descTagLabel.textAlignment = NSTextAlignmentLeft;
        _descTagLabel.textColor = [UIColor c_323232];
        _descTagLabel.font = [UIFont systemFontOfSize:18.0f];
        _descTagLabel.text = @"INTRODUCT:";
        [_descTagLabel sizeToFit];
        _descTagLabel.frame = CGRectIntegral(_descTagLabel.frame);
        [self addSubview:_descTagLabel];
    }
    return _descTagLabel;
}

- (UILabel*)descLabel
{
    if(_descLabel == nil){
        _descLabel = [[UILabel alloc] init];
        _descLabel.textAlignment = NSTextAlignmentLeft;
        _descLabel.textColor = [UIColor c_323232];
        _descLabel.font = [UIFont systemFontOfSize:18.0f];
        _descLabel.numberOfLines = 0;
        _descLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self addSubview:_descLabel];
    }
    return _descLabel;
}

@end
