//
//  NOAARouter.swift
//  CloudView
//
//  Created by Julian Post on 11/2/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//

//
//  NOAARouter.swift
//  grokSwiftREST
//
//  Created by Christina Moulton on 2016-10-29.
//  Copyright © 2016 Teak Mobile Inc. All rights reserved.
//

import Foundation
import Alamofire

enum NOAARouter: URLRequestConvertible {
    static let baseURLString = "https://www.ncdc.noaa.gov/cdo-web/api/v2?"
    
    case getCurrentYearPrecip()
    case getNormalYearPrecip()
    case getCurrentYearTMax()
    case getNormalYearTMax()
    case getCurrentYearTMin()
    case getNormalYearTMin()
    
    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self {
            case .getCurrentYearPrecip, .getNormalYearPrecip, .getCurrentYearTMax, .getNormalYearTMax, .getCurrentYearTMin, .getNormalYearTMin:
                return .get
            }
        }
        
        let url: URL = {
            let relativePath: String
            switch self {
            case .getCurrentYearPrecip, .getNormalYearPrecip, .getCurrentYearTMax, .getNormalYearTMax, .getCurrentYearTMin, .getNormalYearTMin:
                relativePath = "data"
            }
            
            var url = URL(string: NOAARouter.baseURLString)!
            url.appendPathComponent(relativePath)
            return url
        }()
        
        let params: ([String: Any]) = {
            switch self {
            case .getCurrentYearPrecip:
                return ([
                "datasetid" : "GHCND",
                "datatypeid" : "PRCP",
                "stationid" : "GHCND:USW00014742",
                "startdate" : dateFor.stringOfCurrentYearStart,
                "enddate" : dateFor.stringOfCurrentYearEnd,
                "units" : "standard",
                "limit" : "365"
                ])
            case .getNormalYearPrecip():
                return ([
                "datasetid" : "NORMAL_DLY",
                "datatypeid" : "YTD-PRCP-NORMAL",
                "stationid" : "GHCND:USW00014742",
                "startdate" : dateFor.stringOfNormalYearStart,
                "enddate" : dateFor.stringOfNormalYearEnd,
                "units" : "standard",
                "limit" : "365"
                ])
            case .getCurrentYearTMax():
                return ([
                    "datasetid" : "GHCND",
                    "datatypeid" : "TMAX",
                    "stationid" : "GHCND:USW00014742",
                    "startdate" : dateFor.stringOfCurrentYearStart,
                    "enddate" : dateFor.stringOfCurrentYearEnd,
                    "units" : "standard",
                    "limit" : "365"
                ])
            case .getNormalYearTMax():
                return ([
                    "datasetid" : "NORMAL_DLY",
                    "datatypeid" : "DLY-TMAX-NORMAL",
                    "stationid" : "GHCND:USW00014742",
                    "startdate" : dateFor.stringOfNormalYearStart,
                    "enddate" : dateFor.stringOfNormalYearEnd,
                    "units" : "standard",
                    "limit" : "365"
                ])
            case .getCurrentYearTMin():
                return ([
                    "datasetid" : "GHCND",
                    "datatypeid" : "TMIN",
                    "stationid" : "GHCND:USW00014742",
                    "startdate" : dateFor.stringOfCurrentYearStart,
                    "enddate" : dateFor.stringOfCurrentYearEnd,
                    "units" : "standard",
                    "limit" : "365"
                ])
            case .getNormalYearTMin():
                return ([
                    "datasetid" : "NORMAL_DLY",
                    "datatypeid" : "DLY-TMIN-NORMAL",
                    "stationid" : "GHCND:USW00014742",
                    "startdate" : dateFor.stringOfNormalYearStart,
                    "enddate" : dateFor.stringOfNormalYearEnd,
                    "units" : "standard",
                    "limit" : "365"
                ])
            }
        }()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.setValue("qMbhulVTJqFjFMUdHrwmhbxVyIIeqmOs", forHTTPHeaderField: "Token")
        
        let encoding = URLEncoding.default
        return try encoding.encode(urlRequest, with: params)
    }
}
