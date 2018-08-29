//
//  MatchViewController.m
//  MoxiLjieApp
//
//  Created by 仙女本人🎀 on 2018/2/27.
//  Copyright © 2018年 AppleFish. All rights reserved.
//

#import "MatchViewController.h"
#import "MatchCell.h"
#import "MatchViewModel.h"
#import "WKViewController.h"

@interface MatchViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *matchTab;
@property (nonatomic, strong) MatchViewModel *viewmodel;

@end

@implementation MatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - data
- (void)initViewModelBinding {
    self.viewmodel = [[MatchViewModel alloc] init];
    [self loadData];
}

- (void)loadData {
    @weakSelf(self);
    [self showWaiting];
    [self.viewmodel getMatchListWithSuccess:^(BOOL result) {
        [weakSelf hideWaiting];
        
        [weakSelf.matchTab reloadData];
        
    } failture:^(NSString *error) {
        [weakSelf hideWaiting];
        [weakSelf showMassage:error];
    }];
}

#pragma mark - table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewmodel.matchList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    //    return 44;
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MatchCell *cell = [MatchCell myCellWithTableview:tableView];
    [cell setDataWithModel:self.viewmodel.matchList[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WKViewController *wk = [[WKViewController alloc] init];
    
    Match *match = self.viewmodel.matchList[indexPath.row];
    
    wk.title = @"数据";
    wk.url = match.url;
    wk.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:wk animated:YES];
}

#pragma mark -- ui
- (void)initUIView {
    [self initTitleViewWithTitle:@"数据"];
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
