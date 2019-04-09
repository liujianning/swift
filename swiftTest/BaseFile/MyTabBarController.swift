//
//  myTabBarController.swift
//  swiftTest
//
//  Created by LJN-PlatformTwo on 2019/3/20.
//  Copyright © 2019 ljn. All rights reserved.
//

import UIKit

class myTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.barTintColor = UIColor.white
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12.0)], for: .selected)
        // 修改标签栏未选中时文字颜色、字体
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12.0)], for: .normal)
        // 设置字体偏移
//        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: 0.0)
        self.addChildVC()
    }
    
    fileprivate func addChildVC() {
        self.setupOneChildViewController(rootController(), title: "首页", normalImage: "onetabbarimg-unselect.png", selectedImage: "onetabbarimg-select.png")
        self.setupOneChildViewController(ViewController(), title: "我", normalImage: "twotabbarimg-unselect.png", selectedImage: "twotabbarimg-select.png")
    }
    
    fileprivate func setupOneChildViewController(_ vc: UIViewController,
                                                 title: String,
                                                 normalImage: String,
                                                 selectedImage: String)
    {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem = UITabBarItem(title: title, image: UIImage(named: ""), selectedImage: UIImage(named: selectedImage))
        nav.tabBarItem.image = UIImage(named: normalImage)?.withRenderingMode(.alwaysOriginal) //取消未点击下默认值为灰色的问题
        nav.tabBarItem.selectedImage = nav.tabBarItem.selectedImage!.withRenderingMode(.alwaysOriginal) //取消点击后默认为蓝色的问题
        
        nav.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        addChild(nav)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
