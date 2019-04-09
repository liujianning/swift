//
//  viewExtension.swift
//  swiftTest
//
//  Created by LJN-PlatformTwo on 2019/3/22.
//  Copyright © 2019 ljn. All rights reserved.
//

/*
 *=============== 延展类
 */

import UIKit

//MARK: ====  UIAlertController  延展
//MARK: =====================
extension UIAlertController {
    
    static func showAlert(message: String, in viewController: UIViewController){
        let al = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        al.addAction(UIAlertAction(title: "确定", style: .cancel))
        viewController.present(al, animated: true)
    }
    

    //    ///在指定视图控制器上弹出普通消息提示框
//
//
//                    //在根视图控制器上弹出普通消息提示框
//                    static func showAlert(message: String) {
//                                        if let vc = UIApplication.shared.keyWindow?.rootViewController {
//                                                            showAlert(message: message, in: vc)
//                                            }
//                        }
//                    //在指定视图控制器上弹出确认框
//                    static func showConfirm(message: String, in viewController: UIViewController,
//                                                                                                                                                                    confirm: ((UIAlertAction)->Void)?) {
//                                        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
//                                        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
//                                        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: confirm))
//                                        viewController.present(alert, animated: true)
//                        }
//                    //在根视图控制器上弹出确认框
//                    static func showConfirm(message: String, confirm: ((UIAlertAction)->Void)?) {
//                                        if let vc = UIApplication.shared.keyWindow?.rootViewController {
//                                                            showConfirm(message: message, in: vc, confirm: confirm)
//                                            }
//                        }
}
