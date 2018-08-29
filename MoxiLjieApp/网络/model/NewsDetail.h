//
//  NewsDetail.h
//  MoxiLjieApp
//
//  Created by 仙女本人🎀 on 2018/3/1.
//  Copyright © 2018年 AppleFish. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsDetail : NSObject

@property (nonatomic, copy) NSString *nid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *shorttitle;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSString *searchcontent;
@property (nonatomic, copy) NSString *keyword;
@property (nonatomic, copy) NSString *columns;
@property (nonatomic, copy) NSString *columns_value;
@property (nonatomic, copy) NSString *imgurl;
@property (nonatomic, copy) NSString *thumbnail;
@property (nonatomic, copy) NSString *shareurl;
@property (nonatomic, copy) NSString *sharetext;
@property (nonatomic, copy) NSString *authorId;
@property (nonatomic, copy) NSString *authorName;
@property (nonatomic, copy) NSString *authorHeadImage;
@property (nonatomic, copy) NSString *authorAuthentication;
@property (nonatomic, copy) NSString *authorDescription;
@property (nonatomic, copy) NSString *authorSubscribe;
@property (nonatomic, copy) NSString *authorSignature;
@property (nonatomic, copy) NSString *detailurl;
@property (nonatomic, copy) NSString *label;
@property (nonatomic, copy) NSString *commentnum;
@property (nonatomic, copy) NSString *newstime;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *source;

@end

@interface Detail : NSObject

@property (nonatomic, copy) NSString *groupSort;
@property (nonatomic, assign) long contenttype;
@property (nonatomic, copy) NSString *did;
@property (nonatomic, copy) NSString *content;

@end
