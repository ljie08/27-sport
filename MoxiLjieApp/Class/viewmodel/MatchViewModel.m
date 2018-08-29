//
//  MatchViewModel.m
//  MoxiLjieApp
//
//  Created by 仙女本人🎀 on 2018/3/2.
//  Copyright © 2018年 AppleFish. All rights reserved.
//

#import "MatchViewModel.h"

@implementation MatchViewModel

- (instancetype)init {
    if (self = [super init]) {
        _matchList = [NSMutableArray array];
    }
    
    return self;
}

/**
 比赛
 
 @param success <#success description#>
 @param failture <#failture description#>
 */
- (void)getMatchListWithSuccess:(void(^)(BOOL result))success failture:(void(^)(NSString *error))failture {
    @weakSelf(self);
    [[WebManager sharedManager] getMatchDataSuccess:^(NSArray *matchList) {
        if (weakSelf.matchList.count) {
            [weakSelf.matchList removeAllObjects];
        }
        [weakSelf.matchList addObjectsFromArray:matchList];
        
        success(YES);
    } failure:^(NSString *errorStr) {
        failture(errorStr);
    }];
}

@end
