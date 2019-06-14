//
//  BasePlayer.h
//  GKSongApp
//
//  Created by wangws1990 on 2019/6/10.
//  Copyright © 2019 王炜圣. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, BasePlayerState) {
    BasePlayerStateLoading,          // 加载中
    BasePlayerStateBuffering,        // 缓冲中
    BasePlayerStatePlaying,          // 播放
    BasePlayerStatePaused,           // 暂停
    BasePlayerStateStoppedBy,        // 停止（用户切换歌曲时调用）
    BasePlayerStateStopped,          // 停止（播放器主动发出：如播放被打断）
    BasePlayerStateEnded,            // 结束（播放完成）
    BasePlayerStateError             // 错误
};
typedef NS_ENUM(NSUInteger, BaseBufferState) {
    BaseBufferStateNone,
    BaseBufferStateBuffering,
    BaseBufferStateFinished
};
@class  BasePlayer;
@protocol BasePlayerDelegate<NSObject>
@optional
- (void)basePlayer:(BasePlayer *)player status:(BasePlayerState)status;
@end

@interface BasePlayer : NSObject
@property (copy, nonatomic) NSString *playUrl;//本地或者网络
@property (assign, nonatomic) id<BasePlayerDelegate>delegate;
@property (assign, nonatomic) CGFloat rate;//速率Volume
@property (assign, nonatomic) CGFloat volume;//音量

@property (assign, nonatomic,readonly) CGFloat bufferProgress;//缓冲进度
@property (assign, nonatomic,readonly) NSTimeInterval playTime;//播放进度
@property (assign, nonatomic,readonly) NSTimeInterval totalTime;//播放时长
@property (assign, nonatomic,readonly) BasePlayerState playerState;
@property (assign, nonatomic,readonly) BaseBufferState bufferState;
/**
 单例
 */
+ (instancetype)sharedInstance;
/**
 @brief指定时间点播放
 */
- (void)seek:(CGFloat)seek;
/**
 @brief播放
 */
- (void)play;
/**
 @brief停止
 */
- (void)stop;
/**
@brief暂停
 */
- (void)pause;

/**
 @brief恢复（暂停后再次播放使用）
 */
- (void)resume;
@end

NS_ASSUME_NONNULL_END
