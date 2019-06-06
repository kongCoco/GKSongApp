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

@interface GKClassDetailController ()
@property (strong, nonatomic) GKHomeClassModel *classModel;

@property (strong, nonatomic) GKClassDetailModel *detailModel;
@property (strong, nonatomic) GKClassDetailHeadView *headView;


@property (strong, nonatomic) NSMutableArray *listData;
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
    self.fd_prefersNavigationBarHidden = YES;
    self.listData = @[].mutableCopy;
    [self setupEmpty:self.tableView];
    [self setupRefresh:self.tableView option:ATRefreshNone];
    UIView *tableHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 200 +STATUS_BAR_HIGHT-20)];
    [tableHeadView addSubview:self.headView];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.headView.superview);
    }];
    [self.tableView setTableHeaderView:tableHeadView];
    
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

- (GKClassDetailHeadView *)headView{
    if (!_headView) {
        _headView = [GKClassDetailHeadView instanceView];
        [_headView.navBar.backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _headView;
}
@end
