//
//  rootController.swift
//  swiftTest
//
//  Created by LJN-PlatformTwo on 2019/3/12.
//  Copyright © 2019 ljn. All rights reserved.
//

import UIKit

class rootController: baseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
        self.addTopTitle(title: "首页")
        self.creatMyListView()
    }
    
    func creatMyListView () {
//        let arr = ["tableview", "2", "3"] as String
        let arr : [String]=["tableview", "数据库_sqlite.swift", "数据库_realm"]

        for i in 0...arr.count-1 {
            let button  = UIButton.init(frame:CGRect(x: 30, y: 100+50*i, width: Int(KScreenW-60), height: 40) , bColor: UIColor.white, text: arr[i], textColor: UIColor.black, textFont: 12, tag: 100+i)
            self.view.addSubview(button)
            button.addTarget(self, action: #selector(buttonAction(button:)), for: .touchUpInside)
        }
    }
    
    @objc func buttonAction(button:UIButton){
        switch button.tag {
        case 100:
            let testTableview = testTablevierController()
            testTableview.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(testTableview, animated: true)
            break
            
        case 101:
            let testTableview = LocalDataController()
            testTableview.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(testTableview, animated: true)
            break
            
        default:
            //
            break
        }
        
    }
    

    
}
