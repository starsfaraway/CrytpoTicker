//
//  Ticker.swift
//  Crypto Ticker
//
//  Created by Matthew Riley on 8/12/17.
//  Copyright © 2017 Matthew Riley. All rights reserved.
//

import UIKit

public class Tickers : NSObject, Codable {
    public var tickerList : [Ticker]?
    
    static func encoded(ticks : Tickers) -> Data? {
        let encoder = JSONEncoder()
        let encoded = try? encoder.encode(ticks)
        return encoded
    }
    
    static func decode(data : Data) -> Tickers? {
        let decoder = JSONDecoder()
        do{
            let retval = try decoder.decode(Tickers.self, from: data)
            return retval
        }catch {
            return nil}
    }
}

public class Ticker: NSObject, Codable {
    
    public var id : String?
    public var name : String?
    public var symbol : String?
    public var rank : String?
    public var price_usd : Double?
    public var price_btc : Double?
    public var market_cap_usd : Double?
    public var available_supply : Double?
    public var total_supply : Double?
    public var percent_change_1h : Double?
    public var percent_change_24h : Double?
    public var percent_change_7d : Double?
    public var the_24h_volume_usd : Double?
    public var last_updated : Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case symbol
        case rank
        case price_usd
        case price_btc
        case market_cap_usd
        case total_supply
        case percent_change_1h
        case percent_change_24h
        case percent_change_7d
        case the_24h_volume_usd = "24h_volume_usd"
        case last_updated
    }
    
    //CLASS ONLY SUPPORTS USD, TO ADD ADDITIONAL CURRENCIES, ADD 'price_eur', ETC.
    

    //API REQUEsTS LIMITED TO 10 PER MINUTE https://coinmarketcap.com/api/
    internal class func isUpdateAvailable() ->  Bool {
        if let lastUpdate : Date = NSKeyedUnarchiver.unarchiveObject(withFile: MRObjectArchive.filePath(withExtension: ArchivePaths.lastTickerUpdate)) as? Date {
            //PREVENTS UPDATING MORE THAN 10 TIMES PER MINUTE
            return -lastUpdate.timeIntervalSinceNow > 7.0}
        else{
            //NO DATE SAVED, SHOULD BE FIRST REQUEST
            return true}
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
            retval += "USD Price: " + "\(usdPrice)" + "\r"
            
            if let hourChange = percent_change_1h {
                retval += "\tChange last hour: $" + "\(0.01 * hourChange * (price_usd)!)" + "\r"}
            if let dayChange = percent_change_24h {
                retval += "\tChange last day: $" + "\(0.01 * dayChange * (price_usd)!)" + "\r"}
            if let weekChange = percent_change_7d {
                retval += "\tChange last week: $" + "\(0.01 * weekChange * (price_usd)!)" + "\r"}
        }
        if let btcPrice = price_btc {
            retval += "BTC Price: " + "\(btcPrice)" + "\r"}
        if let volume = the_24h_volume_usd {
            retval += "Volume (USD): " + "\(volume)" + "\r"}
        if let marketCapUSD = market_cap_usd {
            retval += "Market Cap (USD): " + "\(marketCapUSD)" + "\r"}
        if let available = available_supply {
            retval += "Available Supply: " + "\(available)" + "\r"}
        if let total = total_supply {
            retval += "Total Supply: " + "\(total)" + "\r"}
        
        
        
        if let lastUpdate = last_updated {
            let lastDate = Date.init(timeIntervalSinceReferenceDate: TimeInterval(lastUpdate))
            let dateFormatter = DateFormatter()
            dateFormatter.setLocalizedDateFormatFromTemplate("MMM d, h:mm a")
            retval += "\r\rLast Update: " + dateFormatter.string(from: lastDate) + "\r"}
    
        return retval
    }
}
