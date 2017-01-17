//
//  NOAAStationFile.swift
//  CloudView
//
//  Created by Julian Post on 11/4/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//

import Foundation

class NOAAStationFile: NSObject, NSCoding {
    
    var name: String?
    var stationID: String?
    var lat: String?
    var lon: String?
    
    
    required init?(json: [String: Any]) {
        
    self.name = json["name"] as? String
    self.stationID = json["id"] as? String
    self.lat = json["latitude"] as? String
    self.lon = json["longitude"] as? String
    
    }
    
init?(aName: String?, aStationID: String?, aLat: String?, aLon: String?) {
        self.name = aName
        self.stationID = aStationID
        self.lat = aLat
        self.lon = aLon
    
    }
    
    // MARK: NSCoding
    @objc func encode(with aCoder: NSCoder) {
        
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.stationID, forKey: "id")
        aCoder.encode(self.lat, forKey: "latitude")
        aCoder.encode(self.lon, forKey: "longitude")
        
    }
    
    @objc required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as? String
        let stationID = aDecoder.decodeObject(forKey: "id") as? String
        let lat = aDecoder.decodeObject(forKey: "latitude") as? String
        let lon = aDecoder.decodeObject(forKey: "longitude") as? String
        
        // use the existing init function
        self.init(aName: name, aStationID: stationID, aLat: lat, aLon: lon)
    }
}

