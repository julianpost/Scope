//
//  Station+CoreDataProperties.swift
//  
//
//  Created by Julian Post on 1/18/17.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Station {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Station> {
        return NSFetchRequest<Station>(entityName: "Station");
    }

    @NSManaged public var lat: Float
    @NSManaged public var lon: Float
    @NSManaged public var name: String?
    @NSManaged public var id: String?

}
