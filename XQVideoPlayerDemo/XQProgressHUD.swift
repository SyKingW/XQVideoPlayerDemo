//
//  XQProgressHUD.swift
//  XQVideoPlayerDemo
//
//  Created by sinking on 2020/2/8.
//  Copyright © 2020 sinking. All rights reserved.
//

import Foundation


public class XQProgressHUD: NSObject {
    
    @objc public static func xq_initHUD() {
        
    }
    
    @objc public class func showInfoWithStatus(_ status: String) {
        ProgressHUD.showInfoWithStatus(status)
    }
}


