//
//  AppDelegate.m
//  XQVideoPlayerDemo
//
//  Created by sinking on 2020/2/7.
//  Copyright © 2020 sinking. All rights reserved.
//

#import "AppDelegate.h"
#import <XQProjectTool/XQOpenPanel.h>
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag {
    NSLog(@"%s", __func__);
    
    if (flag) {
        return NO;
        
    }else {
        [sender.windows.firstObject makeKeyAndOrderFront:nil];
    }
    
    
    return YES;
}

#pragma mark - responds Menu Item

- (IBAction)respondsToOpenFile:(NSMenuItem *)sender {
    NSLog(@"%s", __func__);
    
    [XQOpenPanel beginSheetModalWithWindow:nil configPanel:^(NSOpenPanel *openPanel) {
        
        openPanel.canChooseDirectories = NO;
        [openPanel setAllowedFileTypes:@[@"mp4"]];
        
    } openCallback:^(NSString *path) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:XQ_Notification_selectVideoPath object:nil userInfo:@{@"path": path}];
        
        
    } cancelCallback:nil];
    
}

- (IBAction)respondsToAPoint:(id)sender {
    NSLog(@"command + 1");
    [[NSNotificationCenter defaultCenter] postNotificationName:XQ_Notification_selectAPoint object:nil];
}

- (IBAction)respondsToBPoint:(id)sender {
    NSLog(@"command + 2");
    [[NSNotificationCenter defaultCenter] postNotificationName:XQ_Notification_selectBPoint object:nil];
}

- (IBAction)respondsToStartLoopPlayback:(id)sender {
    NSLog(@"command + 3");
    [[NSNotificationCenter defaultCenter] postNotificationName:XQ_Notification_startLoopPlayback object:nil];
}

- (IBAction)respondsToStopLoopPlayback:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:XQ_Notification_stopLoopPlayback object:nil];
    NSLog(@"command + 4");
}



@end
