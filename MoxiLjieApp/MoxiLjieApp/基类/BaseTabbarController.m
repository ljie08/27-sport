//
//  BaseTabbarController.m
//  IOSFrame
//
//  Created by lijie on 2017/7/17.
//  Copyright © 2017年 lijie. All rights reserved.
//

#import "BaseTabbarController.h"
#import "BaseNavigationController.h"
#import "HomeViewController.h"
#import "VideoViewController.h"
#import "MatchViewController.h"
#import "WKViewController.h"

@interface BaseTabbarController ()

@end

@implementation BaseTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *num = [LJUtil roundingOffwithFormat:@"0" floatNum:177.68];
    
    NSString *minute = [NSString stringWithFormat:@"0%d", [num intValue]/60];
    NSString *second = [NSString stringWithFormat:@"0%d", [num intValue]%60];
    if ([minute intValue] > 9) {
        minute = [minute stringByReplacingOccurrencesOfString:@"0" withString:@""];
    }
    if ([second intValue] > 9) {
        second = [second stringByReplacingOccurrencesOfString:@"0" withString:@""];
    }
//    NSString *str = [NSString stringWithFormat:@"%@:%@", minute, second];
    
    HomeViewController *home = [[HomeViewController alloc] init];
    [self setChildVCWithViewController:home title:@"首页" image:Image(@"home") selectedImg:nil];
    
    WKViewController *score = [[WKViewController alloc] init];
    score.url = @"http://nlive.159cai.com/live";
    score.title = @"比分";
    [self setChildVCWithViewController:score title:@"比分" image:Image(@"score") selectedImg:nil];
    
    VideoViewController *video = [[VideoViewController alloc] init];
    [self setChildVCWithViewController:video title:@"直播" image:Image(@"video") selectedImg:nil];
    
    MatchViewController *match = [[MatchViewController alloc] init];
    [self setChildVCWithViewController:match title:@"数据" image:Image(@"data") selectedImg:nil];
}

- (void)setChildVCWithViewController:(UIViewController *)controller title:(NSString *)title image:(UIImage *)image selectedImg:(UIImage *)selectedImg {
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:controller];
    self.tabBar.tintColor = MyColor;

    nav.title = title;
    nav.tabBarItem.image = image;
    nav.tabBarItem.selectedImage = [selectedImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];
}

#pragma mark - tabbar




@end
