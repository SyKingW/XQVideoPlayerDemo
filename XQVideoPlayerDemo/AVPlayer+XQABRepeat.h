//
//  AVPlayerItem+XQABRepeat.h
//  XQVideoPlayerDemo
//
//  Created by sinking on 2020/2/7.
//  Copyright © 2020 sinking. All rights reserved.
//

#import <AppKit/AppKit.h>


#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

/// AB点重复播放
@interface AVPlayer (XQABRepeat)


/// A点, 视频的第几秒
@property (nonatomic, assign) int xq_APoint;

/// B点, 视频的第几秒, B 点不能 等于 or 小于 A点
@property (nonatomic, assign) int xq_BPoint;

/// 开启循环AB点播放
/// @param start YES开始, NO取消
///
/// @note B 点不能 等于 or 小于 A点, 不然会开启失败
///
- (int)xq_ABLoopPlaybackWithStart:(BOOL)start;


@end

NS_ASSUME_NONNULL_END
