//
//  HomeViewModel.m
//  MoxiLjieApp
//
//  Created by 仙女本人🎀 on 2018/2/7.
//  Copyright © 2018年 AppleFish. All rights reserved.
//

#import "HomeViewModel.h"

@implementation HomeViewModel

- (instancetype)init {
    if (self = [super init]) {
        _bannerList = [NSMutableArray array];
        _newsList = [NSMutableArray array];
    }
    return self;
}

/**
 首页banner和新闻
 
 @param success 成功
 @param failture 失败
 */
- (void)getBannerSuccess:(void(^)(BOOL result))success failture:(void(^)(NSString *error))failture {
    
    @weakSelf(self);
    [[WebManager sharedManager] getBannerSuccess:^(NSArray *bannerList) {
        if (weakSelf.bannerList.count) {
            [weakSelf.bannerList removeAllObjects];
        }
        [weakSelf.bannerList addObjectsFromArray:bannerList];
        
        success(YES);
    } failure:^(NSString *errorStr) {
        failture(errorStr);
    }];
}

/**
 头条
 
 @param isRefresh 刷新
 @param success <#success description#>
 @param failture <#failture description#>
 */
- (void)getNewsListWithRefresh:(BOOL)isRefresh success:(void(^)(BOOL result))success failture:(void(^)(NSString *error))failture {
    NSString *orderStr = [NSString string];
    if (!isRefresh) {
        if (self.newsList.count) {
            News *news = self.newsList.lastObject;
            orderStr = news.day_date_order;
        }
    }
    
    @weakSelf(self);
    [[WebManager sharedManager] getTouTiaoListWithOrder:orderStr success:^(NSArray *newsList) {
        if (isRefresh) {
            if (weakSelf.newsList.count) {
                [weakSelf.newsList removeAllObjects];
            }
        }
        [weakSelf.newsList addObjectsFromArray:newsList];
        
        success(YES);
    } failure:^(NSString *errorStr) {
        failture(errorStr);
    }];
}

@end
