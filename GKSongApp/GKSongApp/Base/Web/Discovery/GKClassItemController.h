//
//  GKClassItemController.h
//  GKSongApp
//
//  Created by wangws1990 on 2019/6/5.
//  Copyright © 2019 王炜圣. All rights reserved.
//

#import "BaseTableViewController.h"
#import "GKClassModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GKClassItemController : BaseConnectionController
@property (strong, nonatomic) GKClassModel *classModel;
@end

NS_ASSUME_NONNULL_END
