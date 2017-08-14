//
//  CTAPIController.swift
//  CrytpoTicker
//
//  Created by Matthew Riley on 8/13/17.
//  Copyright © 2017 Matthew Riley. All rights reserved.
//

import UIKit

private let _apiController = CTAPIController()

internal class CTAPIController: NSObject, URLSessionDelegate {
    
    //SINGLETON//////////////////////////////////SINGLETON////////////////////////////////
    class var shared : CTAPIController{
        return _apiController
    }
    override init() {
        super.init()
    }
    //SINGLETON//////////////////////////////////SINGLETON////////////////////////////////
    
    fileprivate func setupRequest(type: String, endpoint: String, json: Data?, completion:@escaping (Any?) -> (Void)) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: self, delegateQueue: nil)
        let url = URL(string: endpoint)
        let request = self.setup(type: type, url: url!, parameters: json)
        let dataTask = session.dataTask(with: request) { (data, request, error) in
            
            print("data: \(String(describing: data)), error: \(String(describing: error)), request: \(String(describing: request?.url))")
            
            if(error != nil) {
                completion(nil)}
            if(data == nil) {
                completion(nil)}
            
            if let validData = data {
                do {
                    MRObjectArchive.saveDataInArchive(data: validData, withExtension: ArchivePaths.lastReceivedTickerInfo)
                    let retval = try JSONSerialization.jsonObject(with: validData, options: JSONSerialization.ReadingOptions(rawValue: 0))
                    completion(retval)}
                catch {
                    completion(nil)}
            }else {
                
                completion(nil)}
        }
        
        dataTask.resume()
    }
    
    fileprivate func setup(type : String, url : URL, parameters: Data?) -> URLRequest {
        
        var request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 20.0)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = type
        request.httpBody = parameters
        
        return request
    }
    
    //MARK: GET TICKER INFO
    
    internal func retrieveTicker(limit : Int?, convert: String?, completion:@escaping (Any?) -> (Void)) {
        var endpoint : String
        
        //GET CORRECT ENDPOINT FOR PARAMETERS
        if(limit == nil && convert == nil) {
            endpoint = self.retrieveTickerValues()
        }else if(convert == nil) {
            endpoint = self.retrieveTickerValues(limit: limit)
        }else {
            endpoint = self.retrieveTickerValues(limit: limit, convert: convert)}
        
        self.setupRequest(type: "GET", endpoint: endpoint, json: nil, completion: { (response) -> (Void) in
                completion(response)
        })
    }
    
    //MARK: FUNCTIONS TO BUILD CORRECT URL
    
    fileprivate func retrieveTickerValues(limit : Int?, convert: String?) -> String {
        var baseUrlString = CoinMarketCap.baseUrl
        
        if let convertString : String = convert {
            baseUrlString = baseUrlString + "?convert=" + convertString
            if let limitCount : Int = limit {
                baseUrlString = baseUrlString + "&limit=" + "\(limitCount)"}
        }
        return baseUrlString
    }
    
    fileprivate func retrieveTickerValues(limit : Int?) -> String {
        var baseUrlString = CoinMarketCap.baseUrl
        
        if let limitCount : Int = limit {
            baseUrlString = baseUrlString + "?limit=" + "\(limitCount)"}
        return baseUrlString
        
    }
    
    fileprivate func retrieveTickerValues() -> String {
        let baseUrlString = CoinMarketCap.baseUrl
        return baseUrlString
    }

    

}
