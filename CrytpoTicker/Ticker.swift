//
//  Ticker.swift
//  Crypto Ticker
//
//  Created by Matthew Riley on 8/12/17.
//  Copyright © 2017 Matthew Riley. All rights reserved.
//

import UIKit


public class Ticker: NSObject, Codable {
    
    public var id : String?
    public var name : String?
    public var symbol : String?
    public var rank : String?
    public var price_usd : String?
    public var price_btc : String?
    public var market_cap_usd : String?
    public var available_supply : String?
    public var total_supply : String?
    public var percent_change_1h : String?
    public var percent_change_24h : String?
    public var percent_change_7d : String?
    public var the_24h_volume_usd : String?
    public var last_updated : String?
    
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
    
    static func encoded(tick : Ticker) -> Data? {
        let encoder = JSONEncoder()
        let encoded = try? encoder.encode(tick)
        return encoded
    }
    
    static func decode(data : Data) -> [Ticker]? {
        let decoder = JSONDecoder()
        do{
            let retval = try decoder.decode([Ticker].self, from: data)
            return retval
        }catch {
            return nil}
    }
    
    //CLASS ONLY SUPPORTS USD, TO ADD ADDITIONAL CURRENCIES, ADD 'price_eur', ETC.
    
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
            retval += "USD Price: " + "$" + usdPrice + "\r"}
        if let btcPrice = price_btc {
            retval += "BTC Price: " + btcPrice + "\r"}
        if let volume = the_24h_volume_usd {
            retval += "Volume (USD): " + volume + "\r"}
        if let marketCapUSD = market_cap_usd {
            retval += "Market Cap (USD): " + marketCapUSD + "\r"}
        if let available = available_supply {
            retval += "Available Supply: " + available + "\r"}
        if let total = total_supply {
            retval += "Total Supply: " + total + "\r"}



        if let lastUpdate = last_updated {
            let lastDate = Date.init(timeIntervalSinceReferenceDate: TimeInterval(lastUpdate) ?? 0)
            let dateFormatter = DateFormatter()
            dateFormatter.setLocalizedDateFormatFromTemplate("MMM d, h:mm a")
            retval += "\r\rLast Update: " + dateFormatter.string(from: lastDate) + "\r"}
    
        return retval
    }
}
