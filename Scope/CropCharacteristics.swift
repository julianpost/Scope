//
//  CropCharacteristics.swift
//  NOAA
//
//  Created by Julian Post on 10/16/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//

import Foundation

class CharacteristicsOf {
    
    let beets = Crop(minTemp: 52, maxTemp: 86, daysToMaturity: 1234)
    let carrots = Crop(minTemp: 52, maxTemp: 86, daysToMaturity: 3123)
    let corn = Crop(minTemp: 32, maxTemp: 90, daysToMaturity: 2800)
    let lettuce = Crop(minTemp: 52, maxTemp: 86, daysToMaturity: 1250)
}

struct Crop {
    
    var minTemp: Float
    var maxTemp: Float
    var daysToMaturity: Float

}
