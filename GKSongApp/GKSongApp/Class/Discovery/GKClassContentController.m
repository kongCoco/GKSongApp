//
//  GKClassContentController.m
//  GKSongApp
//
//  Created by wangws1990 on 2019/6/5.
//  Copyright © 2019 王炜圣. All rights reserved.
//

#import "GKClassContentController.h"
#import "GKClassItemController.h"
#import "KLRecycleScrollView.h"
#import "GKNewNavBarView.h"
#import "GKClassModel.h"
@interface GKClassContentController ()<VTMagicViewDataSource,VTMagicViewDelegate,KLRecycleScrollViewDelegate>
@property (strong, nonatomic) VTMagicController * magicController;
@property (strong, nonatomic) NSMutableArray <NSString *>*listTitles;
@property (strong, nonatomic) NSMutableArray *listData;
@property (strong, nonatomic) NSArray *listHotWords;
@property (strong, nonatomic) GKNewNavBarView *navBarView;
@property (nonatomic, strong) KLRecycleScrollView *vmessage;

@end

@implementation GKClassContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    [self.view addSubview:self.navBarView];
    [self.navBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.navBarView.superview);
        make.height.offset(NAVI_BAR_HIGHT);
    }];
    [self addChildViewController:self.magicController];
    [self.view addSubview:self.magicController.view];
    [self.view setNeedsUpdateConstraints];
    UIView * magicView = self.magicController.view;
    [magicView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(magicView.superview);
        make.top.equalTo(self.navBarView.mas_bottom);
    }];
    [self.navBarView.mainView addSubview:self.vmessage];
    UIScrollView *scrow = [self.vmessage valueForKey:@"scrollView"];
    if (scrow) {
        scrow.scrollsToTop = NO;
    }
    [self loadData];
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (int i = 1; i<=6; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"playing%@",@(i)]];
        if (!image) {
            break;
        }
        [images addObject:image];
    }
    UIImage *play = [UIImage animatedImageWithImages:images duration:0.5];
    [self.navBarView.moreBtn setImage:play forState:UIControlStateNormal];
    
}
- (void)loadData{
    self.listTitles = @[].mutableCopy;
    [GKSoneNetManager homeClass:@"2" success:^(id  _Nonnull object) {
        NSArray <GKClassModel *>*datas = [NSArray modelArrayWithClass:GKClassModel.class json:object];
        [datas enumerateObjectsUsingBlock:^(GKClassModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.listTitles addObject:obj.tname ?:@""];
        }];
        self.listData = datas.mutableCopy;
        [self.magicController.magicView reloadData];
    } failure:^(NSString * _Nonnull error) {
        
    }];
    self.listHotWords = @[@"动起来",@"渡情",@"你知道我在等你吗",@"洋葱",@"一千年以后"];
    [self.vmessage reloadData:self.listHotWords.count];
}
#pragma mark VTMagicViewDataSource,VTMagicViewDelegate
/**
 *  获取所有菜单名，数组中存放字符串类型对象
 *
 *  @param magicView self
 *
 *  @return header数组
 */
- (NSArray<__kindof NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView
{
    return self.listTitles;
}
/**
 *  根据itemIndex加载对应的menuItem
 *
 *  @param magicView self
 *  @param itemIndex 需要加载的菜单索引
 *
 *  @return 当前索引对应的菜单按钮
 */
- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex
{
    
    static NSString *itemIdentifier = @"com.new.btn.itemIdentifier";
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    [menuItem setTitle:self.listTitles[itemIndex] forState:UIControlStateNormal];
    [menuItem setTitleColor:Appx333333 forState:UIControlStateNormal];
    [menuItem setTitleColor:AppColor forState:UIControlStateSelected];
    menuItem.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    return menuItem;
}
/**
 *  根据pageIndex加载对应的页面控制器
 *
 *  @param magicView self
 *  @param pageIndex 需要加载的页面索引
 *
 *  @return 页面控制器
 */
- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex
{
    static NSString * itemViewCtrlId = @"com.new.magicView.identifier";
    GKClassItemController * viewCtrl = [magicView dequeueReusablePageWithIdentifier:itemViewCtrlId];
    if (!viewCtrl)
    {
        viewCtrl = [[GKClassItemController alloc] init];
    }
    viewCtrl.classModel =  self.listData[pageIndex];
    return viewCtrl;
}
- (void)magicView:(VTMagicView *)magicView viewDidAppear:(__kindof UIViewController *)viewController atPage:(NSUInteger)pageIndex{
    
}

#pragma mark KLRecycleScrollViewDelegate
- (UIView *)recycleScrollView:(KLRecycleScrollView *)recycleScrollView viewForItemAtIndex:(NSInteger)index {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = Appx333333;
    label.text = self.listHotWords[index];
    label.textAlignment = NSTextAlignmentLeft;
    return label;
}
- (void)recycleScrollView:(KLRecycleScrollView *)recycleScrollView didSelectView:(UIView *)view forItemAtIndex:(NSInteger)index{
    //[self searchAction];
}
#pragma mark get
-(VTMagicController *)magicController {
    
    if (!_magicController) {
        _magicController = [[VTMagicController alloc] init];
        _magicController.magicView.separatorHeight = 0.50f;
        _magicController.magicView.separatorColor = [UIColor colorWithRGB:0xdddddd];
        _magicController.magicView.backgroundColor = [UIColor whiteColor];
        _magicController.magicView.navigationInset = UIEdgeInsetsMake(0,7, 0,7);
        _magicController.magicView.navigationColor = [UIColor whiteColor];
        _magicController.magicView.switchStyle = VTSwitchStyleDefault;
        
        _magicController.magicView.sliderColor = [UIColor colorWithRGB:0xffffff];
        _magicController.magicView.sliderExtension = 1;
        _magicController.magicView.bubbleRadius = 1;
        _magicController.magicView.sliderWidth = 00;
        
        _magicController.magicView.layoutStyle = VTLayoutStyleDefault;
        _magicController.magicView.navigationHeight = 35.0;
        _magicController.magicView.sliderHeight = 0.0;
        _magicController.magicView.itemSpacing = 15;
        
        _magicController.magicView.againstStatusBar = NO;
        _magicController.magicView.dataSource = self;
        _magicController.magicView.delegate = self;
        _magicController.magicView.itemScale = 1.1f;
        _magicController.magicView.needPreloading = true;
        _magicController.magicView.bounces = false;
        
    }
    return _magicController;
}
- (GKNewNavBarView *)navBarView{
    if (!_navBarView) {
        _navBarView = [GKNewNavBarView instanceView];
        _navBarView.backgroundColor = AppColor;
//        [_navBarView.moreBtn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _navBarView;
}
- (KLRecycleScrollView *)vmessage{
    if (!_vmessage) {
        _vmessage = [[KLRecycleScrollView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH - 100, 35)];
        _vmessage.delegate = self;
        _vmessage.direction = KLRecycleScrollViewDirectionTop;
        _vmessage.pagingEnabled = NO;
        _vmessage.timerEnabled = YES;
        _vmessage.scrollInterval = 5;
        _vmessage.backgroundColor = [UIColor whiteColor];
    }
    return _vmessage;
}

@end
