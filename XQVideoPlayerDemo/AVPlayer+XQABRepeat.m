//
//  AVPlayerItem+XQABRepeat.m
//  XQVideoPlayerDemo
//
//  Created by sinking on 2020/2/7.
//  Copyright © 2020 sinking. All rights reserved.
//

#import "AVPlayer+XQABRepeat.h"

#import <AppKit/AppKit.h>

#import <XQProjectTool/NSObject+XQExchangeIMP.h>
#import "AVPlayerItem+XQTime.h"

// AVPeriodicTimebaseObserver
// 循环返回的对象
static id _ab_LoopPlayback_PeriodicTime_obj = nil;

@implementation AVPlayer (XQABRepeat)


/// 开启循环AB点播放
/// @param start YES开始, NO取消
- (int)xq_ABLoopPlaybackWithStart:(BOOL)start {
    
    // 取消上一个监听对象
    if (_ab_LoopPlayback_PeriodicTime_obj) {
        [self removeTimeObserver:_ab_LoopPlayback_PeriodicTime_obj];
        _ab_LoopPlayback_PeriodicTime_obj = nil;
    }
    
    if (start) {
        
        if (self.xq_APoint >= self.xq_BPoint) {
            // B 点不能 等于 or 小于 A点, 不然会开启失败
            return 0;
        }
        
        
        
        // 感觉这些监听进度, 可以留在外面...
        if (!_ab_LoopPlayback_PeriodicTime_obj) {
            
            __weak typeof(self) weakSelf = self;
            CMTime time = CMTimeMakeWithSeconds(1, 1);
            // 持有这个对象, 后面需要取消监听
            _ab_LoopPlayback_PeriodicTime_obj = [self addPeriodicTimeObserverForInterval:time queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
                /// 更新播放进度
                [weakSelf xq_checkAB];
            }];
            
            NSLog(@"%@", _ab_LoopPlayback_PeriodicTime_obj);
        }
        
    }
    
    return 1;
}

- (void)xq_checkAB {
    
    NSLog(@"%s", __func__);
    
    if (self.xq_APoint >= self.xq_BPoint) {
        // B 点不能 等于 or 小于 A点, 不然会开启失败
        return;
    }
    
    if ((self.xq_BPoint - self.xq_APoint) < 3) {
        NSLog(@"设置间隔过短");
        return;
    }
    
    // 当前多少秒
    int currentSeconds = [self.currentItem xq_time_getCurrentSeconds];
    
    
    // 超出范围
    
    if ((currentSeconds - self.xq_BPoint) > 1 ||
        (self.xq_APoint - currentSeconds) > 1 ) {
        NSLog(@"%d, %d, %d", currentSeconds, self.xq_BPoint, self.xq_APoint);
        [self.currentItem xq_seekToTime:self.xq_APoint];
    }
    
}

#pragma mark - get set

- (int)xq_APoint {
    NSNumber *value = [NSObject xq_getAssociatedObject:self key:@"xq_APoint"];
    return [value intValue];
}

- (void)setXq_APoint:(int)xq_APoint {
    [NSObject xq_setAssociatedObject:self key:@"xq_APoint" value:@(xq_APoint) policy:OBJC_ASSOCIATION_RETAIN_NONATOMIC];
}

- (int)xq_BPoint {
    NSNumber *value = [NSObject xq_getAssociatedObject:self key:@"xq_BPoint"];
    return [value intValue];
}

- (void)setXq_BPoint:(int)xq_BPoint {
    [NSObject xq_setAssociatedObject:self key:@"xq_BPoint" value:@(xq_BPoint) policy:OBJC_ASSOCIATION_RETAIN_NONATOMIC];
}


@end
