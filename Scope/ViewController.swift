//
//  ViewController.swift
//  Scope
//
//  Created by Julian Post on 1/11/17.
//  Copyright © 2017 Julian Post. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
 //var managedObjectContext: NSManagedObjectContext? = nil
  
    
    @IBOutlet weak var minTempOneLbl: UILabel!
    @IBOutlet weak var maxTempOneLbl: UILabel!
    @IBOutlet weak var daysToMaturityLbl: UILabel!
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet var slider2: UIXRangeSlider!
    
    var sliderCharacteristics = CharacteristicsOf()
    var ddArray: [Date:Float] = [:]
    var normals: [Normal] = []
    var normalDictionary: [Date:Float] = [:]
    let dateFormatter = DateFormatter()
    
    
    @IBAction func sliderChanged() {
        
        if mainTempArray != nil {
            
            updateSliderPoints()
        }
        updateLbls()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slider2.layer.isHidden = true
        updateLbls()
        getNormals()
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext /*self.fetchedResultsController.managedObjectContext*/
        
        let weatherRecord = Normal(context: context)
        weatherRecord.date = NSDate()
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func calculateDegreeDays(result: [Normal]) {
        
        let calendar = Calendar.current
        let date = dateFor.normalYearStart
        let range = calendar.range(of: .day, in: .year, for: date)!
        let numDays = range.count
        let gregorian: Calendar! = Calendar(identifier: Calendar.Identifier.gregorian)
        var start = dateFor.normalYearStart
        
        for i in 0...numDays-1 {
            
            ddArray[result[i].date as! Date] = TransformArray.toDegreeDay(sliderCharacteristics.beets.minTemp, maxTemp: sliderCharacteristics.beets.maxTemp, tMin: result[i].tMin, tMax: result[i].tMax)
            
            // increment the date by 1 day
            var dateComponents = DateComponents()
            dateComponents.day = 1
            start = gregorian.date(byAdding: dateComponents, to: start)!
        }

        
    }
    
    func findDaysToMaturity(date: Date, fromLeft: Bool) -> Date {
        
        //let calendar = Calendar.current
        let gregorian: Calendar! = Calendar(identifier: Calendar.Identifier.gregorian)
        var dateComponents = DateComponents()
        var start = date
    
        var accumulatedDays: Float = 0
        
        while accumulatedDays < sliderCharacteristics.beets.daysToMaturity {
        
        accumulatedDays += ddArray[start]!
            
        
            if fromLeft {
                dateComponents.day = 1
            }
            
            else {
                dateComponents.day = -1
            }
            
            start = gregorian.date(byAdding: dateComponents, to: start)!
        }
        
        return start
    }
    
   func findLastPlantingDate() -> Date {
    
        let gregorian: Calendar! = Calendar(identifier: Calendar.Identifier.gregorian)
        var dateComponents = DateComponents()
        var start = dateFor.normalYearEnd
    
        var accumulatedDays: Float = 0
        
        while accumulatedDays < sliderCharacteristics.beets.daysToMaturity {
    
            accumulatedDays += ddArray[start]!
            
            dateComponents.day = -1
            start = gregorian.date(byAdding: dateComponents, to: start)!
        }
        return start
    }
    
    func findEarlyHarvestDate() -> Date {
        
        let gregorian: Calendar! = Calendar(identifier: Calendar.Identifier.gregorian)
        var dateComponents = DateComponents()
        var start = dateFor.normalYearStart
        
        var accumulatedDays: Float = 0
        
        while accumulatedDays < sliderCharacteristics.beets.daysToMaturity {
            
            accumulatedDays += ddArray[start]!
            
            dateComponents.day = 1
            start = gregorian.date(byAdding: dateComponents, to: start)!
            
            
        }
        return start
    }
    
    func updateLbls() {
        dateFormatter.dateFormat = "MMMM d"
        
        let leftDate = DateFunctions.intToDate(int: Int(slider2.leftValue))
        let convertedLeftDate = dateFormatter.string(from: leftDate)
        minTempOneLbl.text = "Planting Date: " + convertedLeftDate
        
        let rightDate = DateFunctions.intToDate(int: Int(slider2.rightValue))
        let convertedRightDate = dateFormatter.string(from: rightDate)
        maxTempOneLbl.text = "Harvest Date: " + convertedRightDate
        
        daysToMaturityLbl.text = "Days to Maturity: " + String(Int(slider2.rightValue - slider2.leftValue))
    }
    
    func updateSliderPoints() {
        
        let earlyHarvestInt: Float = DateFunctions.dateToInt(date: self.findEarlyHarvestDate())
        let lastPlantingInt: Float = DateFunctions.dateToInt(date: self.findLastPlantingDate())
        
        
        if slider2.trackedElement == UIXRangeSlider.ElementTracked.rightThumb {
        
            if self.slider2.rightValue <= earlyHarvestInt {
            self.slider2.rightValue = earlyHarvestInt
            }
            
            let rightDate = DateFunctions.intToDate(int: Int(self.slider2.rightValue))
            let leftDate = self.findDaysToMaturity(date: rightDate, fromLeft: false)
            self.slider2.leftValue = DateFunctions.dateToInt(date: leftDate)
            
        }
        
        else if slider2.trackedElement == UIXRangeSlider.ElementTracked.leftThumb {
           
            if self.slider2.leftValue >= lastPlantingInt {
                self.slider2.leftValue = lastPlantingInt
            }
            
            let leftDate = DateFunctions.intToDate(int: Int(self.slider2.leftValue))
            let rightDate = self.findDaysToMaturity(date: leftDate, fromLeft: true)
            self.slider2.rightValue = DateFunctions.dateToInt(date: rightDate)
            
        }
    }
    
    func setUpSliders() {
        
        let earlyHarvestInt: Float = DateFunctions.dateToInt(date: self.findEarlyHarvestDate())
        self.slider2.rightValue = earlyHarvestInt
        
        let rightDate = DateFunctions.intToDate(int: Int(self.slider2.rightValue))
        let leftDate = self.findDaysToMaturity(date: rightDate, fromLeft: false)
        self.slider2.leftValue = DateFunctions.dateToInt(date: leftDate)
        
    }
    
    

    

    func getNormals() {
        
        if mainTempArray == nil {
            APIManager.sharedInstance.fetchTemp() { result in
                if result {
                    self.fetchNormals()
                    self.calculateDegreeDays(result: self.normals)
                }
                self.setUpSliders()
                self.updateLbls()
                self.slider2.layer.isHidden = false
                self.loadingView.layer.isHidden = true
            }
        }
    }
    
    func fetchNormals() {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        do {
            normals = try context.fetch(Normal.fetchRequest())
        } catch {
            print("Save failed")
        }
    
    }
    
   /* var fetchedResultsController: NSFetchedResultsController<Normal> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<Normal> = Normal.fetchRequest()
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsController!
    }
    var _fetchedResultsController: NSFetchedResultsController<Normal>? = nil*/

}

