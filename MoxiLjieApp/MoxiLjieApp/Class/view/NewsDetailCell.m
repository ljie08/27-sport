//
//  NewsDetailCell.m
//  MoxiLjieApp
//
//  Created by 仙女本人🎀 on 2018/3/1.
//  Copyright © 2018年 AppleFish. All rights reserved.
//

#import "NewsDetailCell.h"

@interface NewsDetailCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@end

@implementation NewsDetailCell

+ (instancetype)myCellWithTableview:(UITableView *)tableview {
    static NSString *cellid = @"NewsDetailCell";
    NewsDetailCell *cell = [tableview dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"NewsDetailCell" owner:nil options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

- (void)setDataWithModel:(NewsDetail *)model {
    self.titleLab.text = model.title;
    self.timeLab.text = [LJUtil timeInterverlToDateStr:model.newstime];
}

+ (CGFloat)cellHeightWithString:(NSString *)string {
    CGFloat height = [LJUtil initWithSize:CGSizeMake(Screen_Width-30, CGFLOAT_MAX) string:string font:20].height;
    return height+55;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
