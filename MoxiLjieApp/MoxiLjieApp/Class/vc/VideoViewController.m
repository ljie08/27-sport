//
//  VideoViewController.m
//  MoxiLjieApp
//
//  Created by 仙女本人🎀 on 2018/2/27.
//  Copyright © 2018年 AppleFish. All rights reserved.
//

#import "VideoViewController.h"
#import "VideoCell.h"
#import "WKViewController.h"
#import "PlayVideoViewController.h"
#import "VideoViewModel.h"

@interface VideoViewController ()<UITableViewDataSource, UITableViewDelegate, RefreshTableViewDelegate>

@property (weak, nonatomic) IBOutlet JJRefreshTabView *videoTab;
@property (nonatomic, strong) VideoViewModel *viewmodel;

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - data
- (void)initViewModelBinding {
    self.viewmodel = [[VideoViewModel alloc] init];
    
    [self loadVideoRefresh:YES];
}

- (void)loadVideoRefresh:(BOOL)isRefresh {
    @weakSelf(self);
    [self showWaiting];
    [self.viewmodel getVideoListWithRefresh:isRefresh success:^(BOOL result) {
        [weakSelf hideWaiting];
        [weakSelf.videoTab reloadData];
        if (weakSelf.viewmodel.videoList.count) {
            weakSelf.videoTab.isShowMore = YES;
        }
        
    } failture:^(NSString *error) {
        [weakSelf hideWaiting];
        [weakSelf showMassage:error];
    }];
}

#pragma mark - refresh
- (void)refreshTableViewHeader {
    [self loadVideoRefresh:YES];
}

- (void)refreshTableViewFooter {
    [self loadVideoRefresh:NO];
}

#pragma mark - table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewmodel.videoList.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.viewmodel.videoList.count;
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return Screen_Width/2.0+50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    //    return 44;
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoCell *cell = [VideoCell myCellWithTableview:tableView];
    [cell setDataWithModel:self.viewmodel.videoList[indexPath.section]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PlayVideoViewController *play = [[PlayVideoViewController alloc] init];
    
    VideoDetail *video = self.viewmodel.videoList[indexPath.row];
    play.video = video;
    play.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:play animated:YES];
}

#pragma mark - ui
- (void)initUIView {
    [self setupTable];
    [self initTitleViewWithTitle:@"直播"];
}

- (void)setupTable {
    self.videoTab.refreshDelegate = self;
    self.videoTab.CanRefresh = YES;
    self.videoTab.lastUpdateKey = NSStringFromClass([self class]);
    self.videoTab.isShowMore = NO;
}

#pragma mark - dealloc
- (void)dealloc {
    [self.viewmodel cancelAllHTTPRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
