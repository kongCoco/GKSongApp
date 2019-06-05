//
//  GKHomeModel.m
//  GKSongApp
//
//  Created by wangws1990 on 2019/6/5.
//  Copyright © 2019 王炜圣. All rights reserved.
//

#import "GKHomeModel.h"

@implementation GKHomeModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"banners" : GKHomeBanner.class,
             @"list" : GKHomeCategory.class
             };
}

//返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"banners" : @"focusImages.list",
             @"list" : @"categoryContents.list"
             };
}
@end

@implementation GKHomeCategory
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : GKHomeClassModel.class};
}
@end
@implementation GKHomeClassModel

@end
@implementation GKHomeBanner

@end
