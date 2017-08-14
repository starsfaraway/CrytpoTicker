# CrytpoTicker
Swift Framework that requests current cryptocurrency prices from coinmarketcap.com

Simply use:
CryptoTicker.getTickerInfo(limit: 20, convert: "USD") { (tickerInfo) -> (Void) in {

}

tickerInfo is the Ticker object with the following properties, use as desired:
     var id : String?
     
     var name : String?
     
     var symbol : String?
     
     var rank : String?
     
     var price_usd : NSNumber?
     
     var price_btc : NSNumber?
     
     var market_cap_usd : NSNumber?
     
     var available_supply : NSNumber?
     
     var total_supply : NSNumber?
     
     var percent_change_1h : NSNumber?
     
     var percent_change_24h : NSNumber?
     
     var percent_change_7d : NSNumber?
     
     var last_updated : NSNumber?
