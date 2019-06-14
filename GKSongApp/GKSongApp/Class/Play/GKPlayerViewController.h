//
//  GKPlayerViewController.h
//  GKSongApp
//
//  Created by wangws1990 on 2019/6/10.
//  Copyright © 2019 王炜圣. All rights reserved.
//

#import "BaseViewController.h"
#import "GKClassDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GKPlayerViewController : BaseViewController
+ (instancetype)vcWithModel:(GKClassTrackModel *)model;
+ (instancetype)sharedInstance;
@end

NS_ASSUME_NONNULL_END
