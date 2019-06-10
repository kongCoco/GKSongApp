//
//  GKClassDetailController.m
//  GKSongApp
//
//  Created by wangws1990 on 2019/6/6.
//  Copyright © 2019 王炜圣. All rights reserved.
//

#import "GKClassDetailController.h"
#import "GKClassDetailModel.h"
#import "GKClassDetailCell.h"
#import "GKClassDetailHeadView.h"

static CGFloat height = 0;
@interface GKClassDetailController ()
@property (strong, nonatomic) GKHomeClassModel *classModel;

@property (strong, nonatomic) GKClassDetailModel *detailModel;
@property (strong, nonatomic) GKClassDetailHeadView *headView;
@property (strong, nonatomic) GKClassDetailNavBar *navBar;

@property (strong, nonatomic) NSMutableArray *listData;
@property (assign, nonatomic) CGFloat       lastOffsetY;
@end

@implementation GKClassDetailController
+ (instancetype)vcWithClassModel:(GKHomeClassModel *)classModel{
    GKClassDetailController *vc = [[[self class] alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.classModel = classModel;
    return vc;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUI];
}
- (void)loadUI{
    height = SCALEW(180 + STATUS_BAR_HIGHT);
    self.lastOffsetY = -height;
    self.fd_prefersNavigationBarHidden = YES;
    self.listData = @[].mutableCopy;
    [self setupEmpty:self.tableView];
    [self setupRefresh:self.tableView option:ATFooterRefresh|ATFooterAutoRefresh];
    [self.view addSubview:self.headView];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.headView.superview);
        make.height.offset(height);
    }];
    [self.tableView setContentInset:UIEdgeInsetsMake(height, 0, 0, 0)];
    [self.view addSubview:self.navBar];
    [self.navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.navBar.superview);
    }];
}
- (void)loadData{
    
}
- (void)refreshData:(NSInteger)page{
    [GKSoneNetManager songDetail:self.classModel.albumId title:self.classModel.title page:page success:^(id  _Nonnull object) {
        if (page == 1) {
            [self.listData removeAllObjects];
        }
        self.detailModel = [GKClassDetailModel modelWithJSON:object];
        self.detailModel.list ? [self.listData addObjectsFromArray:self.detailModel.list] : nil;
        [self.tableView reloadData];
        self.headView.model = self.detailModel.album;
        [self endRefresh:self.detailModel.list.count >= RefreshPageSize];
    } failure:^(NSString * _Nonnull error) {
        [self endRefreshFailure];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GKClassDetailCell *cell = [GKClassDetailCell cellForTableView:tableView indexPath:indexPath];
    cell.indexPath = indexPath;
    cell.model = self.listData[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
   // [self changeNavigationBarAlpha:scrollView];
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat delta = offsetY - self.lastOffsetY;
    CGFloat newHeight = height - delta;
    if (newHeight < NAVI_BAR_HIGHT) {
        newHeight = NAVI_BAR_HIGHT;
    }
    [self.headView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(newHeight);
    }];
}
- (void)changeNavigationBarAlpha:(UIScrollView *)scrollView {
    CGFloat alpha = 0;
    CGFloat currentOffsetY = scrollView.contentOffset.y;
    if (currentOffsetY < NAVI_BAR_HIGHT) {
        alpha = 0;
    }else if (currentOffsetY > height){
        alpha = 1;
    }else{
        alpha = (currentOffsetY - height)/height;
    }
    self.navBar.alphas = alpha;
}
- (void)changeHeadZoom{

}
- (GKClassDetailHeadView *)headView{
    if (!_headView) {
        _headView = [[GKClassDetailHeadView alloc] init];
       
    }
    return _headView;
}
- (GKClassDetailNavBar *)navBar{
    if (!_navBar) {
        _navBar = [[GKClassDetailNavBar alloc] init];
        [_navBar.backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    }
    return _navBar;
}
@end
