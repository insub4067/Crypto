//
//  HomeViewModel.swift
//  Crypto
//
//  Created by Kim Insub on 2023/01/12.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {

    @Published var coins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []

    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()

    init() { addSubscribers() }

    func addSubscribers() {
        dataService.$coins
            .sink { [weak self] coins in
                self?.coins = coins
            }
            .store(in: &cancellables)
    }
}
