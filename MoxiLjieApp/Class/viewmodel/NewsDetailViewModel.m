//
//  NewsContentViewModel.m
//  MoxiLjieApp
//
//  Created by 仙女本人🎀 on 2018/2/7.
//  Copyright © 2018年 AppleFish. All rights reserved.
//

#import "NewsDetailViewModel.h"

@implementation NewsDetailViewModel

- (instancetype)init {
    if (self = [super init]) {
        _news = [[NewsDetail alloc] init];
        _detail = [[Detail alloc] init];
    }
    return self;
}

/**
 新闻详细
 
 @param url 新闻json
 @param success <#success description#>
 @param failture <#failture description#>
 */
- (void)getNewsDetailWithUrl:(NSString *)url success:(void(^)(BOOL result))success failture:(void(^)(NSString *error))failture {
    @weakSelf(self);
    [[WebManager sharedManager] getNewsDetailWithUrl:url success:^(NewsDetail *news, Detail *detail) {
        weakSelf.news = news;
        weakSelf.detail = detail;
        
        success(YES);
    } failure:^(NSString *errorStr) {
        failture(errorStr);
    }];
}

@end
