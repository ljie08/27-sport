//
//  NewsHtmlCell.h
//  MoxiLjieApp
//
//  Created by 仙女本人🎀 on 2018/3/1.
//  Copyright © 2018年 AppleFish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsHtmlCell : UITableViewCell

@property (nonatomic, strong) UIWebView *webview;
@property (nonatomic, assign) CGFloat webviewHeight;

+ (instancetype)myCellWithTableview:(UITableView *)tableview;

- (void)setDataWithModel:(Detail *)model;

@end
