//
//  baseViewController.swift
//  swiftTest
//
//  Created by LJN-PlatformTwo on 2019/3/22.
//  Copyright © 2019 ljn. All rights reserved.
//

import UIKit

class baseViewController: UIViewController {

    lazy var backView = UIView.init(frame: CGRect(x: 0, y: 0, width: KScreenW, height: KNavbarHeight), bColor: UIColor.white, tag: 101)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true //隐藏u原生navigationBar
    }

    func addTopTitle(title:String) {
        self.view.addSubview(backView)
        let lable = UILabel.init(frame: CGRect(x: 0, y: KStatusbarHeight, width: KScreenW, height: KNavbarHeight-KStatusbarHeight), bColor: UIColor.white, textColor: UIColor.black, title: title, fontSize: 16, alignment: .center, tag: 100)
        backView.addSubview(lable)
        let lineLable = UILabel.init(linelableFrame: CGRect(x: 0, y: lable.bottom-0.5, width: KScreenW, height: 0.5), bColor: UIColor.lightGray, tag: 101)
        backView.addSubview(lineLable)
    }
    
    func addBackButton() {
        let backButton = UIButton.init(frame: CGRect(x: 10, y: KStatusbarHeight, width: 30, height: 30), bColor: UIColor.red, tag: 103)
        backButton.addTarget(self, action: #selector(backButtonAction(backButton:)), for: .touchUpInside)
        backView.addSubview(backButton)
    }
    
    @objc func backButtonAction(backButton:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    

}
