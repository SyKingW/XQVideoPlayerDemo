//
//  ViewController.m
//  XQVideoPlayerDemo
//
//  Created by sinking on 2020/2/7.
//  Copyright © 2020 sinking. All rights reserved.
//

#import "ViewController.h"
#import <AVKit/AVKit.h>
#import <Masonry/Masonry.h>

#import <XQProjectTool/XQAlertSystem.h>
#import <XQProjectTool/XQRegisterHotKey.h>

#import "AVPlayerItem+XQTime.h"
#import "AVPlayer+XQABRepeat.h"


#import "XQVideoPlayerDemo-Swift.h"

typedef NS_ENUM(int, XQKeySignatureType) {
    XQKeySignatureTypeCMD = 1000,
};

typedef NS_ENUM(int, XQKeyIdType) {
    XQKeyTypeCMD1 = 1001,
    XQKeyTypeCMD2 = 1002,
    XQKeyTypeCMD3 = 1003,
    XQKeyTypeCMD4 = 1004,
};

/// 选择视频地址通知

NSNotificationName XQ_Notification_selectVideoPath = @"notification_selectVideoPath";

/// 选择A点
NSNotificationName XQ_Notification_selectAPoint = @"XQ_Notification_selectAPoint";

/// 选择B点
NSNotificationName XQ_Notification_selectBPoint = @"XQ_Notification_selectBPoint";

/// 开始循环A点
NSNotificationName XQ_Notification_startLoopPlayback = @"XQ_Notification_startLoopPlayback";

/// 停止循环
NSNotificationName XQ_Notification_stopLoopPlayback = @"XQ_Notification_stopLoopPlayback";


@interface ViewController ()

@property (nonatomic, strong) AVPlayerView *playerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    [XQProgressHUD xq_initHUD];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification_selectVideoPath:) name:XQ_Notification_selectVideoPath object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification_selectAPoint:) name:XQ_Notification_selectAPoint object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification_selectBPoint:) name:XQ_Notification_selectBPoint object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification_startLoopPlayback:) name:XQ_Notification_startLoopPlayback object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification_stopLoopPlayback:) name:XQ_Notification_stopLoopPlayback object:nil];
    
    self.playerView = [[AVPlayerView alloc] init];
    [self.view addSubview:self.playerView];
    [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    
    // 监听按键
//    [XQRegisterHotKey manager].delegate = self;
//    [[XQRegisterHotKey manager] xq_registerCustomHotKeyWithSignature:XQKeySignatureTypeCMD keyID:XQKeyTypeCMD1 inHotKeyCode:18 modifiers:XQModifiersCmdKeyBit];
//    [[XQRegisterHotKey manager] xq_registerCustomHotKeyWithSignature:XQKeySignatureTypeCMD keyID:XQKeyTypeCMD2 inHotKeyCode:19 modifiers:XQModifiersCmdKeyBit];
//    [[XQRegisterHotKey manager] xq_registerCustomHotKeyWithSignature:XQKeySignatureTypeCMD keyID:XQKeyTypeCMD3 inHotKeyCode:20 modifiers:XQModifiersCmdKeyBit];
//    [[XQRegisterHotKey manager] xq_registerCustomHotKeyWithSignature:XQKeySignatureTypeCMD keyID:XQKeyTypeCMD4 inHotKeyCode:21 modifiers:XQModifiersCmdKeyBit];
}


- (void)viewDidAppear {
    [super viewDidAppear];
    [XQProgressHUD showInfoWithStatus:@"command + O, 选择本地视频文件\n具体操作指令可看左上角"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    NSLog(@"%s, %@, %@", __func__, keyPath, change);
    
    if (context == (__bridge void * _Nullable)(self.playerView)) {
        
        if ([keyPath isEqualToString:@"status"]) {
            
            if (self.playerView.player.status == AVPlayerStatusReadyToPlay) {
                // 视频资源准备完成
                
            }
            
//            NSNumber *nValue = change[NSKeyValueChangeNewKey];
//            [nValue intValue];
            
        }
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


#pragma mark - notification

- (void)notification_selectVideoPath:(NSNotification *)notification {
    
    NSString *path = notification.userInfo[@"path"];
    
    NSLog(@"选择视频: %@", path);
    
    if (self.playerView.player) {
        // 停止以前的AB点
        [self.playerView.player xq_ABLoopPlaybackWithStart:NO];
        [self.playerView.player removeObserver:self forKeyPath:@"status"];
        [self.playerView.player pause];
    }
    
    self.playerView.player = [AVPlayer playerWithURL:[NSURL fileURLWithPath:path]];
    [self.playerView.player play];
    
    // 通过KVO来观察status属性的变化，来获得播放之前的错误信息
    [self.playerView.player addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:(__bridge void * _Nullable)(self.playerView)];
}

- (void)notification_selectAPoint:(NSNotification *)notification {
    [self judgePlayerAlert];
    self.playerView.player.xq_APoint = [self.playerView.player.currentItem xq_time_getCurrentSeconds];
}

- (void)notification_selectBPoint:(NSNotification *)notification {
    [self judgePlayerAlert];
    self.playerView.player.xq_BPoint = [self.playerView.player.currentItem xq_time_getCurrentSeconds];
}

- (void)notification_startLoopPlayback:(NSNotification *)notification {
    [self judgePlayerAlert];
    [self.playerView.player xq_ABLoopPlaybackWithStart:YES];
}

- (void)notification_stopLoopPlayback:(NSNotification *)notification {
    [self judgePlayerAlert];
    [self.playerView.player xq_ABLoopPlaybackWithStart:NO];
}

- (void)judgePlayerAlert {
    if (!self.playerView.player) {
        [XQProgressHUD showInfoWithStatus:@"请先选择本地视频"];
    }
}


@end









