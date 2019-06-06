//
//  GKClassItemController.m
//  GKSongApp
//
//  Created by wangws1990 on 2019/6/5.
//  Copyright © 2019 王炜圣. All rights reserved.
//

#import "GKClassItemController.h"
#import "GKClassDetailController.h"
#import "UIScrollView+PullBig.h"
#import "GKHomeModel.h"
#import "GKClassItemCell.h"
@interface GKClassItemController ()
@property (strong, nonatomic) NSMutableArray *listData;
@end

@implementation GKClassItemController
- (void)vtm_prepareForReuse{
    if (!self.reachable) {
        [self.listData removeAllObjects];
        [self.collectionView reloadData];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUI];
    // Do any additional setup after loading the view.
}
- (void)loadUI{
    self.listData = @[].mutableCopy;
    
    
    [self setupEmpty:self.collectionView];
    [self setupRefresh:self.collectionView option:ATRefreshDefault];
}
- (void)setClassModel:(GKClassModel *)classModel{
    _classModel = classModel;
    [self.collectionView setContentOffset:CGPointMake(0,0) animated:NO];
    [self refreshData:1];
}
- (void)refreshData:(NSInteger)page{
    if (self.classModel) {
        [GKSoneNetManager homeClssItem:self.classModel.category_id tagName:self.classModel.tname page:page success:^(id  _Nonnull object) {
            if (page == RefreshPageStart) {
                [self.listData removeAllObjects];
            }
            NSArray *datas = [NSArray modelArrayWithClass:GKHomeClassModel.class json:object[@"list"]];
            if (datas) {
                [self.listData addObjectsFromArray:datas];
            }
            [self.collectionView reloadData];
            [self endRefresh:datas.count >=RefreshPageSize];
        } failure:^(NSString * _Nonnull error) {
            [self endRefreshFailure];
        }];
    }
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.listData.count;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(2,2,2,2);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (SCREEN_WIDTH - 3*2)/2.0;
    CGFloat height = width + 50;
    return CGSizeMake(width, height);
////    CGSize size = @available(iOS 10.0, *) ? UICollectionViewFlowLayoutAutomaticSize : CGSizeMake(width, height)
//    if (@available(iOS 10.0, *)) {
//        return UICollectionViewFlowLayoutAutomaticSize;
//    } else {
//        return CGSizeMake(width, height);
//    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GKClassItemCell *cell = [GKClassItemCell cellForCollectionView:collectionView indexPath:indexPath];
    cell.classModel = self.listData[indexPath.row];
    
    return cell;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 2;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 2;
}
- (BOOL) shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController pushViewController:[GKClassDetailController vcWithClassModel:self.listData[indexPath.row]] animated:YES];
}
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        CGFloat width = (SCREEN_WIDTH - 3*2)/2.0;
        CGFloat height = width + 50;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        if (@available(iOS 10.0, *)) {
//            layout.itemSize = UICollectionViewFlowLayoutAutomaticSize;
//            layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
//        } else {
//            layout.itemSize = CGSizeMake(width, height);
//            layout.estimatedItemSize = CGSizeMake(width, height);
//        }
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 2;
        layout.minimumInteritemSpacing = 2;

        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.scrollEnabled = YES;
        [_collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:NSStringFromClass(UICollectionViewCell.class)];
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _collectionView;
}

@end
