//
//  GKPlayerViewController.m
//  GKSongApp
//
//  Created by wangws1990 on 2019/6/10.
//  Copyright © 2019 王炜圣. All rights reserved.
//

#import "GKPlayerViewController.h"
#import "GKPlayerManager.h"
#import "BasePlayer.h"
#import "GKPlayRotatingView.h"
@interface GKPlayerViewController ()<BasePlayerDelegate>
@property (strong, nonatomic)GKClassTrackModel *model;
@property (strong, nonatomic)GKRotatingView *rotaingView;
@property (strong, nonatomic) BasePlayer *player;
@end

@implementation GKPlayerViewController
static GKPlayerViewController *_instance;
- (void)dealloc
{
    [self.rotaingView pause];
    [self.rotaingView remove];
}
+ (instancetype)sharedInstance
{
    _instance = _instance ?: [[GKPlayerViewController alloc]init];
    return _instance;
}
+ (instancetype)vcWithModel:(GKClassTrackModel *)model{
    GKPlayerViewController *vc = [GKPlayerViewController sharedInstance];
    if (vc.model.trackId != model.trackId) {
        vc.model = model;
        [vc restart];
    }
    return vc;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUI];
    // Do any additional setup after loading the view.
}
- (void)restart{
    self.rotaingView.url = self.model.coverLarge;
    self.player.playUrl = self.model.playUrl32;
    [self.player play];
}
- (void)loadUI{
    [self showNavTitle:self.model.title];
    [self.view addSubview:self.rotaingView];
    [self.rotaingView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.rotaingView.superview);
    }];
}
- (void)loadData{
    
}
- (GKRotatingView *)rotaingView
{
    if (!_rotaingView) {
        _rotaingView = [[GKRotatingView alloc]init];
    }
    return _rotaingView;
}
- (BasePlayer *)player{
    if (!_player) {
        _player = [[BasePlayer alloc] init];
        _player.delegate = self;
    }
    return _player;
}
#pragma mark BasePlayerDelegate
- (void)basePlayer:(BasePlayer *)player status:(BasePlayerState)status{
    switch (status) {
        case BasePlayerStatePaused:
            [self.rotaingView pause];
            break;
        case BasePlayerStatePlaying:
            [self.rotaingView resume];
            break;
        default:
            break;
    }
}
@end
