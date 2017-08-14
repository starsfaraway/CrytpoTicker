//
//  CoinMarketCapConstants.swift
//  CrytpoTicker
//
//  Created by Matthew Riley on 8/13/17.
//  Copyright © 2017 Matthew Riley. All rights reserved.
//

import Foundation

internal struct CoinMarketCap {
    static let baseUrl = "https://api.coinmarketcap.com/v1/ticker/"
}

internal struct ErrorMessages {
    static let apiError = ["error" : "Error with API"]
    static let networkUnavailable = ["error" : "Error, network unavailable"]
    static let tooManyRequests = ["error" : "Too many requests"]
}

internal struct ArchivePaths {
    static let lastTickerUpdate = "last_ticker_update_path"
    static let lastReceivedTickerInfo = "last_recieved_ticker_json"
}
