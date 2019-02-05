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
                if let tickerData = response as? Data {
                    guard let tickers = Tickers.decode(data: tickerData) else {
                        completion(nil)
                        return}
                    NSKeyedArchiver.archiveRootObject(tickerData, toFile: MRObjectArchive.filePath(withExtension: ArchivePaths.lastTickerUpdate))
                    completion(tickers.tickerList)}
                else{
                    completion(CryptoTicker.getSavedTickerInfo())
                }
            }
        }else{
            completion(CryptoTicker.getSavedTickerInfo())}
    }
    
    internal class func getSavedTickerInfo() -> [Ticker]? {
        if let data = MRObjectArchive.retrieveDataFromArchive(fromExtension: ArchivePaths.lastReceivedTickerInfo) {
            guard let tickers = Tickers.decode(data: data) else {
                return nil}
            return tickers.tickerList
        }
        return nil
    }
    

}
