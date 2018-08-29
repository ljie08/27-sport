//
//  VideoViewModel.m
//  MoxiLjieApp
//
//  Created by 仙女本人🎀 on 2018/2/7.
//  Copyright © 2018年 AppleFish. All rights reserved.
//

#import "VideoViewModel.h"

@implementation VideoViewModel

- (instancetype)init {
    if (self = [super init]) {
        _videoList = [NSMutableArray array];
        _video = [[VideoDetail alloc] init];
    }
    return self;
}

/**
 视频直播
 
 @param isRefresh 是否刷新
 @param success 成功
 @param failture 失败
 */
- (void)getVideoListWithRefresh:(BOOL)isRefresh  success:(void(^)(BOOL result))success failture:(void(^)(NSString *error))failture {
    NSString *lastStr = [NSString string];
    if (!isRefresh) {
        if (self.videoList.count) {
            Video *video = self.videoList.lastObject;
            lastStr = video.pid;
        }
    }
    
    @weakSelf(self);
    [[WebManager sharedManager] getVideoListWithLastId:lastStr success:^(NSArray *videoList) {
        if (isRefresh) {
            if (weakSelf.videoList.count) {
                [weakSelf.videoList removeAllObjects];
            }
        }
        [weakSelf.videoList addObjectsFromArray:videoList];
        
        success(YES);
    } failure:^(NSString *errorStr) {
        failture(errorStr);
    }];
}

/**
 视频详细
 
 @param url 视频json
 @param success <#success description#>
 @param failture <#failture description#>
 */
- (void)getVideoDetailWithUrl:(NSString *)url success:(void(^)(BOOL result))success failture:(void(^)(NSString *error))failture {
    @weakSelf(self);
    [[WebManager sharedManager] getVideoDetailWithUrl:url success:^(VideoDetail *detail) {
        weakSelf.video = detail;
        
        success(YES);
    } failure:^(NSString *errorStr) {
        failture(errorStr);
    }];
}

@end
