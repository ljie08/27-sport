//
//  VideoCell.m
//  MoxiLjieApp
//
//  Created by 仙女本人🎀 on 2018/2/28.
//  Copyright © 2018年 AppleFish. All rights reserved.
//

#import "VideoCell.h"

@interface VideoCell()

@property (weak, nonatomic) IBOutlet UIImageView *videoImg;
@property (weak, nonatomic) IBOutlet UIView *videoBg;
@property (weak, nonatomic) IBOutlet UIView *timeBg;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIImageView *headerImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *commentLab;

@end

@implementation VideoCell

+ (instancetype)myCellWithTableview:(UITableView *)tableview {
    static NSString *cellid = @"NewsCell";
    VideoCell *cell = [tableview dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"VideoCell" owner:nil options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)setDataWithModel:(Video *)model {
    [self.videoImg sd_setImageWithURL:[NSURL URLWithString:model.imgurl] placeholderImage:PlaceholderImage options:SDWebImageAllowInvalidSSLCertificates];
    self.titleLab.text = model.title;
    //177.68 = 178
    //60*2 + 58
    //02:58
    model.duration = [LJUtil roundingOffwithFormat:@"0" floatNum:[model.duration floatValue]];
    
    NSString *minute = [NSString stringWithFormat:@"0%d", [model.duration intValue]/60];
    NSString *second = [NSString stringWithFormat:@"0%d", [model.duration intValue]%60];
    if ([minute intValue] > 9) {
        minute = [minute stringByReplacingOccurrencesOfString:@"0" withString:@""];
    }
    if ([second intValue] > 9) {
        second = [second stringByReplacingOccurrencesOfString:@"0" withString:@""];
    }
    self.timeLab.text = [NSString stringWithFormat:@"%@:%@", minute, second];
    [self.headerImg sd_setImageWithURL:[NSURL URLWithString:model.authorHeadImage] placeholderImage:HeaderPlaceholderImage options:SDWebImageAllowInvalidSSLCertificates];
    self.nameLab.text = model.authorName;
    self.commentLab.text = model.commentnum;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.videoBg.backgroundColor = BlackAlphaColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
