//
//  Date+Extension.swift
//  swiftTest
//
//  Created by LiuJianning on 2019/4/28.
//  Copyright © 2019 ljn. All rights reserved.
//

import UIKit

extension Date {
    /// 获取当前 毫秒级 时间戳 - 13位
    public var getTimestamp : Int64 {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000)) as Int64
        return millisecond
    }
}


