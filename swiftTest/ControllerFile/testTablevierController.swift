//
//  testTablevierController.swift
//  swiftTest
//
//  Created by LJN-PlatformTwo on 2019/3/22.
//  Copyright © 2019 ljn. All rights reserved.
//

import UIKit

class testTablevierController: baseViewController , UITableViewDelegate, UITableViewDataSource{
    
    var mainTableview = UITableView()
    var allDataArr = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.addTopTitle(title: "tableview练习")
        self.addBackButton()
        self.addMainTableView()
        self.loadMainData()
    }
    
    /// 网络请求
    func loadMainData() {
        NetClass.postRequest(parameters: ["method": "indexProduct", "productType": "2"]){
            (result:[String:Any]) in
            let respose = result
            let list = respose["list"] as? NSArray
            self.allDataArr =  testModel.modelChange(arr: list as? Array<Any> ?? [] )
        
            
            self.mainTableview.reloadData()
            
           

            
            
        }
    }
    
    fileprivate func addMainTableView() {
        mainTableview = UITableView.init(frame: CGRect(x: 0, y: KNavbarHeight, width: KScreenW, height: KScreenH-KNavbarHeight), bColor: UIColor.lightGray, style: .plain, tag: 100)
        mainTableview.delegate = self
        mainTableview.dataSource = self
        self.view.addSubview(mainTableview)
        mainTableview.register(testTableviewCell.classForCoder(), forCellReuseIdentifier:"identifier")
        mainTableview.tableFooterView = UIView.init()
        
    }

    //MARK: === UITableViewDelegate ====
    func numberOfSections(in tableView:UITableView) ->Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allDataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "identifier", for: indexPath) as! testTableviewCell
        if allDataArr.count > 0 {
            cell.reloadCellData(model: allDataArr[indexPath.row] as! testModel)
        }
        
        return cell
    }
    
    

}
