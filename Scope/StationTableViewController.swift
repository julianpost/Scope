//
//  StationTableViewController.swift
//  Scope
//
//  Created by Julian Post on 1/25/17.
//  Copyright © 2017 Julian Post. All rights reserved.
//

import UIKit
import CoreData

class StationTableViewController: UITableViewController, NSFetchedResultsControllerDelegate/*, UISearchResultsUpdating*/ {
    
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //var stations = [Station]()
    
    private let persistentTwoContainer = NSPersistentContainer(name: "Model")
    
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<Station> = {
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<Station> = Station.fetchRequest()
        
        // Configure Fetch Request
       fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        // Create Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.persistentTwoContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //stations = fetchStations()
        
        
        persistentTwoContainer.loadPersistentStores { (persistentStoreDescription, error) in
            if let error = error {
                print("Unable to Load Persistent Store")
                print("\(error), \(error.localizedDescription)")
                
            } else {
                
                do {
                    try self.fetchedResultsController.performFetch()
                } catch {
                    let fetchError = error as NSError
                    print("Unable to Perform Fetch Request")
                    print("\(fetchError), \(fetchError.localizedDescription)")
                }
                
                //self.setupView()
                print("success")
                self.tableView.reloadData()
            }
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let stations = fetchedResultsController.fetchedObjects else { return 0 }
        return stations.count
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StationCell.reuseIdentifier, for: indexPath) as? StationCell else {
            fatalError("Unexpected Index Path")
        }
        
        // Fetch Quote
        let station = fetchedResultsController.object(at: indexPath)
        
        // Configure Cell
        cell.nameLabel.text = station.name
        cell.iDLabel.text = station.id
        
        return cell
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

    
    /*func fetchStations() -> [Station] {
        let normalFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Station")
        var stations: [Station] = []
        //normalFetchRequest.predicate = NSPredicate(format: "station == %@", NOAARouter.currentStation)
        
        do {
            stations = try context.fetch(normalFetchRequest) as! [Station]
        } catch {
            fatalError("Failed to fetch stations: \(error)")
        }
        return stations
    }*/

}
