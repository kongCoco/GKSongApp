//
//  GKClassModel.h
//  GKSongApp
//
//  Created by wangws1990 on 2019/6/5.
//  Copyright © 2019 王炜圣. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GKClassModel : BaseModel
@property (copy, nonatomic) NSString *tname;
@property (copy, nonatomic) NSString *category_id;
@end

NS_ASSUME_NONNULL_END
