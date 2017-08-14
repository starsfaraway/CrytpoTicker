//
//  CryptoTicker.swift
//  CrytpoTicker
//
//  Created by Matthew Riley on 8/13/17.
//  Copyright © 2017 Matthew Riley. All rights reserved.
//

import UIKit

public class CryptoTicker: NSObject {
    //NOTE: ONLY USD CURRENCY SUPPORTED AT THIS TIME
    public class func getTickerInfo(limit: Int?, convert: String?, completion:@escaping ([Ticker]?) -> (Void)) {
        
        if(Ticker.isUpdateAvailable()) {
            CTAPIController.shared.retrieveTicker(limit: limit, convert: convert) { (response) -> (Void) in
                if let tickerArray = response as? [NSDictionary] {
                    NSKeyedArchiver.archiveRootObject(Date(), toFile: MRObjectArchive.filePath(withExtension: ArchivePaths.lastTickerUpdate))
                    completion(Ticker.createArrayOfTickers(fromArrayOfDicts: tickerArray))}
                else{
                    completion(CryptoTicker.getSavedTickerInfo())
                }
            }
        }else{
            completion(CryptoTicker.getSavedTickerInfo())}
    }
    
    internal class func getSavedTickerInfo() -> [Ticker]? {
        if let data = MRObjectArchive.retrieveDataFromArchive(fromExtension: ArchivePaths.lastReceivedTickerInfo) {
            do {
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0))
                if let tickerArray = jsonObj as? [NSDictionary] {
                    return Ticker.createArrayOfTickers(fromArrayOfDicts: tickerArray)}
            }catch {

            }
        }
        return nil
    }
    

}
