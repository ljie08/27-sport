//
//  HomeViewModel.h
//  MoxiLjieApp
//
//  Created by 仙女本人🎀 on 2018/2/7.
//  Copyright © 2018年 AppleFish. All rights reserved.
//

#import "BaseViewModel.h"

@interface HomeViewModel : BaseViewModel

@property (nonatomic, strong) NSMutableArray *bannerList;//banner
@property (nonatomic, strong) NSMutableArray *newsList;//头条新闻

/**
 首页banner
 
 @param success 成功
 @param failture 失败
 */
- (void)getBannerSuccess:(void(^)(BOOL result))success failture:(void(^)(NSString *error))failture;

/**
 头条

 @param isRefresh 刷新
 @param success <#success description#>
 @param failture <#failture description#>
 */
- (void)getNewsListWithRefresh:(BOOL)isRefresh success:(void(^)(BOOL result))success failture:(void(^)(NSString *error))failture;

@end
