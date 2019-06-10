//
//  GKClassItemCell.h
//  GKSongApp
//
//  Created by wangws1990 on 2019/6/5.
//  Copyright © 2019 王炜圣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GKHomeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GKClassItemCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLab;
@property (strong, nonatomic) GKHomeClassModel *classModel;

@property (assign, nonatomic, readonly) CGSize size;
@end


NS_ASSUME_NONNULL_END
