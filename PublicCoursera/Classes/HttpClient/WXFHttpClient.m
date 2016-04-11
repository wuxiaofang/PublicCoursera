//
//  WXFHttpClient.m
//  WXFCommonModule
//
//  Created by yongche_w on 16/3/24.
//  Copyright © 2016 WXF . All rights reserved.
//

#import "WXFHttpClient.h"
#import "WXFParser.h"
#import "WXFHTTPSessionManager.h"

#define  kBaseUrl   @"https://api.coursera.org"

@interface WXFHttpClient()

@property (nonatomic, strong) WXFHTTPSessionManager* httpSessionManager;

@end

@implementation WXFHttpClient

+ (WXFHttpClient*)shareInstance
{

    static WXFHttpClient* shareClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareClient = [[WXFHttpClient alloc] init];
    });
    return shareClient;
}

- (instancetype)init
{
    self = [super init];
    if(self){
        self.httpSessionManager = [[WXFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseUrl]];
    }
    return self;
}

/*
 * HTTP GET Method
 * 登录状态下才能使用
 * 使用access_token访问服务器，刷新access_token使用getRefreshToken
 *
 **/
- (void)getData:(NSString *)URLString
     parameters:(id)parameters
       callBack:(void (^)(WXFParser *parser))callBackBlock
{
    [self.httpSessionManager GET:URLString
                      parameters:parameters
                        progress:nil
                         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                             if(callBackBlock){
                                 WXFParser* parse = [[WXFParser alloc] init];
                                 [parse parseResponseForSuccess:responseObject
                                                           task:task];
                                 callBackBlock(parse);
                             }
                        }
                         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
                             if(callBackBlock){
                                 WXFParser* parse = [[WXFParser alloc] init];
                                 [parse parseResponseForFailed:error
                                                          task:task];
                                 callBackBlock(parse);
                             }
        
                         }];
}

/*
 * HTTP POST Method
 * 登录状态下才能使用
 * 使用access_token访问服务器，刷新access_token使用getRefreshToken
 *
 **/
- (void)postData:(NSString *)URLString
      parameters:(id)parameters
        callBack:(void (^)(WXFParser *parser))callBackBlock
{
    [self.httpSessionManager POST:URLString
                       parameters:parameters
                         progress:nil
                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable  responseObject) {
                              if(callBackBlock){
                                  WXFParser* parse = [[WXFParser alloc] init];
                                  [parse parseResponseForSuccess:responseObject
                                                            task:task];
                                  callBackBlock(parse);
                              }
                          }
                          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
                              if(callBackBlock){
                                  WXFParser* parse = [[WXFParser alloc] init];
                                  [parse parseResponseForFailed:error
                                                           task:task];
                                  callBackBlock(parse);
                              }
                             
                          }];
}

@end
