//
//  WXFPartners.m
//  PublicCoursera
//
//  Created by yongche_w on 16/4/9.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFPartners.h"

@implementation WXFPartners

- (void)parseDataFromDic:(NSDictionary*)dic
{
//    description = "The University of Pennsylvania (commonly referred to as Penn) is a private university, located in Philadelphia, Pennsylvania, United States. A member of the Ivy League, Penn is the fourth-oldest institution of higher education in the United States, and considers itself to be the first university in the United States with both undergraduate and graduate studies. ";
//    id = 6;
//    logo = "https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/https://coursera-university-assets.s3.amazonaws.com/7c/5d03cbe2cb87974be7f83cc1080af8/logo-penn-front.png";
//    name = "University of Pennsylvania";
//    primaryColor = "#0000FF";
//    rectangularLogo = "https://coursera-university-assets.s3.amazonaws.com/14/c965e1f5cf9ead221ad770bd907f3a/Penn-logo.svg";
//    shortName = penn;
//    squareLogo = "https://coursera-university-assets.s3.amazonaws.com/5e/4003d6fe94ae4089d5daf13129a515/penn-logo.png";
    self.c_id = [dic stringSafeForKey:@"id"];
    self.c_description = [dic stringSafeForKey:@"description"];
    self.logo = [dic stringSafeForKey:@"logo"];
    self.name = [dic stringSafeForKey:@"name"];
    self.rectangularLogo = [dic stringSafeForKey:@"rectangularLogo"];
    self.shortName = [dic stringSafeForKey:@"shortName"];
    self.squareLogo = [dic stringSafeForKey:@"squareLogo"];

}
@end
