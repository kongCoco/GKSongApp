//
//  GKHomeViewController.m
//  GKSongApp
//
//  Created by wangws1990 on 2019/6/5.
//  Copyright © 2019 王炜圣. All rights reserved.
//

#import "GKHomeViewController.h"
#import "GKHomeModel.h"
@interface GKHomeViewController ()
@property (strong, nonatomic) GKHomeModel *homeModel;
@end

@implementation GKHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self  setupEmpty:self.collectionView];
    [self setupRefresh:self.collectionView option:ATHeaderRefresh|ATHeaderAutoRefresh];
    
}
- (void)refreshData:(NSInteger)page{
    [GKSoneNetManager homeSong:@"2" success:^(id  _Nonnull object) {
        self.homeModel = [GKHomeModel modelWithJSON:object];
        [self.collectionView reloadData];
        [self endRefresh:NO];
    } failure:^(NSString * _Nonnull error) {
        [self endRefreshFailure];
    }];
}
@end
