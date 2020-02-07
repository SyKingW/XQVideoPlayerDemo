//
//  AVPlayerItem+XQTime.h
//  XQVideoPlayerDemo
//
//  Created by sinking on 2020/2/7.
//  Copyright © 2020 sinking. All rights reserved.
//

#import <AppKit/AppKit.h>


#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AVPlayerItem (XQTime)


/// 获取当前进度多少秒
- (int)xq_time_getCurrentSeconds;


/// 设置到指定进度
/// @param seconds 秒
- (void)xq_seekToTime:(int)seconds;

/// 在当前进度上，前进or后退多少秒
/// @param seconds 前进or后退多少秒
/// @param forward YES前进, NO后退
- (void)xq_seekToTime:(int)seconds forward:(BOOL)forward;


@end

NS_ASSUME_NONNULL_END
