//
//  VideoViewModel.h
//  MoxiLjieApp
//
//  Created by 仙女本人🎀 on 2018/2/7.
//  Copyright © 2018年 AppleFish. All rights reserved.
//

#import "BaseViewModel.h"

@interface VideoViewModel : BaseViewModel

@property (nonatomic, strong) NSMutableArray *videoList;//视频
@property (nonatomic, strong) VideoDetail *video;//视频详细


/**
 视频直播
 
 @param isRefresh 是否刷新
 @param success 成功
 @param failture 失败
 */
- (void)getVideoListWithRefresh:(BOOL)isRefresh success:(void(^)(BOOL result))success failture:(void(^)(NSString *error))failture;

/**
 视频详细

 @param url 视频json
 @param success <#success description#>
 @param failture <#failture description#>
 */
- (void)getVideoDetailWithUrl:(NSString *)url success:(void(^)(BOOL result))success failture:(void(^)(NSString *error))failture;

@end
