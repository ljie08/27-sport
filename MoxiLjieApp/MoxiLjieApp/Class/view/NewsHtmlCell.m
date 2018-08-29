//
//  NewsHtmlCell.m
//  MoxiLjieApp
//
//  Created by 仙女本人🎀 on 2018/3/1.
//  Copyright © 2018年 AppleFish. All rights reserved.
//

#import "NewsHtmlCell.h"

@implementation NewsHtmlCell

+ (instancetype)myCellWithTableview:(UITableView *)tableview {
    static NSString *cellid = @"NewsHtmlCell";
    NewsHtmlCell *cell = [tableview dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"NewsHtmlCell" owner:nil options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

- (void)setDataWithModel:(Detail *)model {
    [self.webview loadHTMLString:model.content baseURL:nil];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, CGFLOAT_MIN)];
    self.webview.userInteractionEnabled = NO;
    [self addSubview:self.webview];
    
    [self.webview.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

//监听webview高度
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentSize"]) {
        CGSize size = [self.webview sizeThatFits:CGSizeZero];
        //        [self.webview setScalesPageToFit:YES];
        self.webview.frame = CGRectMake(0, 0, Screen_Width, size.height);
        
        self.webviewHeight = size.height;
        
        NSDictionary *dic = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:size.height] forKey:@"webheight"];
        // 用通知发送加载完成后的高度
        [[NSNotificationCenter defaultCenter] postNotificationName:@"webview_height" object:self userInfo:dic];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [self.webview.scrollView removeObserver:self forKeyPath:@"contentSize"];
}

@end
