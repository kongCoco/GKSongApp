//
//  GKClassDetailHeadView.h
//  GKSongApp
//
//  Created by wangws1990 on 2019/6/6.
//  Copyright © 2019 王炜圣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GKClassDetailModel.h"
NS_ASSUME_NONNULL_BEGIN
@class GKClassDetailNavBar;
@interface GKClassDetailHeadView : UIView
@property (strong, nonatomic) UIImageView *imageBg;
@property (strong, nonatomic) UIImageView *imageV;
@property (strong, nonatomic) UILabel *titleLab;
@property (strong, nonatomic) UILabel *subTitleLab;
//@property (strong, nonatomic) GKClassDetailNavBar *navBar;

@property (strong, nonatomic) GKClassAlbumModel *model;

@end

@interface GKClassDetailNavBar : UIView
@property (strong, nonatomic) UIImageView *imageV;
@property (strong, nonatomic) UILabel *navTitleLab;
@property (strong, nonatomic) UIButton *backBtn;
@property (strong, nonatomic) UIButton *playBtn;

@property (assign, nonatomic) CGFloat alphas;
@end

NS_ASSUME_NONNULL_END
