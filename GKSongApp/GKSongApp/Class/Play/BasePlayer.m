//
//  BasePlayer.m
//  GKSongApp
//
//  Created by wangws1990 on 2019/6/10.
//  Copyright © 2019 王炜圣. All rights reserved.
//

#import "BasePlayer.h"
#import <FSAudioStream.h>
@interface BasePlayer()
@property (strong, nonatomic) FSAudioStream *audioStream;


@property (assign, nonatomic) BasePlayerState playerState;
@property (assign, nonatomic) BaseBufferState bufferState;

@property (assign, nonatomic) CGFloat bufferProgress;//缓冲进度
@property (assign, nonatomic) NSTimeInterval playTime;//播放进度
@property (assign, nonatomic) NSTimeInterval totalTime;//播放时长
@end
@implementation BasePlayer
+ (instancetype)sharedInstance{
    static BasePlayer *_player = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_player) {
            _player = [[BasePlayer alloc] init];
        }
    });
    return _player;
}
- (instancetype)init{
    if (self = [super init]) {
        __weak __typeof(self) weakSelf = self;
        [self.audioStream setOnCompletion:^{
            NSLog(@"播放完成");
        }];
        [self.audioStream setOnFailure:^(FSAudioStreamError error, NSString *description) {
            NSLog(@"播放过程中发生错误，错误信息：%@",description);
        }];
        [self.audioStream setOnStateChange:^(FSAudioStreamState state) {
            switch (state) {
                case kFsAudioStreamRetrievingURL:       // 检索url
                    NSLog(@"检索url");
                    weakSelf.playerState = BasePlayerStateLoading;
                    break;
                case kFsAudioStreamBuffering:           // 缓冲
                    NSLog(@"缓冲中。。");
                    weakSelf.playerState = BasePlayerStateBuffering;
                    weakSelf.bufferState = BaseBufferStateBuffering;
                    break;
                case kFsAudioStreamSeeking:             // seek
                    NSLog(@"seek中。。");
                    weakSelf.playerState = BasePlayerStateLoading;
                    break;
                case kFsAudioStreamPlaying:             // 播放
                    NSLog(@"播放中。。");
                    weakSelf.playerState = BasePlayerStatePlaying;
                    break;
                case kFsAudioStreamPaused:              // 暂停
                    NSLog(@"播放暂停");
                    weakSelf.playerState = BasePlayerStatePaused;
                    break;
                case kFsAudioStreamStopped:              // 停止
                    
                    // 切换歌曲时主动调用停止方法也会走这里，所以这里添加判断，区分是切换歌曲还是被打断等停止
                    if (weakSelf.playerState != BasePlayerStateStoppedBy && weakSelf.playerState != BasePlayerStateEnded) {
                        NSLog(@"播放停止被打断");
                        weakSelf.playerState = BasePlayerStateStopped;
                    }
                    break;
                case kFsAudioStreamRetryingFailed:              // 检索失败
                    NSLog(@"检索失败");
                    weakSelf.playerState = BasePlayerStateError;
                    break;
                case kFsAudioStreamRetryingStarted:             // 检索开始
                    NSLog(@"检索开始");
                    weakSelf.playerState = BasePlayerStateLoading;
                    break;
                case kFsAudioStreamFailed:                      // 播放失败
                    NSLog(@"播放失败");
                    weakSelf.playerState = BasePlayerStateError;
                    break;
                case kFsAudioStreamPlaybackCompleted:           // 播放完成
                    NSLog(@"播放完成");
                    weakSelf.playerState = BasePlayerStateEnded;
                    break;
                case kFsAudioStreamRetryingSucceeded:           // 检索成功
                    NSLog(@"检索成功");
                    weakSelf.playerState = BasePlayerStateLoading;
                    break;
                case kFsAudioStreamUnknownState:                // 未知状态
                    NSLog(@"未知状态");
                    weakSelf.playerState = BasePlayerStateError;
                    weakSelf.bufferState = BaseBufferStateNone;
                    break;
                case kFSAudioStreamEndOfFile:                   // 缓冲结束
                    NSLog(@"缓冲结束");
                    weakSelf.bufferState = BaseBufferStateFinished;
                    break;
                default:
                    break;
            }
        }];
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2 block:^(NSTimer * _Nonnull timer) {
            NSLog(@"%f %f %f",weakSelf.bufferProgress,weakSelf.playTime,weakSelf.totalTime);
        } repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
    return self;
}
- (void)setPlayUrl:(NSString *)playUrl{
    if (![_playUrl isEqualToString:playUrl]) {
        _playUrl = playUrl;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.audioStream playFromURL:[NSURL URLWithString:playUrl]];
        });
    }
}
- (void)setVolume:(CGFloat)volume{
    _volume = volume;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.audioStream setVolume:volume];
    });
}
- (void)setRate:(CGFloat)rate{
    _rate  = rate;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.audioStream setPlayRate:rate];
    });
}
- (void)setPlayerState:(BasePlayerState)playerState{
    if (_playerState != playerState) {
        _playerState = playerState;
        if ([self.delegate respondsToSelector:@selector(basePlayer:status:)]) {
            [self.delegate basePlayer:self status:playerState];
        }
    }
}
- (void)setBufferState:(BaseBufferState)bufferState{
    if (_bufferState != bufferState) {
        _bufferState = bufferState;
    }
}
- (void)seek:(CGFloat)seek{
    FSSeekByteOffset offset = {0};
    offset.position = seek;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.audioStream playFromOffset:offset];
    });
}
- (void)play{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.audioStream play];
    });
}
- (void)stop{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.audioStream stop];
    });
}
- (void)pause{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.audioStream.isPlaying) {
            [self.audioStream pause];
        }
    });
}
- (void)resume{
    if (self.playerState == BasePlayerStatePlaying) return;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.audioStream pause];
    });
}
- (CGFloat)bufferProgress{
    NSAssert([NSThread isMainThread], @"FSAudioStream.currentTimePlayed needs to be called in the main thread");
    float preBuffer      = (float)self.audioStream.prebufferedByteCount;
    float contentLength  = (float)self.audioStream.contentLength;
    float bufferProgress = contentLength > 0 ? preBuffer / contentLength : 0;
    return bufferProgress;
}
- (NSTimeInterval)playTime{
    NSAssert([NSThread isMainThread], @"FSAudioStream.currentTimePlayed needs to be called in the main thread");
    FSStreamPosition cur = self.audioStream.currentTimePlayed;
    NSTimeInterval progress = cur.playbackTimeInSeconds;
    return progress;
}
- (NSTimeInterval)totalTime{
    NSAssert([NSThread isMainThread], @"FSAudioStream.currentTimePlayed needs to be called in the main thread");
    NSTimeInterval time = self.audioStream.duration.playbackTimeInSeconds;
    return time;
}
- (void)removeCache {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSArray *arr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.audioStream.configuration.cacheDirectory error:nil];
        
        for (NSString *filePath in arr) {
            if ([filePath hasPrefix:@"FSCache-"]) {
                NSString *path = [NSString stringWithFormat:@"%@/%@", self.audioStream.configuration.cacheDirectory, filePath];
                [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
            }
        }
    });
}
#pragma mark get
- (FSAudioStream *)audioStream {
    if (!_audioStream) {
        FSStreamConfiguration *configuration = [FSStreamConfiguration new];
        configuration.enableTimeAndPitchConversion = YES;
        
        _audioStream = [[FSAudioStream alloc] initWithConfiguration:configuration];
        _audioStream.strictContentTypeChecking = NO;
        _audioStream.defaultContentType = @"audio/x-m4a";
    }
    return _audioStream;
}
@end
