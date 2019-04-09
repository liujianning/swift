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

extension UIScrollView{
    
    /// - Parameters:
    ///   - frame: 位置
    ///   - bColor: 背景色
    ///   - size: 内容宽高(w, h)
    ///   - offset: 内容偏移(x, y)
    ///   - isPage: 是否分页
    ///   - isShowH: 是否允许水平滑动
    ///   - isShowV: 是否允许竖直滑动
    convenience init (frame:CGRect, bColor:UIColor, size:CGSize , offset:CGPoint, isPage:Bool,  isShowH:Bool, isShowV:Bool, tag:Int) {
        self.init(frame: frame)
        backgroundColor = bColor
        contentSize = size
        contentOffset = offset
        showsHorizontalScrollIndicator = isShowH //水平
        showsVerticalScrollIndicator = isShowV//竖直
        isPagingEnabled = isPage
        self.tag = tag
    }
    
}


