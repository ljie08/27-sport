//
//  PlayVideoViewController.m
//  MoxiLjieApp
//
//  Created by 0.0 on 2017/11/6.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "PlayVideoViewController.h"
#import "VideoViewModel.h"

@interface PlayVideoViewController ()<ZFPlayerDelegate>

@property (nonatomic, strong) ZFPlayerView *playerView;

@property (nonatomic, strong) UIView *videoView;

@end

@implementation PlayVideoViewController

- (ZFPlayerView *)playerView{
    if (!_playerView) {
        _playerView = [[ZFPlayerView alloc] init];
        _playerView.delegate = self;
        _playerView.playerLayerGravity = ZFPlayerLayerGravityResizeAspect;
    }
    return _playerView;
}

- (UIView *)videoView {
    if (!_videoView) {
        _videoView = [[UIView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:_videoView];
        [_videoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            
//            make.center.equalTo(self.view);
            make.leading.trailing.mas_equalTo(0);
            // 这里宽高比16：9,可自定义宽高比
            make.height.mas_equalTo(_videoView.mas_width).multipliedBy(9.0f/16.0f);
        }];
    }
    return _videoView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - data

- (void)loadDataForVideoView {
    ZFPlayerControlView  *controlView = [[ZFPlayerControlView alloc] init];
    //初始化播放器模型
    ZFPlayerModel *playerModel = [[ZFPlayerModel alloc] init];
    playerModel.videoURL = [NSURL URLWithString:self.video.videourl];
    
//    playerModel.placeholderImageURLString = [KBaseIDPicURL stringByAppendingString:content.kanPic];
    
    playerModel.fatherView = self.videoView;
    
    [self.playerView playerControlView:controlView playerModel:playerModel];
    //自动播放
    [self.playerView autoPlayTheVideo];
}

- (void)initUIView {
    [self setBackButton:YES];
    [self initTitleViewWithTitle:@"播放"];
    self.view.backgroundColor = WhiteColor;
    [self loadDataForVideoView];
    
//    NSString *title = @"诺维斯基生涯总得分超过31000分！诺维斯基生涯总得分超过31000分！诺维斯基生涯总得分超过31000分！";
//    NSString *desc = @"从0到31000，从1998到2018，诺维斯基从未停下追逐伟大的脚步。诺维斯基生涯总得分超过31000分！诺维斯基生涯总得分超过31000分！诺维斯基生涯总得分超过31000分！";
    CGSize tSize = [LJUtil initWithSize:CGSizeMake(Screen_Width-30, CGFLOAT_MAX) string:self.video.title font:16];
    CGSize dSize = [LJUtil initWithSize:CGSizeMake(Screen_Width-30, CGFLOAT_MAX) string:self.video.videodesc font:14];
    //w:h=16:9
    //h=w*9/16
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(15, Screen_Width*9/16.0+15, Screen_Width-30, tSize.height)];
    titleLab.text = self.video.title;
    titleLab.font = [UIFont systemFontOfSize:16];
    titleLab.textColor = FontColor;
    titleLab.numberOfLines = 0;
    [self.view addSubview:titleLab];
    
    UILabel *descLab = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(titleLab.frame)+10, Screen_Width-30, dSize.height)];
    descLab.text = self.video.videodesc;
    descLab.font = [UIFont systemFontOfSize:14];
    descLab.textColor = FontLightColor;
    descLab.numberOfLines = 0;
    [self.view addSubview:descLab];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
