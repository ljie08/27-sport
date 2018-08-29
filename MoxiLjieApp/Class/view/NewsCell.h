//
//  NewsCell.h
//  MoxiLjieApp
//
//  Created by 仙女本人🎀 on 2018/2/28.
//  Copyright © 2018年 AppleFish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsCell : UITableViewCell

+ (instancetype)myCellWithTableview:(UITableView *)tableview;

- (void)setDataWithModel:(News *)model;

+ (CGFloat)cellHeightWithString:(NSString *)string;

@end
