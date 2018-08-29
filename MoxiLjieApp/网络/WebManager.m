//
//  WebManager.m
//  MyWeather
//
//  Created by lijie on 2017/7/27.
//  Copyright © 2017年 lijie. All rights reserved.
//

#import "WebManager.h"

@implementation WebManager

+ (instancetype)sharedManager {
    static WebManager *manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        manager = [[self alloc] initWithBaseURL:[NSURL URLWithString:@"http://httpbin.org/"]];
    });
    return manager;
}

-(instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        // 请求超时设定
        self.requestSerializer.timeoutInterval = 5;
        self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [self.requestSerializer setValue:url.absoluteString forHTTPHeaderField:@"Referer"];
        
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
        
        self.securityPolicy.allowInvalidCertificates = YES;
    }
    return self;
}

#pragma mark - Data

/**
 banner
 
 @param success <#success description#>
 @param failure <#failure description#>
 */
- (void)getBannerSuccess:(void(^)(NSArray *bannerList))success failure:(void(^)(NSString *errorStr))failure {
    [self requestWithMethod:GET WithUrl:Banner_PATH WithParams:nil WithSuccessBlock:^(NSDictionary *dic) {
        NSArray *datas = [Banner mj_objectArrayWithKeyValuesArray:[dic objectForKey:@"datas"]];
        
        success(datas);
    } WithFailureBlock:^(NSError *error) {
        failure(error.localizedDescription);
    }];
}

/**
 头条
 
 @param order 数组中最后一个model的order
 @param success <#success description#>
 @param failure <#failure description#>
 */
- (void)getTouTiaoListWithOrder:(NSString *)order success:(void(^)(NSArray *newsList))success failure:(void(^)(NSString *errorStr))failure {
    NSString *url = [NSString stringWithFormat:@"%@%@", BaseURL, TouTiao_PATH];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (order) {        
        [params setObject:order forKey:@"order"];
    }
    [self requestWithMethod:GET WithUrl:url WithParams:params WithSuccessBlock:^(NSDictionary *dic) {
        NSDictionary *content = [dic objectForKey:@"content"];
        NSArray *contentList = [News mj_objectArrayWithKeyValuesArray:[content objectForKey:@"list"]];
        
        success(contentList);
    } WithFailureBlock:^(NSError *error) {
        failure(error.localizedDescription);
    }];
}

/**
 比赛-数据
 
 @param success <#success description#>
 @param failure <#failure description#>
 */
- (void)getMatchDataSuccess:(void(^)(NSArray *matchList))success failure:(void(^)(NSString *errorStr))failure {
    NSString *url = [NSString stringWithFormat:@"%@%@", BaseURL, Match_PATH];
    [self requestWithMethod:GET WithUrl:url WithParams:nil WithSuccessBlock:^(NSDictionary *dic) {
        NSArray *matchList = [Match mj_objectArrayWithKeyValuesArray:[dic objectForKey:@"content"]];
        
        success(matchList);
    } WithFailureBlock:^(NSError *error) {
        failure(error.localizedDescription);
    }];
}

/**
 直播
 
 @param lastId <#lastId description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
- (void)getVideoListWithLastId:(NSString *)lastId success:(void(^)(NSArray *videoList))success failure:(void(^)(NSString *errorStr))failure {
    NSString *url = [NSString stringWithFormat:@"%@%@", BaseURL, Video_PATH];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (lastId) {
        [params setObject:lastId forKey:@"lastid"];
    }
    [self requestWithMethod:GET WithUrl:url WithParams:params WithSuccessBlock:^(NSDictionary *dic) {
        NSDictionary *content = [dic objectForKey:@"content"];
        NSArray *videoList = [Video mj_objectArrayWithKeyValuesArray:[content objectForKey:@"list"]];

        success(videoList);
    } WithFailureBlock:^(NSError *error) {
        failure(error.localizedDescription);
    }];
}

/**
 新闻详细
 
 @param url 接口
 @param success <#success description#>
 @param failure <#failure description#>
 */
- (void)getNewsDetailWithUrl:(NSString *)url success:(void(^)(NewsDetail *news, Detail *detail))success failure:(void(^)(NSString *errorStr))failure {
    [self requestWithMethod:GET WithUrl:url WithParams:nil WithSuccessBlock:^(NSDictionary *dic) {
        NewsDetail *news = [NewsDetail mj_objectWithKeyValues:[dic objectForKey:@"list"]];
        NSArray *detailArr = [Detail mj_objectArrayWithKeyValuesArray:[dic objectForKey:@"detail"]];
        Detail *detail = [[Detail alloc] init];
        for (Detail *model in detailArr) {
            if (model.contenttype == 8) {
                detail = model;
            }
        }
        success(news, detail);
    } WithFailureBlock:^(NSError *error) {
        failure(error.localizedDescription);
    }];
}

/**
 视频详细
 
 @param url 接口
 @param success <#success description#>
 @param failure <#failure description#>
 */
- (void)getVideoDetailWithUrl:(NSString *)url success:(void(^)(VideoDetail *detail))success failure:(void(^)(NSString *errorStr))failure {
    [self requestWithMethod:GET WithUrl:url WithParams:nil WithSuccessBlock:^(NSDictionary *dic) {
        VideoDetail *detail = [VideoDetail mj_objectWithKeyValues:[dic objectForKey:@"list"]];
        success(detail);
    } WithFailureBlock:^(NSError *error) {
        failure(error.localizedDescription);
    }];
}


#pragma mark ----
#pragma mark - request
- (void)requestWithMethod:(HTTPMethod)method
                  WithUrl:(NSString *)url
               WithParams:(NSDictionary*)params
         WithSuccessBlock:(requestSuccessBlock)success
         WithFailureBlock:(requestFailureBlock)failure {
    
//    url = [NSString stringWithFormat:@"%@%@", BaseURL, url];
    NSLog(@"url --> %@", url);
    
    switch (method) {
        case GET:{
            [self GET:url parameters:params progress:nil success:^(NSURLSessionTask *task, NSDictionary * responseObject) {
//                NSLog(@"JSON: %@", responseObject);
                success(responseObject);
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);
                
                failure(error);
            }];
            break;
        }
        case POST:{
            [self POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, NSDictionary * responseObject) {
//                NSLog(@"JSON: %@", responseObject);
                success(responseObject);
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);
                
                failure(error);
            }];
            break;
        }
        default:
            break;
    }
}

@end


