//
//  WebManager.h
//  MoxiLjieApp
//
//  Created by 仙女本人🎀 on 2018/2/6.
//  Copyright © 2018年 AppleFish. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

//请求成功回调block
typedef void (^requestSuccessBlock)(NSDictionary *dic);

//请求失败回调block
typedef void (^requestFailureBlock)(NSError *error);

//请求方法define
typedef enum {
    GET,
    POST,
    PUT,
    DELETE,
    HEAD
} HTTPMethod;

@interface WebManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

#pragma mark - Data

/**
 banner

 @param success <#success description#>
 @param failure <#failure description#>
 */
- (void)getBannerSuccess:(void(^)(NSArray *bannerList))success failure:(void(^)(NSString *errorStr))failure;

/**
 头条

 @param order 数组中最后一个model的order
 @param success <#success description#>
 @param failure <#failure description#>
 */
- (void)getTouTiaoListWithOrder:(NSString *)order success:(void(^)(NSArray *newsList))success failure:(void(^)(NSString *errorStr))failure;

/**
 比赛-数据

 @param success <#success description#>
 @param failure <#failure description#>
 */
- (void)getMatchDataSuccess:(void(^)(NSArray *matchList))success failure:(void(^)(NSString *errorStr))failure;

/**
 直播

 @param lastId <#lastId description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
- (void)getVideoListWithLastId:(NSString *)lastId success:(void(^)(NSArray *videoList))success failure:(void(^)(NSString *errorStr))failure;

/**
 新闻详细

 @param url 接口
 @param success <#success description#>
 @param failure <#failure description#>
 */
- (void)getNewsDetailWithUrl:(NSString *)url success:(void(^)(NewsDetail *news, Detail *detail))success failure:(void(^)(NSString *errorStr))failure;

/**
 视频详细

 @param url 接口
 @param success <#success description#>
 @param failure <#failure description#>
 */
- (void)getVideoDetailWithUrl:(NSString *)url success:(void(^)(VideoDetail *detail))success failure:(void(^)(NSString *errorStr))failure;

#pragma mark -----
#pragma mark - request
- (void)requestWithMethod:(HTTPMethod)method
WithUrl:(NSString *)url
WithParams:(NSDictionary*)params
WithSuccessBlock:(requestSuccessBlock)success
WithFailureBlock:(requestFailureBlock)failure;

@end


