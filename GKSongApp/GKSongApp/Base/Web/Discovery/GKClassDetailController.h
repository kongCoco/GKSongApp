//
//  GKClassDetailController.h
//  GKSongApp
//
//  Created by wangws1990 on 2019/6/6.
//  Copyright © 2019 王炜圣. All rights reserved.
//

#import "BaseTableViewController.h"
#import "GKHomeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GKClassDetailController : BaseTableViewController
+ (instancetype)vcWithClassModel:(GKHomeClassModel *)classModel;
@end

NS_ASSUME_NONNULL_END
