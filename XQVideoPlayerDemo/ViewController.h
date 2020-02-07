//
//  ViewController.h
//  XQVideoPlayerDemo
//
//  Created by sinking on 2020/2/7.
//  Copyright © 2020 sinking. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/// 选择视频地址通知
extern NSNotificationName XQ_Notification_selectVideoPath;

/// 选择A点
extern NSNotificationName XQ_Notification_selectAPoint;

/// 选择B点
extern NSNotificationName XQ_Notification_selectBPoint;

/// 开始循环A点
extern NSNotificationName XQ_Notification_startLoopPlayback;

/// 停止循环
extern NSNotificationName XQ_Notification_stopLoopPlayback;

@interface ViewController : NSViewController


@end

