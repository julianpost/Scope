//
//  NOAATempArrays.swift
//  CloudView
//
//  Created by Julian Post on 11/9/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//

import Foundation

class NOAATempArrays {
    
    var normalYearTemperatureMaxArray,normalYearTemperatureMinArray: [Float]

    /*var normalYearDegreeDayOne, normalYearDegreeDayTwo, normalYearDegreeDayThree, normalYearDegreeDayOneCumulative, normalYearDegreeDayTwoCumulative, normalYearDegreeDayThreeCumulative: [Float]*/
    
    init(fromCurrentYearTMax currentYearTemperatureMaxDict: [Date : Float], fromNormalYearTMax normalYearTemperatureMaxDict: [Date : Float], fromCurrentYearTemperatureMin currentYearTemperatureMinDict: [Date : Float], fromNormalYearTemperatureMin normalYearTemperatureMinDict: [Date : Float]) {
        
        normalYearTemperatureMaxArray = TransformArray.toSimple(normalYearTemperatureMaxDict)
        normalYearTemperatureMinArray = TransformArray.toSimple(normalYearTemperatureMinDict)
        
        /*normalYearDegreeDayOne = TransformArray.toDegreeDay(mainSettingsData.minTempOne, maxTemp: mainSettingsData.maxTempOne, tMin: normalYearTemperatureMinArray, tMax: normalYearTemperatureMaxArray)
        normalYearDegreeDayTwo = TransformArray.toDegreeDay(mainSettingsData.minTempTwo, maxTemp: mainSettingsData.maxTempTwo, tMin: normalYearTemperatureMinArray, tMax: normalYearTemperatureMaxArray)
        normalYearDegreeDayThree = TransformArray.toDegreeDay(mainSettingsData.minTempThree, maxTemp: mainSettingsData.maxTempThree, tMin: normalYearTemperatureMinArray, tMax: normalYearTemperatureMaxArray)

        normalYearDegreeDayOneCumulative = TransformArray.toCumulative(TransformArray.toDegreeDay(mainSettingsData.minTempOne, maxTemp: mainSettingsData.maxTempOne, tMin: normalYearTemperatureMinArray, tMax: normalYearTemperatureMaxArray))
        normalYearDegreeDayTwoCumulative = TransformArray.toCumulative(TransformArray.toDegreeDay(mainSettingsData.minTempTwo, maxTemp: mainSettingsData.maxTempTwo, tMin: normalYearTemperatureMinArray, tMax: normalYearTemperatureMaxArray))
        normalYearDegreeDayThreeCumulative = TransformArray.toCumulative(TransformArray.toDegreeDay(mainSettingsData.minTempThree, maxTemp: mainSettingsData.maxTempThree, tMin: normalYearTemperatureMinArray, tMax: normalYearTemperatureMaxArray))*/
        
    }
}

var mainTempArray: NOAATempArrays?
