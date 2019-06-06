//
//  GKClassDetailCell.h
//  GKSongApp
//
//  Created by wangws1990 on 2019/6/6.
//  Copyright © 2019 王炜圣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GKClassDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GKClassDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLab;
@property (weak, nonatomic) IBOutlet UIButton *indexBtn;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (strong, nonatomic) GKClassTrackModel *model;
@end

NS_ASSUME_NONNULL_END
