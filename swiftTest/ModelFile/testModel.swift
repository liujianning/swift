//
//  testModel.swift
//  swiftTest
//
//  Created by LiuJianning on 2019/3/26.
//  Copyright © 2019 ljn. All rights reserved.
//

import UIKit

class testModel: NSObject {

    var id: String? = ""
    var  categoryName:String? = ""
    var  image:String? = ""

    class func modelChange(arr:Array<Any>) -> NSMutableArray {
        let modelArr = NSMutableArray.init()
        for dict in arr {
            let model:testModel = testModel ()
            let dict:[String:Any] = dict as! [String : Any]
            model.categoryName = dict["productName"] as? String
            model.id = dict["id"] as? String
            model.image = dict["image"] as? String ?? "0"
            modelArr.add(model)
        }
        return modelArr
    }
    
    
    
    
    
}
