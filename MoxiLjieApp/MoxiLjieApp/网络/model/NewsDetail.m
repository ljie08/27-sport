//
//  NewsDetail.m
//  MoxiLjieApp
//
//  Created by 仙女本人🎀 on 2018/3/1.
//  Copyright © 2018年 AppleFish. All rights reserved.
//

#import "NewsDetail.h"

@implementation NewsDetail

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"nid": @"id"};
}

@end

@implementation Detail

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"did": @"id"};
}

@end
