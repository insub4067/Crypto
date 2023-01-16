//
//  MarketDataService.swift
//  Crypto
//
//  Created by Kim Insub on 2023/01/15.
//

import Foundation
import Combine

class MarketDataService {

    @Published var marketData: MarketDataModel? = nil
    var marketDataSubscription: AnyCancellable?

    init () { getMarketData() }

    private func getMarketData() {

        let urlString = "https://api.coingecko.com/api/v3/global"
        guard let url = URL(string: urlString) else { return }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        marketDataSubscription = NetworkManager.download(url: url)
            .decode(type: GlobalData.self, decoder: decoder)
            .sink(
                receiveCompletion: NetworkManager.handleCompletion,
                receiveValue: { [weak self] globalData in
                    self?.marketData = globalData.data
                    self?.marketDataSubscription?.cancel()
            })
    }
}
