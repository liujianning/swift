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

extension UITableView{
    
    convenience init (frame:CGRect, bColor:UIColor, style:UITableView.Style, tag:Int) {
        self.init(frame: frame ,style: style)
        backgroundColor = bColor
        self.tag = tag
    }
    
}


