//
//  WXFCourseraListHandler.m
//  PublicCoursera
//
//  Created by yongche_w on 16/4/9.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFCourseraListHandler.h"
#import "WXFHttpClient.h"

#define kPageNumber     10

@interface WXFCourseraListHandler()

@property (nonatomic, strong, readwrite) NSMutableArray* courseraList;

@end

@implementation WXFCourseraListHandler

- (NSMutableArray*)courseraList
{
    if(_courseraList == nil){
        _courseraList = [NSMutableArray arrayWithCapacity:10];
    }
    return _courseraList;
}

- (void)getCourseraList:(void(^)(BOOL isSuccess))completeBlock
                refresh:(BOOL)refresh
{
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [parameters setObject:[NSString stringWithFormat:@"%d",kPageNumber] forKey:@"limit"];
    if(refresh){
        [parameters setObject:@"0" forKey:@"start"];
    }else{
        [parameters setObject:[NSString stringWithFormat:@"%ld",self.courseraList.count] forKey:@"start"];
    }

    NSString* includes = @"instructorIds,partnerIds";
    NSString* fields = @"primaryLanguages,photoUrl,startDate,description,previewLink,instructorIds,partnerIds,partners.v1(id,name,shortName,description,banner,primaryColor,logo,squareLogo,rectangularLogo),workload";
    [parameters setObject:includes forKey:@"includes"];
    [parameters setObject:fields forKey:@"fields"];
    [[WXFHttpClient shareInstance] getData:@"/api/courses.v1"
                                parameters:parameters
                                  callBack:^(WXFParser *parser) {
                                      NSLog(@"%@",parser.responseDictionary);
                                      if(parser.statusCode == 200){
                                          [self parseCourseraData:parser.responseDictionary refresh:refresh];
                                          if(completeBlock){
                                              completeBlock(YES);
                                          }
                                      }
    }];
}

- (void)parseCourseraData:(NSDictionary*)dic refresh:(BOOL)refresh
{
    NSArray* elements = [dic arraySafeForKey:@"elements"];
    NSDictionary* linked = [dic dictionarySafeForKey:@"linked"];
    NSArray* instructors_v1 = [linked arraySafeForKey:@"instructors.v1"];
    NSArray* partners_v1 = [linked arraySafeForKey:@"partners.v1"];
    NSDictionary* paging = [dic dictionarySafeForKey:@"paging"];
    self.totalCoursera = [paging intSafeForKey:@"total"];
   
    
    if(elements.count > 0){
        if(refresh){
            [self.courseraList removeAllObjects];
        }
        for(NSInteger i = 0; i < elements.count; i++){
            WXFCourses* courses = [[WXFCourses alloc] init];
            [courses parseResponseDictionary:[elements objectAtIndex:i]
                              instructors_v1:instructors_v1
                                 partners_v1:partners_v1];
            [self.courseraList addObject:courses];
        }
    }
}

@end
