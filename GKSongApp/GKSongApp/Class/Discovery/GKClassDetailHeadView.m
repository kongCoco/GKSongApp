//
//  GKClassDetailHeadView.m
//  GKSongApp
//
//  Created by wangws1990 on 2019/6/6.
//  Copyright © 2019 王炜圣. All rights reserved.
//

#import "GKClassDetailHeadView.h"

@interface GKClassDetailHeadView ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backTop;

@end
@implementation GKClassDetailHeadView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.backTop.constant = STATUS_BAR_HIGHT;
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
    [self addSubview:self.backBtn];
    [self addSubview:self.playBtn];
    [self addSubview:self.navTitleLab];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backBtn.superview).offset(5);
        make.width.height.offset(44);
        make.top.equalTo(self.backBtn.superview).offset(NAVI_BAR_HIGHT);
    }];
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.playBtn.superview).offset(-5);
        make.width.height.offset(44);
        make.centerY.equalTo(self.backBtn);
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
    }
    return _navTitleLab;
}
//- (CGSize)intrinsicContentSize{
//    return CGSizeMake(SCREEN_WIDTH, 44);
//}
@end
