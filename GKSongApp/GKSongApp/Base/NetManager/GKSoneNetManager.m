//
//  GKSoneNetManager.m
//  GKSongApp
//
//  Created by wangws1990 on 2019/6/5.
//  Copyright © 2019 王炜圣. All rights reserved.
//

#import "GKSoneNetManager.h"
#import "BaseNetManager.h"
@implementation GKSoneNetManager
+ (void)homeSong:(NSString *)categoryId success:(void(^)(id object))success failure:(void(^)(NSString *error))failure
{
    NSDictionary *params = @{
                             @"categoryId": categoryId?:@"2",
                             @"contentType": @"album",
                             @"version": @"4.3.26.2",
                             @"device": @"ios",
                             @"scale": @(2),
                             };
    [BaseNetManager method:HttpMethodGet urlString:kBaseUrl(@"mobile/discovery/v2/category/recommends") params:params success:success failure:failure];
}
+ (void)homeClass:(NSString *)categoryId success:(void(^)(id object))success failure:(void(^)(NSString *error))failure
{
    NSDictionary *params = @{
                             @"categoryId": categoryId?:@"2",
                             @"contentType": @"album",
                             @"version": @"4.3.26.2",
                             @"device": @"ios",
                             @"scale": @(2),
                             };
    [BaseNetManager method:HttpMethodGet urlString:kBaseUrl(@"mobile/discovery/v2/category/recommends") params:params success:^(id object) {
        !success ?: success(object[@"tags"][@"list"]);
    } failure:failure];
}
+ (void)homeClssItem:(NSString *)categoryId tagName:(NSString *)tagName page:(NSInteger)page success:(void(^)(id object))success failure:(void(^)(NSString *error))failure{
    NSDictionary *params = @{
                                 @"calcDimension": @"hot",
                                 @"categoryId": categoryId?:@"",
                                 @"tagName": tagName?:@"",
                                 @"device": @"ios",
                                 @"pageSize": @(RefreshPageSize),
                                 @"pageId": @(page),
                                 @"status": @"0"
                                 };
    [BaseNetManager method:HttpMethodGet urlString:kBaseUrl(@"mobile/discovery/v1/category/album") params:params success:success failure:failure];
}
+ (void)songDetail:(NSString *)albumId title:(NSString *)title page:(NSInteger)page success:(void(^)(id object))success failure:(void(^)(NSString *error))failure{
    NSDictionary *params = @{
                             @"albumId": albumId?:@"",
                             @"title": title?:@"",
                             @"device": @"ios",
                             @"position": @"1",
                             @"isAsc": @"1"
                             };
    NSString *url = [NSString stringWithFormat:@"mobile/others/ca/album/track/%@/true/%@/%@?",albumId?:@"",@(page),@(RefreshPageSize)];
    [BaseNetManager method:HttpMethodPost urlString:kBaseUrl(url) params:params success:success failure:failure];
}
@end
