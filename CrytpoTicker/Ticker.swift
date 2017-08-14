//
//  Ticker.swift
//  Crypto Ticker
//
//  Created by Matthew Riley on 8/12/17.
//  Copyright © 2017 Matthew Riley. All rights reserved.
//

import UIKit

public class Ticker: NSObject {
    
    public var id : String?
    public var name : String?
    public var symbol : String?
    public var rank : String?
    public var price_usd : NSNumber?
    public var price_btc : NSNumber?
    public var market_cap_usd : NSNumber?
    public var available_supply : NSNumber?
    public var total_supply : NSNumber?
    public var percent_change_1h : NSNumber?
    public var percent_change_24h : NSNumber?
    public var percent_change_7d : NSNumber?
    public var last_updated : NSNumber?
    
    //THIS ONE IS A PROBLEM : API SENDS VARIABLE STARTING WITH A NUMBER *****
    public var the_24h_volume_usd : NSNumber?
    
    //CLASS ONLY SUPPORTS USD, TO ADD ADDITIONAL CURRENCIES, ADD 'price_eur', ETC.
    
    internal convenience init(withDict : NSDictionary) {
        self.init()
        
        for (key, _) in withDict {
            if let keyName = key as? String {
                if(self.responds(to: NSSelectorFromString(keyName))) {
                    self.setValue(withDict[keyName], forKey: keyName)}
                //fix here for ***** above
                self.setValue(withDict[keyName], forKey: "the_24h_volume_usd")
                
            }
            
        }
    }
    
    //API REQUEsTS LIMITED TO 10 PER MINUTE https://coinmarketcap.com/api/
    internal class func isUpdateAvailable() ->  Bool {
        if let lastUpdate : Date = NSKeyedUnarchiver.unarchiveObject(withFile: MRObjectArchive.filePath(withExtension: ArchivePaths.lastTickerUpdate)) as? Date {
            //PREVENTS UPDATING MORE THAN 10 TIMES PER MINUTE
            return -lastUpdate.timeIntervalSinceNow > 7.0}
        else{
            //NO DATE SAVED, SHOULD BE FIRST REQUEST
            return true}
    }
    
    //MARK: ARRAY OF TICKERS
    
    internal class func createArrayOfTickers(fromArrayOfDicts : [NSDictionary]) -> [Ticker] {
        var tickers : [Ticker] = []
        for tickerDict in fromArrayOfDicts {
            let ticker = Ticker.init(withDict: tickerDict)
            tickers.append(ticker)
        }
        return tickers
    }
}

extension Ticker {
    public func getStringDescription() -> String {
        var retval : String = "Coin Information:\r\r\r"
        if let coinName = name {
            retval += "Name: " + coinName + "\r"}
        if let coinSymbol = symbol {
            retval += "Symbol: " + coinSymbol + "\r"}
        if let coinRank = rank {
            retval += "Rank: " + coinRank + "\r"}
        if let usdPrice = price_usd {
            retval += "USD Price: " + "\(usdPrice.doubleValue)" + "\r"
        
            if let hourChange = percent_change_1h {
                retval += "\tChange last hour: $" + "\(0.01 * hourChange.doubleValue * (price_usd?.doubleValue)!)" + "\r"}
            if let dayChange = percent_change_24h {
                retval += "\tChange last day: $" + "\(0.01 * dayChange.doubleValue * (price_usd?.doubleValue)!)" + "\r"}
            if let weekChange = percent_change_7d {
                retval += "\tChange last week: $" + "\(0.01 * weekChange.doubleValue * (price_usd?.doubleValue)!)" + "\r"}
            
        
        }
        if let btcPrice = price_btc {
            retval += "BTC Price: " + "\(btcPrice.doubleValue)" + "\r"}
        if let volume = the_24h_volume_usd {
            retval += "Volume (USD): " + "\(volume.doubleValue)" + "\r"}
        if let marketCapUSD = market_cap_usd {
            retval += "Market Cap (USD): " + "\(marketCapUSD.doubleValue)" + "\r"}
        if let available = available_supply {
            retval += "Available Supply: " + "\(available.doubleValue)" + "\r"}
        if let total = total_supply {
            retval += "Total Supply: " + "\(total.doubleValue)" + "\r"}
        
        
        
        if let lastUpdate = last_updated {
            let lastDate = Date.init(timeIntervalSinceReferenceDate: lastUpdate.doubleValue)
            let dateFormatter = DateFormatter()
            dateFormatter.setLocalizedDateFormatFromTemplate("MMM d, h:mm a")
            retval += "\r\rLast Update: " + dateFormatter.string(from: lastDate) + "\r"}
    
        return retval
    }
}
