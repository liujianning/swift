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
        self.view.backgroundColor = UIColor.purple
        self.addTopTitle(title: "首页")

        for i in 0...3 {
            let button  = UIButton.init(frame:CGRect(x: 30, y: 100+25*i, width: 100, height: 20) , bColor: UIColor.red, text: "asdada", textColor: UIColor.black, textFont: 12, tag: 100+i)
            self.view.addSubview(button)
            button.addTarget(self, action: #selector(buttonAction(button:)), for: .touchUpInside)
        }
    }
    
    @objc func buttonAction(button:UIButton){
        
        if button.tag == 100 {
            let testTableview = testTablevierController()
            testTableview.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(testTableview, animated: true)
        }
        
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
