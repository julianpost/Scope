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
    
    let defaults = UserDefaults.standard
    
    
    @IBAction func favLocationsAlert() {
        
        let favLocations: [[String]] = defaults.object(forKey: "favLocations") as? [[String]] ?? [["New York", "GHCND:USW00094789"],["San Francisco", "GHCND:USC00047767"], ["Austin", "GHCND:USW00013904"], ["Chicago", "GHCND:USW00094892"], ["Miami", "GHCND:USW00092811"]]
        
        let alertController = UIAlertController(title: "Favorite Locations", message: "You can customize this list by clicking 'Edit favorites'", preferredStyle: .alert)
        
        let oneAction = UIAlertAction(title: favLocations[0][0], style: .default) { _ in
            self.loadingView.layer.isHidden = false
            self.slider2.layer.isHidden = true
            NOAARouter.currentStation = favLocations[0][1]
            self.defaults.set(NOAARouter.currentStation, forKey: "currentStation")
            self.checkForDataAndActAccordingly()
        }
        let twoAction = UIAlertAction(title: favLocations[1][0], style: .default) { _ in
            self.loadingView.layer.isHidden = false
            self.slider2.layer.isHidden = true
            NOAARouter.currentStation = favLocations[1][1]
            self.defaults.set(NOAARouter.currentStation, forKey: "currentStation")
            self.checkForDataAndActAccordingly()
        }
        let threeAction = UIAlertAction(title: favLocations[2][0], style: .default) { _ in
            self.loadingView.layer.isHidden = false
            self.slider2.layer.isHidden = true
            NOAARouter.currentStation = favLocations[2][1]
            self.defaults.set(NOAARouter.currentStation, forKey: "currentStation")
            self.checkForDataAndActAccordingly()
        }
        let fourAction = UIAlertAction(title: favLocations[3][0], style: .default) { _ in
            self.loadingView.layer.isHidden = false
            self.slider2.layer.isHidden = true
            NOAARouter.currentStation = favLocations[3][1]
            self.defaults.set(NOAARouter.currentStation, forKey: "currentStation")
            self.checkForDataAndActAccordingly()
        }
        let fiveAction = UIAlertAction(title: favLocations[4][0], style: .default) { _ in
            self.loadingView.layer.isHidden = false
            self.slider2.layer.isHidden = true
            NOAARouter.currentStation = favLocations[4][1]
            self.defaults.set(NOAARouter.currentStation, forKey: "currentStation")
            self.checkForDataAndActAccordingly()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in }
        
        alertController.addAction(oneAction)
        alertController.addAction(twoAction)
        alertController.addAction(threeAction)
        alertController.addAction(fourAction)
        alertController.addAction(fiveAction)
        alertController.addAction(cancelAction)
        //let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        //alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    var sliderCharacteristics = CharacteristicsOf()
    var ddArray: [Date:Float] = [:]
    var normals: [Normal] = []
    var normalDictionary: [Date:Float] = [:]
    let dateFormatter = DateFormatter()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    @IBAction func sliderChanged() {
        
        updateSliderPoints()
        updateLbls()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIManager.sharedInstance.fetchStations() { result in
            if result {
                print(result)
            }
            
        }
        
        slider2.layer.isHidden = true
        updateLbls()
        
        checkForDataAndActAccordingly()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func calculateDegreeDays(result: [Normal]) {
        
        let calendar = Calendar.current
        var start = dateFor.normalYearStart
        let interval = calendar.dateInterval(of: .year, for: start)!
        let numDays = calendar.dateComponents([.day], from: interval.start, to: interval.end).day!
        
        let gregorian: Calendar! = Calendar(identifier: Calendar.Identifier.gregorian)
        
        for i in 0...numDays-1 {
            let date = result[i].date as! Date
            ddArray[date] = TransformArray.toDegreeDay(sliderCharacteristics.beets.minTemp, maxTemp: sliderCharacteristics.beets.maxTemp, tMin: result[i].tMin, tMax: result[i].tMax)
            
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

    
    func checkForDataAndActAccordingly() {
        
        if recordsOfCurrentStationExist() {
            setEverythingUp()
        }
        else {
            getNormalsFromNOAA()
        }
    }
    
    func getNormalsFromNOAA() {
        
        APIManager.sharedInstance.fetchTemp() { result in
            if result {
                self.setEverythingUp()
            }
            
        }
    }
    
    func setEverythingUp() {
    
        self.fetchNormals()
        print(self.normals.count)
        self.calculateDegreeDays(result: self.normals)
        
        self.setUpSliders()
        self.updateLbls()
        self.slider2.layer.isHidden = false
        self.loadingView.layer.isHidden = true
    }
    func fetchNormals() {
        
        let normalFetchRequest = NSFetchRequest<Normal>(entityName: "Normal")
        normalFetchRequest.predicate = NSPredicate(format: "station == %@", NOAARouter.currentStation)

        do {
            normals = try context.fetch(normalFetchRequest)
        } catch {
            print("Save failed")
        }
    
    }
    
    func recordsOfCurrentStationExist() -> Bool {
        
        var bool: Bool = false
    
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Normal")
        let predicate = NSPredicate(format: "date >= %@ AND date <= %@ AND station == %@", dateFor.normalYearStart as NSDate, dateFor.normalYearEnd as NSDate, NOAARouter.currentStation)
        request.predicate = predicate
        //request.fetchLimit = 1
        
        do {
            let count = try context.count(for: request)
            if(count == 365){
                bool = true
            }
            else {
                bool = false
            }
        
        }
        
        catch let error as NSError {
            NSLog("Error fetching date entries from core data !!! \(error.localizedDescription)")
        }

        return bool
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

