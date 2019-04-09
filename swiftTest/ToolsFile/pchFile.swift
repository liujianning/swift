//
//  pchFile.swift
//  swiftTest
//
//  Created by LJN-PlatformTwo on 2019/3/22.
//  Copyright © 2019 ljn. All rights reserved.
//

import UIKit

//MARK: 屏幕宽度
let KScreenW = UIScreen.main.bounds.width

//MARK: 屏幕高度
let KScreenH = UIScreen.main.bounds.height

//MARK: 判断是否是全面屏
var IsFullScreen: Bool {
    if #available(iOS 11, *) {
        guard let w = UIApplication.shared.delegate?.window, let unwrapedWindow = w else {
            return false
        }
        if unwrapedWindow.safeAreaInsets.left > 0 || unwrapedWindow.safeAreaInsets.bottom > 0 {
            print(unwrapedWindow.safeAreaInsets)
            return true
        }
    }
    return false
}

//MARK: 状态栏高度
let KStatusbarHeight = UIApplication.shared.statusBarFrame.height

//MARK: 自定义的导航栏高度
let KNavbarHeight = KStatusbarHeight+40

//MARK: 获取根控制器
var KRootVC = UIApplication.shared.keyWindow?.rootViewController

//MARK: 显示无网络提示
var KShowNoNetMsg: Void {
    let baseVC = baseViewController()
    UIAlertController.showAlert(message: "网络未连接", in:KRootVC ?? baseVC)
}

