//
//  MatchCell.m
//  MoxiLjieApp
//
//  Created by 仙女本人🎀 on 2018/2/28.
//  Copyright © 2018年 AppleFish. All rights reserved.
//

#import "MatchCell.h"

@interface MatchCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@end

@implementation MatchCell

+ (instancetype)myCellWithTableview:(UITableView *)tableview {
    static NSString *cellid = @"MatchCell";
    MatchCell *cell = [tableview dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"MatchCell" owner:nil options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

- (void)setDataWithModel:(Match *)model {
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:SmallPlaceholderImage options:SDWebImageAllowInvalidSSLCertificates];
    self.nameLab.text = model.title;
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
