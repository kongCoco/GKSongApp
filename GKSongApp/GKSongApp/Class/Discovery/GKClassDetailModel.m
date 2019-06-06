//
//  GKClassDetailModel.m
//  GKSongApp
//
//  Created by wangws1990 on 2019/6/6.
//  Copyright © 2019 王炜圣. All rights reserved.
//

#import "GKClassDetailModel.h"

@implementation GKClassDetailModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : GKClassTrackModel.class};
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"list" : @"tracks.list" };
}

@end


@implementation GKClassAlbumModel

@end


@implementation GKClassTrackModel

@end
