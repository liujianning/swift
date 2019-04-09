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

extension UIButton{
    
     convenience init (frame:CGRect, bColor:UIColor, tag:Int) {
        self.init()
        self.frame = frame
        backgroundColor = bColor
        self.tag = tag
    }
    
    
   convenience init (frame:CGRect,
                      bColor:UIColor,
                      normalImg:UIImage,
                      selectimg:UIImage,
                      tag:Int) {
        self.init(frame: frame, bColor: bColor, tag: tag)
        setBackgroundImage(normalImg, for: .normal)
        setBackgroundImage(selectimg, for: .selected)
    }
    
    convenience init (frame:CGRect,
                      bColor:UIColor,
                      text:String,
                      textColor:UIColor,
                      textFont:CGFloat,
                      tag:Int) {
        self.init(frame: frame, bColor: bColor, tag: tag)
        setTitle(text, for: .normal)
        setTitleColor(textColor, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: textFont)
    }
    
    convenience init (frame:CGRect,
                      bColor:UIColor,
                      text:String,
                      textColor:UIColor,
                      textFont:CGFloat,
                      cornerSize:CGFloat,
                      tag:Int) {
        self.init(frame:frame, bColor:bColor, text:text, textColor:textColor, textFont:textFont, tag:tag)
        layer.masksToBounds = true //会造成离屏渲染,在一定程度上影响性能.最好自己绘制圆角
        layer.cornerRadius = cornerSize
    }
    
    convenience init (frame:CGRect,
                      bColor:UIColor,
                      text:String, 
                      textColor:UIColor,
                      textFont:CGFloat,
                      cornerSize:CGFloat,
                      borderWidth:CGFloat,
                      borderColor:UIColor,
                      tag:Int) {
        self.init(frame:frame, bColor:bColor, text:text, textColor:textColor, textFont:textFont, cornerSize:cornerSize, tag:tag)
        layer.masksToBounds = true
        layer.cornerRadius = cornerSize
        layer.borderWidth = borderWidth;
        layer.borderColor = borderColor.cgColor;
    }
    
}


