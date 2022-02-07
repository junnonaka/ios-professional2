//
//  DecimelUtil.swift
//  Banky2
//
//  Created by 野中淳 on 2022/02/11.
//

import Foundation
extension Decimal{
    var doubleValue:Double{
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
