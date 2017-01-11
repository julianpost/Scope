//
//  DateHandler.swift
//  NOAA
//
//  Created by Julian Post on 7/26/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//

import Foundation
import UIKit

class DateFunctions {
    
    static func stringToDate(_ string: String) -> Date {
        var date: Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        date = dateFormatter.date(from: string)!
        
        return date
        
        
    }
    
    static func dateToDarkSkyString(_ date: Date) -> String {
        var string: String
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "[yyyy]-[MM]-[dd]T[HH]:[mm]:[ss]"
        string = dateFormatter.string(from: date)
        
        return string
        
        
    }

    static func currentYearStartMath(todaysDate: Date) -> Date {
        
        let userCalendar = Calendar.current
        
        let today = Calendar.current.startOfDay(for: todaysDate)
        
        let requestedDateComponents: NSCalendar.Unit = [.year, .month, .day]
        
        var todaysDateComponents = (userCalendar as NSCalendar).components(requestedDateComponents, from: today)
        
        todaysDateComponents.month = 1
        todaysDateComponents.day = 1
        
        return userCalendar.date(from: todaysDateComponents)!
        
    }
    
    static func currentYearEndMath(_ todaysDate: Date) -> Date {
        
        let today = Calendar.current.startOfDay(for: todaysDate)
        
        let endDate = today
        return endDate
    }
    
    static func currentMonthStartMath(_ todaysDate: Date) -> Date {
        
        let userCalendar = Calendar.current
        
        let today = Calendar.current.startOfDay(for: todaysDate)
        
        let requestedDateComponents: NSCalendar.Unit = [.year, .month, .day]
        
        var todaysDateComponents = (userCalendar as NSCalendar).components(requestedDateComponents, from: today)
        
        todaysDateComponents.day! -= 28
        
        return userCalendar.date(from: todaysDateComponents)!
        
        /*  let userCalendar = Calendar.current
        
        let today = Calendar.current.startOfDay(for: todaysDate)
        
        let requestedDateComponents: NSCalendar.Unit = [.year, .month, .day]
        
        var todaysDateComponents = (userCalendar as NSCalendar).components(requestedDateComponents, from: today)
        
        todaysDateComponents.day = 1
        
        return userCalendar.date(from: todaysDateComponents)!*/
        
    }
    
    static func currentMonthEndMath(_ todaysDate: Date) -> Date {
      
        let today = Calendar.current.startOfDay(for: todaysDate)
        
        let endDate = today
        return endDate
        
      /*  let startOfMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: todaysDate)))!
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!*/
    }
    
    static func currentWeekStartMath(_ todaysDate: Date) -> Date {
        
        let userCalendar = Calendar.current
        
        let today = Calendar.current.startOfDay(for: todaysDate)
        
        let requestedDateComponents: NSCalendar.Unit = [.year, .month, .day]
        
        var todaysDateComponents = (userCalendar as NSCalendar).components(requestedDateComponents, from: today)
        
        todaysDateComponents.day! -= 7
        
        return userCalendar.date(from: todaysDateComponents)!
        
    }
    
    static func currentWeekEndMath(_ todaysDate: Date) -> Date {
        
        let today = Calendar.current.startOfDay(for: todaysDate)
        
        let endDate = today
        return endDate
    }
    
    
    static func lastYearStartMath(_ todaysDate: Date) -> Date {
        
        let userCalendar = Calendar.current
        
        let today = Calendar.current.startOfDay(for: todaysDate)
        
        let requestedDateComponents: NSCalendar.Unit = [.year, .month, .day]
        
        var todaysDateComponents = (userCalendar as NSCalendar).components(requestedDateComponents, from: today)
        
        todaysDateComponents.year! -= 1
        todaysDateComponents.month = 1
        todaysDateComponents.day = 1
        
        
        return userCalendar.date(from: todaysDateComponents)!
    }
    
    
    static func lastYearEndMath(_ todaysDate: Date) -> Date {
        
        let userCalendar = Calendar.current
        
        let today = Calendar.current.startOfDay(for: todaysDate)
        
        let requestedDateComponents: NSCalendar.Unit = [.year, .month, .day]
        
        var todaysDateComponents = (userCalendar as NSCalendar).components(requestedDateComponents, from: today)
        
        todaysDateComponents.year! -= 1
        todaysDateComponents.month = 12
        todaysDateComponents.day = 31
        
        
        return userCalendar.date(from: todaysDateComponents)!
        
    }
    
    static func normalYearStartMath(_ todaysDate: Date) -> Date {
        
        let userCalendar = Calendar.current
        
        let today = Calendar.current.startOfDay(for: todaysDate)
        
        let requestedDateComponents: NSCalendar.Unit = [.year, .month, .day]
        
        var todaysDateComponents = (userCalendar as NSCalendar).components(requestedDateComponents, from: today)
        
        todaysDateComponents.year = 2010
        todaysDateComponents.month = 1
        todaysDateComponents.day = 1
        
        
        return userCalendar.date(from: todaysDateComponents)!
    }
    
    
    static func normalYearEndMath(_ todaysDate: Date) -> Date {
        
        let userCalendar = Calendar.current
        
        let today = Calendar.current.startOfDay(for: todaysDate)
        
        let requestedDateComponents: NSCalendar.Unit = [.year, .month, .day]
        
        var todaysDateComponents = (userCalendar as NSCalendar).components(requestedDateComponents, from: today)
        
        todaysDateComponents.year = 2010
        todaysDateComponents.month = 12
        todaysDateComponents.day = 31
        
        
        return userCalendar.date(from: todaysDateComponents)!
        
    }
    
    
    static func normalMonthStartMath(_ todaysDate: Date) -> Date {
        
        let userCalendar = Calendar.current
        
        let today = Calendar.current.startOfDay(for: todaysDate)
        
        let requestedDateComponents: NSCalendar.Unit = [.year, .month, .day]
        
        var todaysDateComponents = (userCalendar as NSCalendar).components(requestedDateComponents, from: today)
        
        todaysDateComponents.year = 2010
        todaysDateComponents.day = 1
        
        return userCalendar.date(from: todaysDateComponents)!
        
    }
    
    static func normalMonthEndMath(_ todaysDate: Date) -> Date {
        
        let userCalendar = Calendar.current
        
        let today = Calendar.current.startOfDay(for: todaysDate)
        
        let requestedDateComponents: NSCalendar.Unit = [.year, .month, .day]
        
        var todaysDateComponents = (userCalendar as NSCalendar).components(requestedDateComponents, from: today)
        
        todaysDateComponents.year = 2010
        todaysDateComponents.month! += 1
        todaysDateComponents.day = 1
        todaysDateComponents.day! -= 1
        
        
        return userCalendar.date(from: todaysDateComponents)!
    }
    
    static func normalWeekStartMath(_ todaysDate: Date) -> Date {
        
        let userCalendar = Calendar.current
        
        let today = Calendar.current.startOfDay(for: todaysDate)
        
        let requestedDateComponents: NSCalendar.Unit = [.year, .month, .day]
        
        var todaysDateComponents = (userCalendar as NSCalendar).components(requestedDateComponents, from: today)
        
        todaysDateComponents.year = 2010
        todaysDateComponents.day! -= 7
        
        return userCalendar.date(from: todaysDateComponents)!
        
    }
    
    static func normalWeekEndMath(_ todaysDate: Date) -> Date {
        
        let userCalendar = Calendar.current

        let today = Calendar.current.startOfDay(for: todaysDate)
        
        let requestedDateComponents: NSCalendar.Unit = [.year, .month, .day]
        
        var todaysDateComponents = (userCalendar as NSCalendar).components(requestedDateComponents, from: today)
        
        todaysDateComponents.year = 2010
        
        
        return userCalendar.date(from: todaysDateComponents)!
    }
    
    static func dateReference() -> [Int:Date] {
       
        let userCalendar = Calendar.current
        let today = Calendar.current.startOfDay(for: Date())
        let requestedDateComponents: NSCalendar.Unit = [.year, .month, .day]
        var todaysDateComponents = (userCalendar as NSCalendar).components(requestedDateComponents, from: today)
        
        todaysDateComponents.year = 2010
        todaysDateComponents.month = 1
        todaysDateComponents.day = 1
        
        //userCalendar.date(from: todaysDateComponents)!
        
        var dictionary: [Int:Date] = [:]
        
        for i in 0...364 {
            dictionary[i] = userCalendar.date(from: todaysDateComponents)!
            todaysDateComponents.day! += 1
        }
        return dictionary
    }
}



class DateFor {
    
    var currentYearStart, currentYearEnd, currentMonthStart, currentMonthEnd, currentWeekStart, currentWeekEnd, normalYearStart, normalYearEnd, normalMonthStart, normalMonthEnd, normalWeekStart, normalWeekEnd: Date
    var stringOfCurrentYearStart, stringOfCurrentYearEnd, stringOfCurrentMonthStart, stringOfCurrentMonthEnd, stringOfCurrentWeekStart, stringOfCurrentWeekEnd, stringOfNormalYearStart, stringOfNormalYearEnd, stringOfNormalMonthStart, stringOfNormalMonthEnd, stringOfNormalWeekStart, stringOfNormalWeekEnd: String
    
    init(currentYearStart: Date, currentYearEnd: Date, currentMonthStart: Date, currentMonthEnd: Date, currentWeekStart: Date, currentWeekEnd: Date, normalYearStart: Date, normalYearEnd: Date, normalMonthStart: Date, normalMonthEnd: Date, normalWeekStart: Date, normalWeekEnd: Date, stringOfCurrentYearStart: String, stringOfCurrentYearEnd: String, stringOfCurrentMonthStart: String, stringOfCurrentMonthEnd: String, stringOfCurrentWeekStart: String, stringOfCurrentWeekEnd: String, stringOfNormalYearStart: String, stringOfNormalYearEnd: String, stringOfNormalMonthStart: String, stringOfNormalMonthEnd: String, stringOfNormalWeekStart: String, stringOfNormalWeekEnd: String) {
        
        let todayGlobal = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        
        self.currentYearStart = DateFunctions.currentYearStartMath(todaysDate: todayGlobal)
        self.currentYearEnd = DateFunctions.currentYearEndMath(todayGlobal)
        self.currentMonthStart = DateFunctions.currentMonthStartMath(todayGlobal)
        self.currentMonthEnd = DateFunctions.currentMonthEndMath(todayGlobal)
        self.currentWeekStart = DateFunctions.currentWeekStartMath(todayGlobal)
        self.currentWeekEnd = DateFunctions.currentWeekEndMath(todayGlobal)
        self.normalYearStart = DateFunctions.normalYearStartMath(todayGlobal)
        self.normalYearEnd = DateFunctions.normalYearEndMath(todayGlobal)
        self.normalMonthStart = DateFunctions.normalMonthStartMath(todayGlobal)
        self.normalMonthEnd = DateFunctions.normalMonthEndMath(todayGlobal)
        self.normalWeekStart = DateFunctions.normalWeekStartMath(todayGlobal)
        self.normalWeekEnd = DateFunctions.normalWeekEndMath(todayGlobal)
        
        self.stringOfCurrentYearStart = formatter.string(from: DateFunctions.currentYearStartMath(todaysDate: todayGlobal))
        self.stringOfCurrentYearEnd = formatter.string(from: DateFunctions.currentYearEndMath(todayGlobal))
        self.stringOfCurrentMonthStart = formatter.string(from: DateFunctions.currentMonthStartMath(todayGlobal))
        self.stringOfCurrentMonthEnd = formatter.string(from: DateFunctions.currentMonthEndMath(todayGlobal))
        self.stringOfCurrentWeekStart = formatter.string(from: DateFunctions.currentWeekStartMath(todayGlobal))
        self.stringOfCurrentWeekEnd = formatter.string(from: DateFunctions.currentWeekEndMath(todayGlobal))
        self.stringOfNormalYearStart = formatter.string(from: DateFunctions.normalYearStartMath(todayGlobal))
        self.stringOfNormalYearEnd = formatter.string(from: DateFunctions.normalYearEndMath(todayGlobal))
        self.stringOfNormalMonthStart = formatter.string(from: DateFunctions.normalMonthStartMath(todayGlobal))
        self.stringOfNormalMonthEnd = formatter.string(from: DateFunctions.normalMonthEndMath(todayGlobal))
        self.stringOfNormalWeekStart = formatter.string(from: DateFunctions.normalWeekStartMath(todayGlobal))
        self.stringOfNormalWeekEnd = formatter.string(from: DateFunctions.normalWeekEndMath(todayGlobal))
    }
}

var dateFor = DateFor(currentYearStart: Date(), currentYearEnd: Date(), currentMonthStart: Date(), currentMonthEnd: Date(), currentWeekStart: Date(), currentWeekEnd: Date(), normalYearStart: Date(), normalYearEnd: Date(), normalMonthStart: Date(), normalMonthEnd: Date(), normalWeekStart: Date(), normalWeekEnd: Date(), stringOfCurrentYearStart: "", stringOfCurrentYearEnd: "", stringOfCurrentMonthStart: "", stringOfCurrentMonthEnd: "", stringOfCurrentWeekStart: "", stringOfCurrentWeekEnd: "", stringOfNormalYearStart: "", stringOfNormalYearEnd: "", stringOfNormalMonthStart: "", stringOfNormalMonthEnd: "", stringOfNormalWeekStart: "", stringOfNormalWeekEnd: "")
