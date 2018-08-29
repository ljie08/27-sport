//
//  Video.h
//  MoxiLjieApp
//
//  Created by 仙女本人🎀 on 2018/2/6.
//  Copyright © 2018年 AppleFish. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Video : NSObject

@property (nonatomic, copy) NSString *vid;
@property (nonatomic, copy) NSString *summary;//标题
@property (nonatomic, copy) NSString *day_date_order;
@property (nonatomic, copy) NSString *columns;
@property (nonatomic, copy) NSString *videodesc;
@property (nonatomic, copy) NSString *authorAuthentication;
@property (nonatomic, copy) NSString *duration;//时长
@property (nonatomic, copy) NSString *authorHeadImage;//作者头像
@property (nonatomic, copy) NSString *label;
@property (nonatomic, copy) NSString *shareurl;//详细h5
@property (nonatomic, copy) NSString *newstime;
@property (nonatomic, copy) NSString *standardVideourl;
@property (nonatomic, copy) NSString *type;;
@property (nonatomic, strong) NSArray *imgList;
@property (nonatomic, copy) NSString *pcVideourl;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *imgurl;//
@property (nonatomic, copy) NSString *thumbnail;
@property (nonatomic, copy) NSString *superVideourl;
@property (nonatomic, copy) NSString *is_best;
@property (nonatomic, copy) NSString *authorId;
@property (nonatomic, copy) NSString *searchcontent;
@property (nonatomic, copy) NSString *authorName;//作者
@property (nonatomic, copy) NSString *keyword;
@property (nonatomic, copy) NSString *detailurl;//详细json
@property (nonatomic, copy) NSString *commentnum;//评论
@property (nonatomic, copy) NSString *videourl;
@property (nonatomic, copy) NSString *keywords;
@property (nonatomic, copy) NSString *authorSubscribe;
@property (nonatomic, copy) NSString *authorDescription;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *best_order;
@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *shorttitle;

@end
