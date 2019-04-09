//
//  NetClass.swift
//  swiftTest
//
//  Created by LJN-PlatformTwo on 2019/3/21.
//  Copyright © 2019 ljn. All rights reserved.
//

// 网络类

import UIKit
import Alamofire

class NetClass: NSObject {
    static let baseUrl_product = "http://api-app.kgc.cn/kgcapi/services/youke"
    
    //    class func postRequest(parameters:NSMutableDictionary, callBack: @escaping ((_ result: NSDictionary?, _ error: Error?) -> ())) ->()  {

    // MARK: === POS请求 ===
    class func postRequest(parameters:NSMutableDictionary,
                           callBack: @escaping (_ result: [String:Any]) -> ()
        )  {
        parameters["osType"] = "iPhone"
        parameters["version"] = "5.1.4"
        print("boday = \(parameters)")
        
        let parameters = parameters as! [String : Any]
        Alamofire.request(baseUrl_product, method: .post, parameters: parameters, encoding: URLEncoding.httpBody).responseJSON {response in
            if response.result.isSuccess == true   {
                let result  = response.result.value
                callBack(result as! [String : Any])
                return
            }
            KShowNoNetMsg
        }
    }
}
