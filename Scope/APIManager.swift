//
//  APIManager.swift
//  CloudView
//
//  Created by Julian Post on 11/3/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//

import Foundation
import Alamofire

enum APIManagerError: Error {
    case network(error: Error)
    case apiProvidedError(reason: String)
    case authCouldNot(reason: String)
    case authLost(reason: String)
    case objectSerialization(reason: String)
}

class APIManager {

    static let sharedInstance = APIManager()
    
    // MARK: - API Calls
    
    func fetchTemp(completionHandler: @escaping (NOAATempArrays) -> Void) {
        
        var currentYearTMax: [Date:Float] = [:]
        var normalYearTMax: [Date:Float] = [:]
        var currentYearTMin: [Date:Float] = [:]
        var normalYearTMin: [Date:Float] = [:]
        
        var currentYearTMaxBool = false
        var normalYearTMaxBool = false
        var currentYearTMinBool = false
        var normalYearTMinBool = false
        
        func initWeatherData() {
            if normalYearTMaxBool && normalYearTMinBool {
                let temp = NOAATempArrays(fromCurrentYearTMax: currentYearTMax, fromNormalYearTMax: normalYearTMax, fromCurrentYearTemperatureMin: currentYearTMin, fromNormalYearTemperatureMin: normalYearTMin)
                completionHandler(temp)
            }
        }
        
       /* Alamofire.request(NOAARouter.getCurrentYearTMax())
            .responseJSON { response in
                if let values = self.nOAAArrayFromResponse(response: response).value {
                    currentYearTMax = values
                    currentYearTMaxBool = true
                    initWeatherData()
                }
        }*/
        
        Alamofire.request(NOAARouter.getNormalYearTMax())
            .responseJSON { response in
                if let values = self.nOAAArrayFromResponse(response: response).value {
                    normalYearTMax = values
                    normalYearTMaxBool = true
                    initWeatherData()
                }
        }
        /*Alamofire.request(NOAARouter.getCurrentYearTMin())
            .responseJSON { response in
                
                if let values = self.nOAAArrayFromResponse(response: response).value {
                    currentYearTMin = values
                    currentYearTMinBool = true
                    initWeatherData()
                }
        }*/
        Alamofire.request(NOAARouter.getNormalYearTMin())
            .responseJSON { response in
                
                if let values = self.nOAAArrayFromResponse(response: response).value {
                    normalYearTMin = values
                    normalYearTMinBool = true
                    initWeatherData()
                }
        }
        
    }
        
    private func nOAAArrayFromResponse(response: DataResponse<Any>) -> Result<[Date : Float]> {
        guard response.result.error == nil else {
            print(response.result.error!)
            return .failure(APIManagerError.network(error: response.result.error!))
        }
        
        // make sure we got JSON and it's an array
        guard let jsonArray = response.result.value as? [String: Any] else {
            print("didn't get array of gists object as JSON from API")
            return .failure(APIManagerError.objectSerialization(reason:
                "Did not get JSON dictionary in response"))
        }
        
        // check for "message" errors in the JSON because this API does that
        if let jsonDictionary = response.result.value as? [String: Any],
            let errorMessage = jsonDictionary["message"] as? String {
            return .failure(APIManagerError.apiProvidedError(reason: errorMessage))
        }
        
        // turn JSON in to array
        
        var dict: [Date : Float] = [:]
        
            if let array = jsonArray["results"] as? [[String: Any]] {
            
                for i in array {
                    if let date = i["date"], let value = i["value"] {
                        let stringOfDate = "\(date)"
                        let formattedDate = DateFunctions.stringToDate(stringOfDate)
                        let stringOfValue = "\(value)"
                        let floatOfValue = Float(stringOfValue)
                        dict[formattedDate] = floatOfValue
                }
            }
        }
        return .success(dict)
    }
}
