//
//  GKClassDetailModel.h
//  GKSongApp
//
//  Created by wangws1990 on 2019/6/6.
//  Copyright © 2019 王炜圣. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@class GKClassAlbumModel,GKClassTrackModel;

@interface GKClassDetailModel : BaseModel

@property (strong, nonatomic)GKClassAlbumModel *album;
@property (strong, nonatomic)NSArray <GKClassTrackModel*>*list;

@end
@interface GKClassAlbumModel : BaseModel
@property (nonatomic, assign) NSInteger albumId;
@property (nonatomic, strong) NSString * avatarPath;
@property (nonatomic, assign) BOOL canInviteListen;
@property (nonatomic, assign) BOOL canShareAndStealListen;
@property (nonatomic, assign) NSInteger categoryId;
@property (nonatomic, strong) NSString * categoryName;
@property (nonatomic, strong) NSString * coverLarge;
@property (nonatomic, strong) NSString * coverLargePop;
@property (nonatomic, strong) NSString * coverMiddle;
@property (nonatomic, strong) NSString * coverOrigin;
@property (nonatomic, strong) NSString * coverSmall;
@property (nonatomic, strong) NSString * coverWebLarge;
@property (nonatomic, assign) NSInteger createdAt;
@property (nonatomic, strong) NSString * customSubTitle;
@property (nonatomic, assign) NSInteger followers;
@property (nonatomic, assign) BOOL hasNew;
@property (nonatomic, strong) NSString * intro;
@property (nonatomic, strong) NSString * introRich;
@property (nonatomic, assign) BOOL isDefault;
@property (nonatomic, assign) BOOL isDraft;
@property (nonatomic, assign) BOOL isFavorite;
@property (nonatomic, assign) BOOL isFollowed;
@property (nonatomic, assign) BOOL isPaid;
@property (nonatomic, assign) BOOL isRecordDesc;
@property (nonatomic, assign) BOOL isVerified;
@property (nonatomic, assign) NSInteger lastUptrackAt;
@property (nonatomic, strong) NSString * lastUptrackCoverPath;
@property (nonatomic, assign) NSInteger lastUptrackId;
@property (nonatomic, strong) NSString * lastUptrackTitle;
@property (nonatomic, strong) NSString * nickname;
@property (nonatomic, assign) NSInteger offlineReason;
@property (nonatomic, assign) NSInteger offlineType;
@property (nonatomic, assign) NSInteger playTimes;
@property (nonatomic, assign) NSInteger playTrackId;
@property (nonatomic, assign) NSInteger refundSupportType;
@property (nonatomic, assign) NSInteger saleScope;
@property (nonatomic, assign) NSInteger serialState;
@property (nonatomic, assign) NSInteger serializeStatus;
@property (nonatomic, assign) NSInteger shareSupportType;
@property (nonatomic, assign) NSInteger shares;
@property (nonatomic, strong) NSString * shortIntro;
@property (nonatomic, strong) NSString * shortIntroRich;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString * tags;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, assign) NSInteger tracks;
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, assign) NSInteger unReadAlbumCommentCount;
@property (nonatomic, assign) NSInteger updatedAt;
@property (nonatomic, assign) NSInteger vipFreeType;
@end

@interface GKClassTrackModel : BaseModel
@property (nonatomic, strong) NSString * albumCoverUrl290;
@property (nonatomic, assign) NSInteger albumId;
@property (nonatomic, assign) NSInteger commentsCount;
@property (nonatomic, strong) NSString * coverPath;
@property (nonatomic, strong) NSString * coverLarge;
@property (nonatomic, strong) NSString * coverSmall;
@property (nonatomic, strong) NSString * coverMiddle;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSString * intro;
@property (nonatomic, assign) BOOL isDraft;
@property (nonatomic, assign) NSInteger isFinished;
@property (nonatomic, assign) BOOL isPaid;
@property (nonatomic, assign) BOOL isVipFree;
@property (nonatomic, strong) NSString * nickname;
@property (nonatomic, assign) NSInteger playsCounts;
@property (nonatomic, assign) NSInteger playtimes;
@property (nonatomic, assign) NSInteger priceTypeId;
@property (nonatomic, strong) NSString * provider;
@property (nonatomic, assign) NSInteger refundSupportType;
@property (nonatomic, assign) NSInteger serialState;
@property (nonatomic, strong) NSString * tags;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) UIImage * musicIcon;
@property (nonatomic, assign) NSInteger trackId;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, strong) NSString * trackTitle;
@property (nonatomic, assign) NSInteger tracks;
@property (nonatomic, assign) NSInteger uid;

@property (nonatomic, strong) NSString * createdAt;
@property (nonatomic, strong) NSString * playUrl64;
@property (nonatomic, strong) NSString * playUrl32;
@property (nonatomic, strong) NSString * playPathHq;
@property (nonatomic, strong) NSString * playPathAacv164;
@property (nonatomic, strong) NSString * playPathAacv224;
@end

NS_ASSUME_NONNULL_END
