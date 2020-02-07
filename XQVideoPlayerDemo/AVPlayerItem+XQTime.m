//
//  AVPlayerItem+XQTime.m
//  XQVideoPlayerDemo
//
//  Created by sinking on 2020/2/7.
//  Copyright © 2020 sinking. All rights reserved.
//

#import "AVPlayerItem+XQTime.h"

#import <AppKit/AppKit.h>


@implementation AVPlayerItem (XQTime)


/// 获取当前进度多少秒
- (int)xq_time_getCurrentSeconds {
    float currentProgress = self.currentTime.value / (float)self.currentTime.timescale;
    return currentProgress;
}


/// 设置到指定进度
/// @param seconds 秒
- (void)xq_seekToTime:(int)seconds {
    CMTime time = CMTimeMakeWithSeconds(seconds, self.duration.timescale);
    [self seekToTime:time completionHandler:^(BOOL finished) {
        NSLog(@"seekToTime: %d", finished);
    }];
    
    // 有些人说要用这个，上面那个会有误差?
    // 目前没有发现什么误差
    //    [self.playerView.player seekToTime:time toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero completionHandler:^(BOOL finished) {
    //        NSLog(@"seekToTime: %d", finished);
    //    }];
}

/// 在当前进度上，前进or后退多少秒
/// @param seconds 前进or后退多少秒
/// @param forward YES前进, NO后退
- (void)xq_seekToTime:(int)seconds forward:(BOOL)forward {
    
    int currentSeconds = [self xq_time_getCurrentSeconds];
    
    if (forward) {
        currentSeconds += seconds;
    }else {
        currentSeconds -= seconds;
    }
    
    ///
    /// 参数1: 秒
    /// 参数2: 帧数(???也不知道是不是这样理解, 反正填 CMTime 的 timescale)
    ///
    CMTime time = CMTimeMakeWithSeconds(currentSeconds, self.duration.timescale);
    
    [self seekToTime:time completionHandler:^(BOOL finished) {
        NSLog(@"seekToTime: %d", finished);
    }];
    
}

@end
