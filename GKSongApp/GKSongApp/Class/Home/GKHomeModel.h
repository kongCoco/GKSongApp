//
//  GKHomeModel.h
//  GKSongApp
//
//  Created by wangws1990 on 2019/6/5.
//  Copyright © 2019 王炜圣. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@class GKHomeBanner,GKHomeClassModel,GKHomeCategory;
@interface GKHomeModel : BaseModel
@property (strong, nonatomic) NSArray <GKHomeBanner *>*banners;
@property (strong, nonatomic) NSArray <GKHomeCategory *>*list;
@end

@interface GKHomeCategory : BaseModel
@property (assign, nonatomic) BOOL hasMore;
@property (strong, nonatomic) NSArray <GKHomeClassModel *>*list;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *calcDimension;
@property (copy, nonatomic) NSString *contentType;
@property (copy, nonatomic) NSString *keywordId;
@property (copy, nonatomic) NSString *keywordName;
@property (copy, nonatomic) NSString *moduleType;
@property (copy, nonatomic) NSString *tagName;
@end

@interface GKHomeClassModel : BaseModel

@property (copy, nonatomic) NSString *albumCoverUrl290;
@property (copy, nonatomic) NSString *albumId;
@property (copy, nonatomic) NSString *commentsCount;
@property (copy, nonatomic) NSString *coverLarge;
@property (copy, nonatomic) NSString *coverMiddle;
@property (copy, nonatomic) NSString *coverSmall;
@property (copy, nonatomic) NSString *intro;

@property (copy, nonatomic) NSString *isVipFree;
@property (copy, nonatomic) NSString *nickname;
@property (copy, nonatomic) NSString *playsCounts;
@property (copy, nonatomic) NSString *trackId;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *trackTitle;
@property (copy, nonatomic) NSString *vipFreeType;

@end
@interface GKHomeBanner : BaseModel
@property (copy, nonatomic) NSString *focusCurrentId;
@property (copy, nonatomic) NSString *isShare;
@property (copy, nonatomic) NSString *is_External_url;
@property (copy, nonatomic) NSString *longTitle;
@property (copy, nonatomic) NSString *pic;
@property (copy, nonatomic) NSString *roomId;
@property (copy, nonatomic) NSString *shortTitle;
@property (copy, nonatomic) NSString *trackId;
@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *uid;
@end

NS_ASSUME_NONNULL_END
