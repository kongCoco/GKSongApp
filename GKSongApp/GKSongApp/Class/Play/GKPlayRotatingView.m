
//
//  RotatingView.m
//  AudioPlayer
//
//  Created by ClaudeLi on 16/4/12.
//  Copyright © 2016年 ClaudeLi. All rights reserved.
//

#import "GKPlayRotatingView.h"
#define BorderWidth 6.0f //边界半透明宽度

@interface GKPlayRotatingView ()
@property (strong, nonatomic) UIView *mainView;
@property (strong, nonatomic) UIImageView *imageRound;
@property (strong, nonatomic) UIImageView *imageIcon;


@end

@implementation GKPlayRotatingView
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self loadUI];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadUI];
    }
    return self;
}
- (void)loadUI{
    self.backgroundColor = [UIColor clearColor];
    CGFloat height = SCALEW(300);
    [self addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(height + 10);
        make.center.equalTo(self.mainView.superview);
    }];
    self.mainView.layer.masksToBounds = YES;
    self.mainView.layer.cornerRadius = (height + 10)/2;
    
    [self.mainView addSubview:self.imageRound];
    [self.imageRound mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(height);
        make.center.equalTo(self.imageRound.superview);
    }];
    
    [self.imageRound addSubview:self.imageIcon];
    [self.imageIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(height - 100);
        make.center.equalTo(self.imageIcon.superview);
    }];
    self.imageIcon.layer.masksToBounds = YES;
    self.imageIcon.layer.cornerRadius = (height-100)/2;
    [self addAnimation];
}

/// 添加动画
- (void)addAnimation{
    
    CABasicAnimation *monkeyAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    monkeyAnimation.toValue = [NSNumber numberWithFloat:2.0 *M_PI];
    monkeyAnimation.duration = 20.0f;
    monkeyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    monkeyAnimation.cumulative = NO;
    monkeyAnimation.removedOnCompletion = NO; //No Remove
    monkeyAnimation.fillMode = kCAFillModeForwards;
    monkeyAnimation.repeatCount = FLT_MAX;
    [self.imageIcon.layer addAnimation:monkeyAnimation forKey:@"AnimatedKey"];
    [self.imageIcon stopAnimating];
    self.imageIcon.layer.speed = 0.0;
}

// 停止
-(void)pause
{
    CFTimeInterval pausedTime = [self.imageIcon.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.imageIcon.layer.speed = 0.0;
    self.imageIcon.layer.timeOffset = pausedTime;
}

// 恢复
-(void)resume
{
    CFTimeInterval pausedTime = self.imageIcon.layer.timeOffset;
    self.imageIcon.layer.speed = 1.0;
    self.imageIcon.layer.timeOffset = 0.0;
    self.imageIcon.layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self.imageIcon.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.imageIcon.layer.beginTime = timeSincePause;
}

- (void)remove{
    [self.imageIcon.layer removeAllAnimations];
}

- (void)setImageUrl:(NSString *)imageUrl
{
    [self.imageIcon sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:placeholders];
}
- (UIImageView *)imageIcon
{
    if (!_imageIcon) {
        _imageIcon =[[UIImageView alloc]init];
        _imageIcon.layer.masksToBounds = YES;
        _imageIcon.layer.cornerRadius = CGRectGetWidth(self.imageIcon.frame)/2.f;
    }
    return _imageIcon;
}
- (UIImageView *)imageRound{
    if (!_imageRound) {
        _imageRound = [[UIImageView alloc] init];
        _imageRound.clipsToBounds = YES;
        _imageRound.contentMode = UIViewContentModeScaleAspectFit;
        _imageRound.image = [UIImage imageNamed:@"icon_play_disc"];
    }
    return _imageRound;
}
- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [[UIView alloc]init];
        _mainView.backgroundColor = [UIColor colorWithRGB:0x000000 alpha:0.6];
    }
    return _mainView;
}
- (CGSize) intrinsicContentSize{
    CGFloat height = SCALEW(238);
    return CGSizeMake(height+5, height+5);
}
@end
@interface GKRotatingView()
@property (strong, nonatomic)GKPlayRotatingView * rotaingV;
@property (strong, nonatomic)UIImageView *imageV;
@end
@implementation GKRotatingView
- (void)dealloc
{
    
}
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self loadUI];
    }
    return self;
}
- (void)loadUI
{
    [self addSubview:self.imageV];
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.imageV.superview);
    }];
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    [self.imageV addSubview:effectView];
    [effectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(effectView.superview);
    }];
    
    [self.imageV addSubview:self.rotaingV];
    [self.rotaingV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.rotaingV.superview);
    }];
}
- (void)setUrl:(NSString *)url{
    if (![_url isEqualToString:url]) {
        _url = url;
        [self.rotaingV setImageUrl:_url];
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:_url] placeholderImage:placeholders];
    }
}
// 停止
- (void)pause
{
    [self.rotaingV pause];
}
// 恢复
- (void)resume
{
    [self.rotaingV resume];
}
// 移除动画
- (void)remove
{
    [self.rotaingV remove];
}
- (GKPlayRotatingView *)rotaingV
{
    if (!_rotaingV){
        _rotaingV = [[GKPlayRotatingView alloc]init];
    }
    return _rotaingV;
}
- (UIImageView *)imageV{
    if (!_imageV) {
        _imageV = [[UIImageView alloc] init];
        _imageV.clipsToBounds = YES;
        _imageV.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageV;
}
@end
