//
//  NewsDetailViewController.m
//  MoxiLjieApp
//
//  Created by 仙女本人🎀 on 2018/3/1.
//  Copyright © 2018年 AppleFish. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "NewsDetailCell.h"
#import "NewsHtmlCell.h"
#import "NewsDetailViewModel.h"

@interface NewsDetailViewController ()<UITableViewDelegate, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *detailTab;
@property (nonatomic, strong) NewsDetailViewModel *viewmodel;
@property (nonatomic, assign) CGFloat webviewHeight;

@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.news = [[News alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateHeight:) name:@"webview_height" object:nil];
}

#pragma mark - data
- (void)initViewModelBinding {
    self.viewmodel = [[NewsDetailViewModel alloc] init];
    [self loadData];
}

- (void)loadData {
    @weakSelf(self);
    [self showWaiting];
    [self.viewmodel getNewsDetailWithUrl:self.news.detailurl success:^(BOOL result) {
        [weakSelf hideWaiting];
        [weakSelf.detailTab dismissNoView];
        [weakSelf.detailTab reloadData];
        
    } failture:^(NSString *error) {
        [weakSelf hideWaiting];
        
        [weakSelf showMassage:error];
    }];
}

- (void)updateHeight:(NSNotification *)notification {
    //    [self.detailTable beginUpdates];
    
    NSDictionary *dic = notification.userInfo;
    self.webviewHeight = [[dic objectForKey:@"webheight"] floatValue];
    
    [self.detailTab reloadData];
    //    NSIndexSet *set = [[NSIndexSet alloc] initWithIndex:1];
    
    //    [self.detailTable reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
    //    [self.detailTable endUpdates];
}

#pragma mark - table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row) {
        return self.webviewHeight;
    } else {
        CGFloat height = [NewsDetailCell cellHeightWithString:self.viewmodel.news.title];
        return height;
    }
//    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    //    return 44;
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row) {
        NewsHtmlCell *cell = [NewsHtmlCell myCellWithTableview:tableView];
        [cell setDataWithModel:self.viewmodel.detail];
        return cell;
    } else {
        NewsDetailCell *cell = [NewsDetailCell myCellWithTableview:tableView];
        [cell setDataWithModel:self.viewmodel.news];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - ui
- (void)initUIView {
    [self initTitleViewWithTitle:@"详情"];
    [self setBackButton:YES];
}

#pragma mark - dealloc
- (void)dealloc {
    [self.viewmodel cancelAllHTTPRequest];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"webview_height" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
