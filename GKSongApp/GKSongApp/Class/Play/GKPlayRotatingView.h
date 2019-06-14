//
//  RotatingView.h
//  AudioPlayer
//
//  Created by ClaudeLi on 16/4/12.
//  Copyright © 2016年 ClaudeLi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GKPlayRotatingView : UIView


@end

@interface GKRotatingView : UIView
@property (copy, nonatomic) NSString *url;
// 停止
- (void)pause;
// 恢复
- (void)resume;
// 移除动画
- (void)remove;

@end
