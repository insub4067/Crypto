//
//  CoinDataService.swift
//  Crypto
//
//  Created by Kim Insub on 2023/01/12.
//

import Foundation
import Combine

class CoinDataService {

    @Published var coins: [CoinModel] = []
    var coinSubscription: AnyCancellable?

    init () { getCoins() }

    private func getCoins() {

        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return }

        coinSubscription = NetworkManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(
                receiveCompletion: NetworkManager.handleCompletion,
                receiveValue: { [weak self] coins in
                self?.coins = coins
                self?.coinSubscription?.cancel()
            })
    }
}
