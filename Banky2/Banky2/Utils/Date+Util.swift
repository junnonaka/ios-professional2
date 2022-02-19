//
//  Date+Util.swift
//  Banky2
//
//  Created by 野中淳 on 2022/02/18.
//

import Foundation

extension Date{
    static var bankeyDateFormatter:DateFormatter{
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "MDT")
        return formatter
    }
    
    var monthDayYearString:String{
        let dataFormatter = Date.bankeyDateFormatter
        dataFormatter.dateFormat = "MMM d yyyy"
        return dataFormatter.string(from: self)
    }
    
    
}
