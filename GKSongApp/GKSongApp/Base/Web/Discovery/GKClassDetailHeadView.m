//
//  GKClassDetailHeadView.m
//  GKSongApp
//
//  Created by wangws1990 on 2019/6/6.
//  Copyright © 2019 王炜圣. All rights reserved.
//

#import "GKClassDetailHeadView.h"

@interface GKClassDetailHeadView ()
@end
@implementation GKClassDetailHeadView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self loadUI];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self loadUI];
    }
    return self;
}
- (void)loadUI{
    [self addSubview:self.imageBg];
    [self.imageBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.imageBg.superview);
    }];
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    [self.imageBg addSubview:effectView];
    [effectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(effectView.superview);
    }];
    UIView *mainView = [[UIView alloc] init];
    mainView.backgroundColor = [UIColor colorWithRGB:0x000000 alpha:0.25];
    [self.imageBg addSubview:mainView];
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(mainView.superview);
    }];
//    [mainView addSubview:self.navBar];
    [mainView addSubview:self.imageV];
    [mainView addSubview:self.titleLab];
    [mainView addSubview:self.subTitleLab];
    
//    [self.navBar mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.navBar.superview).offset(0);
//        make.top.equalTo(self.navBar.superview).offset(0);
//        //make.height.offset(NAVI_BAR_HIGHT);
//    }];
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(SCALEW(100)));
        make.left.equalTo(self.imageV.superview).equalTo(@(15));
        make.top.equalTo(self.imageV.superview).offset(NAVI_BAR_HIGHT + 10);
    }];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageV.mas_right).offset(15);
        make.right.equalTo(self.titleLab.superview).offset(-15);
        make.top.equalTo(self.imageV);
    }];
    [self.subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLab);
        make.top.equalTo(self.titleLab.mas_bottom).offset(8);
    }];
}
- (void)setModel:(GKClassAlbumModel *)model{
    if (_model != model) {
        _model = model;
        [self.imageBg sd_setImageWithURL:[NSURL URLWithString:model.coverOrigin] placeholderImage:placeholders];
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.avatarPath] placeholderImage:placeholders];
        self.titleLab.text = model.title ?:@"";
        self.subTitleLab.text = model.intro ?:@"";
    }
}
- (UIImageView *)imageBg{
    if (!_imageBg) {
        _imageBg = [[UIImageView alloc] init];
        _imageBg.clipsToBounds = YES;
        _imageBg.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageBg;
}
- (UIImageView *)imageV{
    if (!_imageV) {
        _imageV = [[UIImageView alloc] init];
        _imageV.clipsToBounds = YES;
        _imageV.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageV;
}
//- (GKClassDetailNavBar *)navBar{
//    if (!_navBar) {
//        _navBar = [[GKClassDetailNavBar alloc] init];
//    }
//    return _navBar;
//}
- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = [UIFont systemFontOfSize:16];
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.numberOfLines = 1;
    }
    return _titleLab;
}

- (UILabel *)subTitleLab{
    if (!_subTitleLab) {
        _subTitleLab = [[UILabel alloc] init];
        _subTitleLab.font = [UIFont systemFontOfSize:13];
        _subTitleLab.textColor = [UIColor whiteColor];
        _subTitleLab.numberOfLines = 3;
    }
    return _subTitleLab;
}
@end
@interface GKClassDetailNavBar()
@property (strong, nonatomic) UIView *contentView;
@end
@implementation GKClassDetailNavBar
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self loadUI];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self loadUI];
    }
    return self;
}
- (void)loadUI{
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView.superview);
    }];
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.backBtn];
    [self addSubview:self.playBtn];
    [self addSubview:self.navTitleLab];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backBtn.superview).equalTo(@(5));
        make.width.height.offset(44);
        make.bottom.equalTo(self.backBtn.superview);
    }];
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.playBtn.superview).offset(5);
        make.centerY.equalTo(self.backBtn);
        make.height.width.equalTo(self.backBtn);
    }];
    
    [self.navTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backBtn);
        make.left.equalTo(self.backBtn.mas_right);
        make.right.equalTo(self.playBtn.mas_left);
    }];
}
- (UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    }
    return _backBtn;
}
- (UIButton *)playBtn{
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    }
    return _playBtn;
}
- (UILabel *)navTitleLab{
    if (!_navTitleLab) {
        _navTitleLab = [[UILabel alloc] init];
        _navTitleLab.font = [UIFont monospacedDigitSystemFontOfSize:18 weight:UIFontWeightHeavy];
        _navTitleLab.textAlignment = NSTextAlignmentCenter;
        _navTitleLab.textColor = [UIColor whiteColor];
        _navTitleLab.text = @"歌单";
    }
    return _navTitleLab;
}
- (UIImageView *)imageV{
    if (!_imageV) {
        _imageV = [[UIImageView alloc] init];
        _imageV.clipsToBounds = YES;
        _imageV.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageV;
}
- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = AppColor;
        _contentView.alpha = 0.0f;
    }
    return _contentView;
}
- (CGSize)intrinsicContentSize{
    return CGSizeMake(SCREEN_WIDTH, NAVI_BAR_HIGHT);
}
- (void)setAlphas:(CGFloat)alphas{
    if (_alphas != alphas) {
        _alphas = alphas;
        self.contentView.alpha = _alphas;
    }
}
@end
