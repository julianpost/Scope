//
//  Normal+CoreDataProperties.swift
//  
//
//  Created by Julian Post on 1/18/17.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Normal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Normal> {
        return NSFetchRequest<Normal>(entityName: "Normal");
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var tMin: Float
    @NSManaged public var tMax: Float

}
