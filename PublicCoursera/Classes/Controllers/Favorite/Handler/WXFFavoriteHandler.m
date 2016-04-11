//
//  WXFFavoriteHandler.m
//  PublicCoursera
//
//  Created by yongche_w on 16/4/10.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFFavoriteHandler.h"


#define kFavoriteKey  @"kFavoriteKey"

@interface WXFFavoriteHandler()

@property (nonatomic, strong, readwrite)NSMutableArray* coursesIds;

@property (nonatomic, strong, readwrite) NSMutableArray* courseraList;

@end

@implementation WXFFavoriteHandler


+(WXFFavoriteHandler*)instance
{
    static WXFFavoriteHandler*  _instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(_instance == nil){
            _instance = [[[self class] alloc] init];
        }
    });
    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if(self){
        self.coursesIds = [NSMutableArray array];
        self.courseraList = [NSMutableArray array];
        [self loadFavoriteDataFromDisk];
    }
    return self;
}

- (void)loadFavoriteDataFromDisk
{
    id object = DefaultValueForKey(kFavoriteKey);
    if(object){
        [self.coursesIds addObjectsFromArray:object];
    }
}

- (void)saveFavoriteDataFromDisk
{
    if(self.coursesIds){
        DefaultSetValueForKey(self.coursesIds, kFavoriteKey);
    }
    
}

- (void)addCoursesToFavoriteList:(NSString*)c_id
{
    if(c_id){
        if(![self isFavorite:c_id]){
            [self.coursesIds addObject:c_id];
            [self saveFavoriteDataFromDisk];
            self.needrefreshFavCourseraList = YES;
        }
        
    }
}

- (void)removeCoursesFromFavoriteList:(NSString*)c_id
{
    if(c_id){
        NSString* removeId = nil;
        for(NSString* fav_c_id in self.coursesIds){
            if([c_id isEqualToString:fav_c_id]){
                removeId = fav_c_id;
                break;
            }
        }
        if(removeId){
            [self.coursesIds removeObject:removeId];
            [self saveFavoriteDataFromDisk];
            self.needrefreshFavCourseraList = YES;
        }
        
    }
}

- (BOOL)isFavorite:(NSString*)c_id
{
    BOOL fav = NO;
    for(NSString* fav_c_id in self.coursesIds){
        if([c_id isEqualToString:fav_c_id]){
            return YES;
        }
    }
    return fav;
}


- (void)getCourseraList:(void(^)(BOOL isSuccess))completeBlock
{
    if(self.coursesIds.count == 0){
        if(completeBlock){
            completeBlock(NO);
        }
        return;
    }
    
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    NSString* ids = [self.coursesIds componentsJoinedByString:@","];
    [parameters setObject:ids forKey:@"ids"];
    NSString* includes = @"instructorIds,partnerIds";
    NSString* fields = @"primaryLanguages,photoUrl,startDate,description,previewLink,instructorIds,partnerIds,partners.v1(id,name,shortName,description,banner,primaryColor,logo,squareLogo,rectangularLogo),workload";
    [parameters setObject:includes forKey:@"includes"];
    [parameters setObject:fields forKey:@"fields"];
    [[WXFHttpClient shareInstance] getData:@"/api/courses.v1"
                                parameters:parameters
                                  callBack:^(WXFParser *parser) {
                                      NSLog(@"%@",parser.responseDictionary);
                                      if(parser.statusCode == 200){
                                          [self parseCourseraData:parser.responseDictionary];
                                          if(completeBlock){
                                              completeBlock(YES);
                                          }
                                      }
                                  }];

}

- (void)parseCourseraData:(NSDictionary*)dic
{
    NSArray* elements = [dic arraySafeForKey:@"elements"];
    NSDictionary* linked = [dic dictionarySafeForKey:@"linked"];
    NSArray* instructors_v1 = [linked arraySafeForKey:@"instructors.v1"];
    NSArray* partners_v1 = [linked arraySafeForKey:@"partners.v1"];
    
    
    if(elements.count > 0){
        [self.courseraList removeAllObjects];
        for(NSInteger i = 0; i < elements.count; i++){
            WXFCourses* courses = [[WXFCourses alloc] init];
            [courses parseResponseDictionary:[elements objectAtIndex:i]
                              instructors_v1:instructors_v1
                                 partners_v1:partners_v1];
            [self.courseraList addObject:courses];
        }
    }
}

- (void)removeCourses:(WXFCourses*)courses
{
    if(courses){
        [self.courseraList removeObject:courses];
        if(courses.c_id){
            NSString* removeId = nil;
            for(NSString* fav_c_id in self.coursesIds){
                if([courses.c_id isEqualToString:fav_c_id]){
                    removeId = fav_c_id;
                    break;
                }
            }
            if(removeId){
                [self.coursesIds removeObject:removeId];
                [self saveFavoriteDataFromDisk];
            }
            
        }

    }
}
@end
