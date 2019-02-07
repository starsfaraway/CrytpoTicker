<a href=https://github.com/starsfaraway/CrytpoTicker/blob/master/README.md#crytpoticker>Description</a>

<a href=https://github.com/starsfaraway/CrytpoTicker/blob/master/README.md#requirements>Requirements</a>

<a href=https://github.com/starsfaraway/CrytpoTicker/blob/master/README.md#installation>Installation</a>

<a href=https://github.com/starsfaraway/CrytpoTicker/blob/master/README.md#to-use>To Use</a>

# CrytpoTicker
Swift Framework that requests current cryptocurrency prices from coinmarketcap.com

# Requirements
iOS 10.0+

# Installation
CocoaPods

CocoaPods is a dependency manager for Cocoa projects. You can install it with the following command:

     $ gem install cocoapods

To integrate CryptoTicker into your Xcode project using CocoaPods, specify it in your Podfile:

     platform :ios, '12.0'

     use_frameworks!

     target '<Your Target Name>' do
     
          pod 'CrytpoTicker', '~> 0.1.7'
    
     end

Then, run the following command:

     $ pod install

# To Use:

Simply use the function:

     CryptoTicker.getTickerInfo(limit: 20, convert: "USD") { (tickerInfo) -> (Void) in {

     }

tickerInfo is the Ticker object with the following properties, use as desired:

     var id : String?
     
     var name : String?
     
     var symbol : String?
     
     var rank : String?
     
     var price_usd : String?
     
     var price_btc : String?
     
     var market_cap_usd : String?
     
     var available_supply : String?
     
     var total_supply : String?
     
     var percent_change_1h : String?
     
     var percent_change_24h : String?
     
     var percent_change_7d : String?
     
     var last_updated : String?
