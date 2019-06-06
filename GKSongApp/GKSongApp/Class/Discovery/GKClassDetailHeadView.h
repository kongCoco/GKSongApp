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
@property (weak, nonatomic) IBOutlet UIImageView *imageBg;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLab;
@property (weak, nonatomic) IBOutlet GKClassDetailNavBar *navBar;

@property (strong, nonatomic) GKClassAlbumModel *model;

@end

@interface GKClassDetailNavBar : UIView
@property (strong, nonatomic) UILabel *navTitleLab;
@property (strong, nonatomic) UIButton *backBtn;
@property (strong, nonatomic) UIButton *playBtn;
@end

NS_ASSUME_NONNULL_END
