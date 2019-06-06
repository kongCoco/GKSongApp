//
//  GKSoneNetManager.h
//  GKSongApp
//
//  Created by wangws1990 on 2019/6/5.
//  Copyright © 2019 王炜圣. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GKSoneNetManager : NSObject
+ (void)homeSong:(NSString *)categoryId success:(void(^)(id object))success failure:(void(^)(NSString *error))failure;
+ (void)homeClass:(NSString *)categoryId success:(void(^)(id object))success failure:(void(^)(NSString *error))failure;
+ (void)homeClssItem:(NSString *)categoryId tagName:(NSString *)tagName page:(NSInteger)page success:(void(^)(id object))success failure:(void(^)(NSString *error))failure;
+ (void)songDetail:(NSString *)albumId title:(NSString *)title page:(NSInteger)page success:(void(^)(id object))success failure:(void(^)(NSString *error))failure;
@end

NS_ASSUME_NONNULL_END
