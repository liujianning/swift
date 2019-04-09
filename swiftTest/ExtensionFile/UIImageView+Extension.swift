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

//MARK: ====  UIImageView  延展
//MARK: ==================
extension UIImageView{
    public func imageUrl(urlStr : String){
        let url = URL(string: urlStr)!
        let request = URLRequest(url: url)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: {
            (data, response, error) -> Void in
            if error != nil{
                print(error.debugDescription)
            }else{
                let img = UIImage(data:data!)
                DispatchQueue.main.async {
                    self.image = img
                }
            }
        }) as URLSessionTask
        dataTask.resume()
    }
}


