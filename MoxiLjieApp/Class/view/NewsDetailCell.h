//
//  NewsDetailCell.h
//  MoxiLjieApp
//
//  Created by 仙女本人🎀 on 2018/3/1.
//  Copyright © 2018年 AppleFish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsDetailCell : UITableViewCell

+ (instancetype)myCellWithTableview:(UITableView *)tableview;

- (void)setDataWithModel:(NewsDetail *)model;

+ (CGFloat)cellHeightWithString:(NSString *)string;

@end
