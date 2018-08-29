//
//  HomeViewController.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/10/10.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "HomeViewController.h"
#import "BannerScrollView.h"
#import "HomeViewModel.h"
#import "NewsCell.h"
#import "NewsDetailViewController.h"

@interface HomeViewController ()<BannerScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, RefreshTableViewDelegate>

@property (nonatomic, strong) BannerScrollView *bannerView;
@property (nonatomic, strong) UIImageView *bannerDefaultImg;//banner默认图片

@property (weak, nonatomic) IBOutlet JJRefreshTabView *homeTab;

@property (nonatomic, strong) HomeViewModel *viewmodel;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

#pragma mark - data
- (void)initViewModelBinding {
    self.viewmodel = [[HomeViewModel alloc] init];
    [self loadBannerData];
//    [self loadNewsRefresh:YES];
}

- (void)loadBannerData {
    @weakSelf(self);
    [self showWaiting];
    [self.viewmodel getBannerSuccess:^(BOOL result) {
        [weakSelf hideWaiting];
        [weakSelf setBannerData];
        if (weakSelf.viewmodel.newsList.count) {
            weakSelf.homeTab.isShowMore = YES;
        }
        [weakSelf.homeTab reloadData];
        
    } failture:^(NSString *error) {
        [weakSelf hideWaiting];
        [weakSelf showMassage:error];
    }];
}

- (void)loadNewsRefresh:(BOOL)isRefresh {
    @weakSelf(self);
    [self showWaiting];
    [self.viewmodel getNewsListWithRefresh:isRefresh success:^(BOOL result) {
        [weakSelf hideWaiting];
        [weakSelf.homeTab reloadData];
        if (weakSelf.viewmodel.newsList.count) {
            weakSelf.homeTab.isShowMore = YES;
        }
        
    } failture:^(NSString *error) {
        
        [weakSelf hideWaiting];
        [weakSelf showMassage:error];
    }];
}

#pragma mark - refresh
- (void)refreshTableViewHeader {
    [self loadBannerData];
    [self loadNewsRefresh:YES];
}

- (void)refreshTableViewFooter {
    [self loadNewsRefresh:NO];
}

#pragma mark - table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewmodel.newsList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    News *news = self.viewmodel.newsList[indexPath.row];
    CGFloat height = [NewsCell cellHeightWithString:news.title];
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsCell *cell = [NewsCell myCellWithTableview:tableView];
    [cell setDataWithModel:self.viewmodel.newsList[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    News *news = self.viewmodel.newsList[indexPath.row];
    [self gotoContentVCWithNews:news];
    
}

#pragma mark - BannerScrollViewDelegate
- (void)bannerTappedIndex:(NSInteger)index tap:(UITapGestureRecognizer *)tap {
    NSLog(@"%ld", index);
//    Banner *banner = self.viewmodel.bannerList[index];
//    [self gotoContentVCWithCid:banner.contentId];
}

#pragma mark - 跳转
- (void)gotoContentVCWithNews:(News *)news {
    NewsDetailViewController *content = [[NewsDetailViewController alloc] init];
    content.news = news;
    content.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:content animated:YES];
}

#pragma mark - ui
- (void)initUIView {
    [self setUpBannerView];
    [self setupTable];
    [self initTitleViewWithTitle:@"首页"];
}

- (void)setupTable {
    self.homeTab.refreshDelegate = self;
    self.homeTab.CanRefresh = YES;
    self.homeTab.lastUpdateKey = NSStringFromClass([self class]);
    self.homeTab.isShowMore = NO;
}

- (void)setUpBannerView {
    self.bannerView = [[BannerScrollView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 160*Heigt_Scale)];
    self.bannerView.bannerHeight = 160*Heigt_Scale;
    self.bannerView.delegate = self;
    self.homeTab.tableHeaderView = self.bannerView;
    
    self.bannerDefaultImg = [[UIImageView alloc] init];
    self.bannerDefaultImg.frame = CGRectMake(0, 0, Screen_Width, 160*Heigt_Scale);
    self.bannerDefaultImg.image = PlaceholderImage;
//    self.bannerDefaultImg.contentMode = UIViewContentModeScaleAspectFill;
    self.bannerDefaultImg.clipsToBounds = YES;
    [self.bannerView addSubview:self.bannerDefaultImg];
//    self.bannerView.imageUrls = @[@"http://7fvaoh.com3.z0.glb.qiniucdn.com/image/150806/kzp5acor6.jpg-w720", @"http://7fvaoh.com3.z0.glb.qiniucdn.com/image/150717/9q1g2knxa.jpg-w720", @"http://7fvaoh.com3.z0.glb.qiniucdn.com/image/150809/3uoh780w5.jpg-w720"];
//    [self.view addSubview:self.bannerView];
}

- (void)setBannerData {
    if (self.viewmodel.bannerList.count > 0) {
        //把图片地址数组赋值给banner的地址数组
        NSMutableArray *banners = [NSMutableArray array];
        for (Banner *banner in self.viewmodel.bannerList) {
            [banners addObject:banner.imgurl];
        }
        self.bannerView.imageUrls = banners;
        if (self.bannerDefaultImg) {
            [self.bannerDefaultImg removeFromSuperview];
            self.bannerDefaultImg = nil;
        }
    }
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
