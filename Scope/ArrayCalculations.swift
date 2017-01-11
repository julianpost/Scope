//
//  ArrayCalculations.swift
//  NOAA
//
//  Created by Julian Post on 8/28/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//

import Foundation

class TransformArray {
    
    static func toSimple(_ dictionary: [Date:Float]) -> [Float] {
        
        let sortedArray = dictionary.sorted { $0.0.compare($1.0) == .orderedAscending }
        
        var arr: [Float] = []
        for (_,value) in sortedArray {
            
            arr.append(value)
        }
        return arr
    }
    
    static func toCurrentYear(_ dictionary: [Date:Float]) -> [Float] {
        
       // let dateComponents = DateComponents()
        let calendar = Calendar.current
        let date = dateFor.currentYearStart
        
        let range = calendar.range(of: .day, in: .year, for: date)!
        let numDays = range.count
        
        var arr: [Float] = []
        //let today = Foundation.Date()
        let gregorian: Calendar! = Calendar(identifier: Calendar.Identifier.gregorian)
        
        var start = dateFor.currentYearStart
        //let end = dateFor.currentMonthEnd
        
        //var counter = 0
        
        for i in 0...numDays-1 {
            
            if dictionary[start] == nil {
                let value: Float = 0
                arr.insert(value, at: i)
                
            }
            else {
                
                let value = dictionary[start]
                
                //arr[counter] = value
                arr.insert(value!, at: i)
            }
            
            // increment the date by 1 day
            var dateComponents = DateComponents()
            dateComponents.day = 1
            start = gregorian.date(byAdding: dateComponents, to: start)!
            
            // increment the counter by 1
            
            //counter += 1
        }
        
        
        return arr
    }
   
    static func toNormalYear(_ dictionary: [Date:Float]) -> [Float] {
        
        //let dateComponents = DateComponents()
        let calendar = Calendar.current
        let date = dateFor.normalYearStart
        
        let range = calendar.range(of: .day, in: .year, for: date)!
        let numDays = range.count
        
        var arr: [Float] = []
        //let today = Foundation.Date()
        let gregorian: Calendar! = Calendar(identifier: Calendar.Identifier.gregorian)
        
        var start = dateFor.normalYearStart
        //let end = dateFor.currentMonthEnd
        
        //var counter = 0
        
        for i in 0...numDays-1 {
            
            if dictionary[start] == nil {
                let value: Float = 0
                arr.insert(value, at: i)
                
            }
            else {
                
                let value = dictionary[start]
                
                //arr[counter] = value
                arr.insert(value!, at: i)
            }
            
            // increment the date by 1 day
            var dateComponents = DateComponents()
            dateComponents.day = 1
            start = gregorian.date(byAdding: dateComponents, to: start)!
            
            // increment the counter by 1
            
            //counter += 1
        }
        
        
        return arr
    }

    
    static func toCurrentMonth(_ dictionary: [Date:Float]) -> [Float] {
       
        var arr: [Float] = []
        
        let gregorian: Calendar! = Calendar(identifier: Calendar.Identifier.gregorian)
        
        var start = dateFor.currentMonthStart
        let end = dateFor.currentMonthEnd
        
        var counter = 0
        
        while start.compare(end) != ComparisonResult.orderedSame {
            
            
            if dictionary[start] == nil {
                
                arr.insert(0, at: counter)
            }
                
            else {
                arr.insert(dictionary[start]!, at: counter)
            }
            
            // increment the date by 1 day
            var dateComponents = DateComponents()
            dateComponents.day = 1
            start = gregorian.date(byAdding: dateComponents, to: start)!
            
            counter += 1
        }
        
        
        return arr
        
      /*  let dateComponents = DateComponents()
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        
        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
    
        var arr: [Float] = []
        //let today = Foundation.Date()
        let gregorian: Calendar! = Calendar(identifier: Calendar.Identifier.gregorian)
        
        var start = dateFor.currentMonthStart
        //let end = dateFor.currentMonthEnd
        
        //var counter = 0
        
        for i in 0...numDays-1 {
            
            if dictionary[start] == nil {
                let value: Float = 0
                arr.insert(value, at: i)
            
            }
            else {
                
            let value = dictionary[start]
                
            //arr[counter] = value
            arr.insert(value!, at: i)
            }
            
            // increment the date by 1 day
            var dateComponents = DateComponents()
            dateComponents.day = 1
            start = gregorian.date(byAdding: dateComponents, to: start)!
            
            // increment the counter by 1
            
            //counter += 1
        }

    
        return arr*/
    }
    
    static func toCurrentWeek(_ dictionary: [Date:Float]) -> [Float] {
        
        var arr: [Float] = []
        
        let gregorian: Calendar! = Calendar(identifier: Calendar.Identifier.gregorian)
        
        var start = dateFor.currentWeekStart
        let end = dateFor.currentWeekEnd
        
        var counter = 0
        
        while start.compare(end) != ComparisonResult.orderedSame {
            
            
            if dictionary[start] == nil {
                
                arr.insert(0, at: counter)
            }
            
            else {
                arr.insert(dictionary[start]!, at: counter)
            }
            
            // increment the date by 1 day
            var dateComponents = DateComponents()
            dateComponents.day = 1
            start = gregorian.date(byAdding: dateComponents, to: start)!
            
            counter += 1
        }
        
        
        return arr
    }
    
    static func toNormalMonth(_ dictionary: [Foundation.Date:Float]) -> [Float] {
        
        var arr: [Float] = []
        
        let gregorian: Calendar! = Calendar(identifier: Calendar.Identifier.gregorian)
        
        var start = dateFor.normalMonthStart
        let end = dateFor.normalMonthEnd
        
        while start.compare(end) != ComparisonResult.orderedSame {
            var counter = 0
            
            if let value = dictionary[start] {
                
                arr.insert(value, at: counter)
            }
            
            // increment the date by 1 day
            var dateComponents = DateComponents()
            dateComponents.day = 1
            start = gregorian.date(byAdding: dateComponents, to: start)!
            
            counter += 1
        }
        return arr
    }
    
    static func toNormalWeek(_ dictionary: [Foundation.Date:Float]) -> [Float] {
        
        var arr: [Float] = []
        
        let gregorian: Calendar! = Calendar(identifier: Calendar.Identifier.gregorian)
        
        var start = dateFor.normalWeekStart
        let end = dateFor.normalWeekEnd
        
        while start.compare(end) != ComparisonResult.orderedSame {
            var counter = 0
            
            if let value = dictionary[start] {
    
                arr.insert(value, at: counter)
            }
            
            // increment the date by 1 day
            var dateComponents = DateComponents()
            dateComponents.day = 1
            start = gregorian.date(byAdding: dateComponents, to: start)!
            
            counter += 1
        }
        return arr
    }
    
    static func toDegreeDay(_ baseTemp: Float, maxTemp: Float, tMin: [Float], tMax: [Float]) -> [Float] {
        
        let baseTempFloat = Float(baseTemp)
        let maxTempFloat = Float(maxTemp)
        
        var degreeDay: [Float] = []
        
            for i in 0...tMin.count-1 {
        
                if tMin[i] < baseTempFloat && tMax[i] > maxTempFloat {
            degreeDay.append((baseTempFloat + maxTempFloat)/2 - baseTempFloat)
                }
            
                else if tMin[i] < baseTempFloat {
            degreeDay.append((baseTempFloat + tMax[i])/2 - baseTempFloat)
                }
            
                else if tMax[i] > maxTempFloat {
            degreeDay.append((tMin[i] + maxTempFloat)/2 - baseTempFloat)
                }
            
                else {
            degreeDay.append((tMin[i] + tMax[i])/2 - baseTempFloat)
                }
        }
        
        for i in 0...degreeDay.count-1 {
            if degreeDay[i] < 0 {
                degreeDay[i] = 0
            }
        }
        return degreeDay
    }
    
    static func toCumulative(_ array: [Float]) -> [Float] {
        
        var newArray: [Float] = [array[0]]
    
        for i in 1...array.count-1 {
            
            newArray.append(newArray[i-1] + array[i])
        }
        return newArray
    }
}

   /*
        
        let today = NSDate()
        let gregorian: NSCalendar! = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        
        var precipCalc:[NSDate : Float] = [:]
        var start = Date.lastYearStartMath(today)
        var startMinusOne = Date.lastYearStartMath(today)
        var end = Date.lastYearEndMath(today)
                
        // changes end date to Jan 1 of the next year so loop will complete all 365 values
        let endDateComponents = NSDateComponents()
        endDateComponents.day = 1
        end = gregorian.dateByAddingComponents(endDateComponents, toDate: end, options: NSCalendarOptions(rawValue: 0))!
        
        //changes startMinusOne date so that it can be used to add values cumulatively
        let startMinusOneDateComponents = NSDateComponents()
        startMinusOneDateComponents.day = -1
        startMinusOne = gregorian.dateByAddingComponents(startMinusOneDateComponents, toDate: startMinusOne, options: NSCalendarOptions(rawValue: 0))!
        
        repeat {
            
            precipCalc[start] = mainWeatherData.lastYearPrecipDict[start]! + (mainWeatherData.lastYearPrecipDict[startMinusOne] ?? 0.0)
        
           // print("end: \(precipCalc)")
            
            
            // increment the date by 1 day
            let dateComponents = NSDateComponents()
            dateComponents.day = 1
            start = gregorian.dateByAddingComponents(dateComponents, toDate: start, options: NSCalendarOptions(rawValue: 0))!
            startMinusOne = gregorian.dateByAddingComponents(dateComponents, toDate: startMinusOne, options: NSCalendarOptions(rawValue: 0))!
            
        } while start != end
        
 */



