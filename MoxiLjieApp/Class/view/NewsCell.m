//
//  NewsCell.m
//  MoxiLjieApp
//
//  Created by 仙女本人🎀 on 2018/2/28.
//  Copyright © 2018年 AppleFish. All rights reserved.
//

#import "NewsCell.h"

@interface NewsCell()

@property (weak, nonatomic) IBOutlet UIImageView *newsImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *headerImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *commentLab;

@end

@implementation NewsCell

+ (instancetype)myCellWithTableview:(UITableView *)tableview {
    static NSString *cellid = @"NewsCell";
    NewsCell *cell = [tableview dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"NewsCell" owner:nil options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)setDataWithModel:(News *)model {
#warning 有些cell的titleLab没有显示
    [self.newsImg sd_setImageWithURL:[NSURL URLWithString:model.imgurl] placeholderImage:PlaceholderImage options:SDWebImageAllowInvalidSSLCertificates];
    self.titleLab.text = model.title;
    [self.headerImg sd_setImageWithURL:[NSURL URLWithString:model.authorHeadImage] placeholderImage:HeaderPlaceholderImage options:SDWebImageAllowInvalidSSLCertificates];
    self.nameLab.text = model.authorName;
    self.timeLab.text = [LJUtil timeInterverlToDateStr:model.newstime];
    self.commentLab.text = model.commentnum;
}

+ (CGFloat)cellHeightWithString:(NSString *)string {
    CGFloat height = [LJUtil initWithSize:CGSizeMake(Screen_Width-30, CGFLOAT_MAX) string:string font:20].height;
    return height+205*Heigt_Scale;
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
