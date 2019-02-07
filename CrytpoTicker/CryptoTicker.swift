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
        
        if(CTAPIController.shared.isUpdateAvailable()) {
            CTAPIController.shared.retrieveTicker(limit: limit, convert: convert) { (response) -> (Void) in
                if let tickerData = response as? Data {
                    guard let tickers = Ticker.decode(data: tickerData) else {
                        completion(nil)
                        return}
                    completion(tickers)}
                else{
                    //no data to return
                }
            }
        }
    }

}
