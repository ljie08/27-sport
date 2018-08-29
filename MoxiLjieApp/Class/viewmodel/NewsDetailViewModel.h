//
//  NewsContentViewModel.h
//  MoxiLjieApp
//
//  Created by 仙女本人🎀 on 2018/2/7.
//  Copyright © 2018年 AppleFish. All rights reserved.
//

#import "BaseViewModel.h"

@interface NewsDetailViewModel : BaseViewModel

@property (nonatomic, strong) NewsDetail *news;//新闻标题时间等
@property (nonatomic, strong) Detail *detail;//新闻内容h5

/**
 新闻详细
 
 @param url 新闻json
 @param success <#success description#>
 @param failture <#failture description#>
 */
- (void)getNewsDetailWithUrl:(NSString *)url success:(void(^)(BOOL result))success failture:(void(^)(NSString *error))failture;


@end
