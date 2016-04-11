//
//  WXFCourses.m
//  PublicCoursera
//
//  Created by yongche_w on 16/4/9.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFCourses.h"
#import "WXFPartners.h"

@implementation WXFCourses


//@"primaryLanguages
//,photoUrl,
//startDate
//,description,
//previewLink,
//instructorIds
//,partnerIds,
//partners.v1(id,name,shortName,description,banner,primaryColor,logo,squareLogo,rectangularLogo)
//,workload";

- (void)parseResponseDictionary:(NSDictionary*)response
                 instructors_v1:(NSArray*)instructors_v1
                    partners_v1:(NSArray*)partners_v1
{
    self.c_id = [response stringSafeForKey:@"id"];
    self.courseType = [response stringSafeForKey:@"courseType"];
    self.name = [response stringSafeForKey:@"name"];
    self.photoUrl = [response stringSafeForKey:@"photoUrl"];
    self.slug = [response stringSafeForKey:@"slug"];
    self.workload = [response stringSafeForKey:@"workload"];
    self.startDate = [response intSafeForKey:@"startDate"];
    self.c_description = [response stringSafeForKey:@"description"];
    self.previewLink = [response stringSafeForKey:@"previewLink"];
    
    NSArray* partnerIds = [response arraySafeForKey:@"partnerIds"];
    [self parsePartner:partnerIds partners_v1:partners_v1];
    
}

- (void)parsePartner:(NSArray*)partnerIds partners_v1:(NSArray*)partners_v1
{
    NSMutableString* tempuniversity = [NSMutableString string];
    
    NSMutableArray* array = [NSMutableArray array];
    for(NSString* partnerId in partnerIds){
        for(NSDictionary* dic in partners_v1){
            NSString* p_id = [dic stringSafeForKey:@"id"];
            if([partnerId integerValue] == [p_id integerValue]){
                WXFPartners* partner = [[WXFPartners alloc] init];
                [partner parseDataFromDic:dic];
                [tempuniversity appendString:partner.shortName];
                [array addObject:partner];
                break;
            }
        }
    }
    self.partners = array;
    self.university = tempuniversity;
    
}

@end
