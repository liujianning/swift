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

extension UILabel{
    
     convenience init (frame:CGRect, bColor:UIColor, tag:Int) {
        self.init()
        self.frame = frame
        backgroundColor = bColor
        self.tag = tag
    }
    
    convenience init (frame:CGRect, bColor:UIColor, textColor:UIColor,  title:String, fontSize:CGFloat, alignment:NSTextAlignment, tag:Int) {
        self.init(frame:frame, bColor:bColor, tag:tag)
        text = title
        textAlignment = alignment
        self.textColor = textColor
        font = UIFont.systemFont(ofSize: fontSize)
    }
    
    convenience init (frame:CGRect, bColor:UIColor, textColor:UIColor,  title:String, fontSize:CGFloat, alignment:NSTextAlignment, cornerSize:CGFloat, tag:Int) {
        self.init(frame: frame, bColor: bColor, textColor: textColor, title: title, fontSize: fontSize, alignment: alignment, tag:tag)
        layer.masksToBounds = true
        layer.cornerRadius = cornerSize
    }
    
    convenience init (linelableFrame:CGRect, bColor:UIColor, tag:Int) {
        self.init(frame:linelableFrame, bColor:bColor, tag:tag)
    }
    
    
    
}


