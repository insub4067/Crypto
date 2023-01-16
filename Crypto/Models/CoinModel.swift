//
//  CoinModel.swift
//  Crypto
//
//  Created by Kim Insub on 2023/01/12.
//

import Foundation

// CoinGecko URL
/*
 https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h
 {
    "id": "bitcoin",
    "symbol": "btc",
    "name": "Bitcoin",
    "image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
    "current_price": 17416.9,
    "market_cap": 335457599961,
    "market_cap_rank": 1,
    "fully_diluted_valuation": 365781438603,
    "total_volume": 21545509529,
    "high_24h": 17507.77,
    "low_24h": 17275.22,
    "price_change_24h": 141.68,
    "price_change_percentage_24h": 0.82016,
    "market_cap_change_24h": 2250793518,
    "market_cap_change_percentage_24h": 0.67549,
    "circulating_supply": 19259068,
    "total_supply": 21000000,
    "max_supply": 21000000,
    "ath": 69045,
    "ath_change_percentage": -74.77847,
    "ath_date": "2021-11-10T14:24:11.849Z",
    "atl": 67.81,
    "atl_change_percentage": 25581.17161,
    "atl_date": "2013-07-06T00:00:00.000Z",
    "roi": null,
    "last_updated": "2023-01-11T15:03:16.144Z",
    "sparkline_in_7d": {
      "price": [
        16836.715819170204,
        16812.569889413244
      ]
    },
    "price_change_percentage_24h_in_currency": 0.8201557824352997
  },

 */


struct CoinModel: Identifiable, Codable {
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let marketCap, marketCapRank, fullyDilutedValuation, totalVolume: Double?
    let high24H, low24H, priceChange24H, priceChangePercentage24H: Double?
    let marketCapChange24H: Double?
    let marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    let currentHoldings: Double?

    func updateHoldings(amount: Double) -> CoinModel {
        return CoinModel(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24H: high24H, low24H: low24H, priceChange24H: priceChange24H, priceChangePercentage24H: priceChangePercentage24H, marketCapChange24H: marketCapChange24H, marketCapChangePercentage24H: marketCapChangePercentage24H, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl, atlChangePercentage: atlChangePercentage, atlDate: atlDate, lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D, priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency, currentHoldings: amount)
    }

    var currentHoldingsValue: Double { return (currentHoldings ?? 0) * currentPrice }

    var rank: Int { return Int(marketCapRank ?? 0) }
}

struct SparklineIn7D: Codable {
    let price: [Double]?
}
