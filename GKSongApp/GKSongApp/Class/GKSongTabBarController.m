//
//  GKSongTabBarController.m
//  GKSongApp
//
//  Created by wangws1990 on 2019/6/5.
//  Copyright © 2019 王炜圣. All rights reserved.
//

#import "GKSongTabBarController.h"
#import "GKClassContentController.h"
#import "GKHomeViewController.h"
#import "GKMineViewController.h"
@interface GKSongTabBarController ()
@property (strong, nonatomic) NSMutableArray *listData;
@end

@implementation GKSongTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUI];
}
- (void)loadUI{
    
    self.listData = @[].mutableCopy;
    self.tabBar.translucent = NO;
    UIViewController *vc = nil;
    vc = [[ GKHomeViewController alloc] init];
    [self vcWithController:vc title:@"首页" normal:@"icon_home_n" select:@"icon_home_h"];
    vc = [[ GKClassContentController alloc] init];
    [self vcWithController:vc title:@"发现" normal:@"icon_discovery_n" select:@"icon_discovery_h"];
    vc = [[ GKMineViewController alloc] init];
    [self vcWithController:vc title:@"我的" normal:@"icon_mine_n" select:@"icon_mine_h"];
    self.viewControllers = self.listData;
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar_bg"]];
}
- (void)vcWithController:(UIViewController *)vc title:(NSString *)title normal:(NSString *)normal select:(NSString *)select{
    BaseNavigationController *nv = [[BaseNavigationController alloc] initWithRootViewController:vc];
    [vc showNavTitle:title backItem:NO];
    nv.tabBarItem.title = title;
    nv.tabBarItem.image = [[UIImage imageNamed:normal] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nv.tabBarItem.selectedImage = [[UIImage imageNamed:select] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [nv.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRGB:0x888888]} forState:UIControlStateNormal];
    [nv.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateSelected];
    [self.listData addObject:nv];
}
@end
