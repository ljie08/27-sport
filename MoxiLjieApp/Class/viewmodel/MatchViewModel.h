//
//  MatchViewModel.h
//  MoxiLjieApp
//
//  Created by 仙女本人🎀 on 2018/3/2.
//  Copyright © 2018年 AppleFish. All rights reserved.
//

#import "BaseViewModel.h"

@interface MatchViewModel : BaseViewModel

@property (nonatomic, strong) NSMutableArray *matchList;//头条新闻

/**
 比赛
 
 @param success <#success description#>
 @param failture <#failture description#>
 */
- (void)getMatchListWithSuccess:(void(^)(BOOL result))success failture:(void(^)(NSString *error))failture;

@end
