//
//  ViewController.swift
//  Scope
//
//  Created by Julian Post on 1/11/17.
//  Copyright © 2017 Julian Post. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //@IBOutlet weak var tempViewOne: UIView!
    
    @IBOutlet weak var minTempOneLbl: UILabel!
    @IBOutlet weak var maxTempOneLbl: UILabel!
    @IBOutlet weak var daysToMaturityLbl: UILabel!
    
    @IBOutlet var slider2: UIXRangeSlider!
    
    var sliderCharacteristics = CharacteristicsOf()
    var ddArray: [Float] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    
    let dateReference = DateFunctions.dateReference()
    let dateFormatter = DateFormatter()
    
    
    @IBAction func sliderChanged() {
        
        if mainTempArray != nil {
            
            if (self.slider2.rightValue <= self.findEarlyHarvestDate(ddArray: self.ddArray)) {
                self.slider2.rightValue = self.findEarlyHarvestDate(ddArray: self.ddArray)
            }
            
            slider2.leftValue = findDaysToMaturity(ddArray: ddArray, start: slider2.rightValue)
        }
        
        dateFormatter.dateFormat = "MMMM d"
        
        if let result = dateReference[Int(slider2.leftValue)] {
        let convertedDate = dateFormatter.string(from: result)
        minTempOneLbl.text = "Planting Date: " + convertedDate
        }
        if let result = dateReference[Int(slider2.rightValue)] {
            let convertedDate = dateFormatter.string(from: result)
            maxTempOneLbl.text = "Harvest Date: " + convertedDate
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateFormat = "MMMM d"
        
        if let result = dateReference[Int(slider2.leftValue)] {
            let convertedDate = dateFormatter.string(from: result)
            minTempOneLbl.text = "Planting Date: " + convertedDate
        }
        if let result = dateReference[Int(slider2.rightValue)] {
            let convertedDate = dateFormatter.string(from: result)
            maxTempOneLbl.text = "Harvest Date: " + convertedDate
        }
        
        if mainTempArray == nil {
            APIManager.sharedInstance.fetchTemp() { result in
                mainTempArray = result
                self.ddArray = self.calculateDegreeDays(result: mainTempArray!)
                self.slider2.leftValue = self.findDaysToMaturity(ddArray: self.ddArray, start: self.slider2.rightValue)
                if (self.slider2.rightValue <= self.findEarlyHarvestDate(ddArray: self.ddArray)) {
                    self.slider2.rightValue = self.findEarlyHarvestDate(ddArray: self.ddArray)
                }
            }
        }
        
        
    }
    
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func calculateDegreeDays(result: NOAATempArrays) -> [Float] {
        
        let ddArray = TransformArray.toDegreeDay(sliderCharacteristics.beets.minTemp, maxTemp: sliderCharacteristics.beets.maxTemp, tMin: result.normalYearTemperatureMinArray, tMax: result.normalYearTemperatureMaxArray)
        
        return ddArray
    }
    
    func findDaysToMaturity(ddArray: [Float], start: Float) -> Float {
        
        var i = Int(start)
    
        var accumulatedDays: Float = 0
        
        while accumulatedDays < sliderCharacteristics.beets.daysToMaturity {
        
        accumulatedDays += ddArray[i]
            
        i -= 1
            
        }
        daysToMaturityLbl.text = "Days to Maturity: " + String(i)
        return start - Float(i)
    }
    
    func findLastPlantingDate(ddArray: [Float]) -> Float {
    
        var i: Int = 364
    
        var accumulatedDays: Float = 0
        
        while accumulatedDays < sliderCharacteristics.beets.daysToMaturity {
    
            accumulatedDays += ddArray[i]
            
    
            i -= 1
    
        }
        return Float(i)
    }
    
    func findEarlyHarvestDate(ddArray: [Float]) -> Float {
        
        var i: Int = 0
        
        var accumulatedDays: Float = 0
        
        while accumulatedDays < sliderCharacteristics.beets.daysToMaturity {
            
            accumulatedDays += ddArray[i]
            
            
            i += 1
            
        }
        return Float(i+2)

    }
    
}

