//
//  WXFPartnersDetailTableViewCell.m
//  PublicCoursera
//
//  Created by yongche_w on 16/4/10.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFPartnersDetailTableViewCell.h"

#define kPartnersViewHeigth    60
#define kLeftPadding   120

@interface WXFPartnersDetailTableViewCell()

@property (nonatomic, strong) UILabel* titleLabel;

@property (nonatomic, strong) NSArray* partnersViews;

@end

@implementation WXFPartnersDetailTableViewCell


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
    
    for(WXFPartnersView* p in self.partnersViews){
        [p removeFromSuperview];
    }
    NSMutableArray* pViews = [NSMutableArray array];
    for(WXFPartners* p in courses.partners){
        WXFPartnersView* partnersView = [[WXFPartnersView alloc] initWithFrame:CGRectMake(0, 0, self.v_width - 30, kPartnersViewHeigth)];
        [partnersView reloadPartner:p];
        [self addSubview:partnersView];
        [pViews addObject:partnersView];
    }
    self.partnersViews = pViews;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.v_left = 10;
    self.titleLabel.v_top = 0;
    self.titleLabel.v_width = kLeftPadding - 10;
    CGFloat top = 0;
    
    for(WXFPartnersView* view in self.partnersViews){
        view.v_top = top;
        view.v_left = self.titleLabel.v_right;
        view.v_width = self.v_width - self.titleLabel.v_right - 10;
        view.v_height = kPartnersViewHeigth;
        top += view.v_height + 5;
        
    }
}

+ (CGFloat)cellheigthForCoursera:(WXFCourses*)coursera width:(CGFloat)width
{
    CGFloat heigth = 0;
    
    if(coursera.partners.count > 0){
        heigth += (coursera.partners.count * (kPartnersViewHeigth + 5));
    }else{
        heigth += 22 + 5;
    }
    
    
    return heigth;
}

- (UILabel*)titleLabel
{
    if(_titleLabel == nil){
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = [UIColor c_323232];
        _titleLabel.font = [UIFont systemFontOfSize:18.0f];
        _titleLabel.text = @"PARTNERS:";
        [_titleLabel sizeToFit];
        _titleLabel.frame = CGRectIntegral(_titleLabel.frame);
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

@end



@interface WXFPartnersView()

@property (nonatomic, strong) UILabel* nameLabel;

@property (nonatomic, strong) UILabel* descLabel;

@property (nonatomic, strong) UIImageView* logoView;

@property (nonatomic, strong) WXFPartners* partners;

@end

@implementation WXFPartnersView : UIView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor c_c8c8c8].CGColor;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.logoView.v_left = 5;
    self.logoView.v_top = 5;
    self.logoView.v_height = self.logoView.v_width = self.v_height - 10;
    
    self.nameLabel.v_left = self.logoView.v_right + 5;
    self.nameLabel.v_top = 5;
    self.nameLabel.v_height = 22;
    self.nameLabel.v_width = self.v_width - self.logoView.v_right - 10;
    
    self.descLabel.v_left = self.logoView.v_right + 5;
    self.descLabel.v_top = self.nameLabel.v_bottom;
    self.descLabel.v_height = (self.v_height - 5 - self.nameLabel.v_height - 2 - 5);
    self.descLabel.v_width = self.v_width - self.logoView.v_right - 10;
    
}

- (void)reloadPartner:(WXFPartners*)partners
{
    self.partners = partners;
    
    NSURL* url = [NSURL URLWithString:self.partners.squareLogo];
    [self.logoView sd_setImageWithURL:url placeholderImage:nil options:SDWebImageLowPriority completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.logoView.image = image;
    }];
    
    self.nameLabel.text = self.partners.name;
    self.descLabel.text = self.partners.c_description;
}

- (UILabel*)nameLabel
{
    if(_nameLabel == nil){
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.textColor = [UIColor c_323232];
        _nameLabel.font = [UIFont systemFontOfSize:18.0f];
        [self addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (UILabel*)descLabel
{
    if(_descLabel == nil){
        _descLabel = [[UILabel alloc] init];
        _descLabel.textAlignment = NSTextAlignmentLeft;
        _descLabel.textColor = [UIColor c_323232];
        _descLabel.font = [UIFont systemFontOfSize:10.0f];
        _descLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _descLabel.numberOfLines = 0;
        [self addSubview:_descLabel];
    }
    return _descLabel;
}

- (UIImageView*)logoView
{
    if(_logoView == nil){
        _logoView = [[UIImageView alloc] init];
        _logoView.backgroundColor = [UIColor c_ffffff];
        _logoView.layer.masksToBounds = YES;
        _logoView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_logoView];
    }
    return _logoView;
}

@end