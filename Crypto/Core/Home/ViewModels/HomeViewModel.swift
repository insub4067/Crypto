//
//  HomeViewModel.swift
//  Crypto
//
//  Created by Kim Insub on 2023/01/12.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {

    @Published var statistics: [StatisticModel] = [
        StatisticModel(title: "Title", value: "Value", percentageChange: 1),
        StatisticModel(title: "Title", value: "Value"),
        StatisticModel(title: "Title", value: "Value"),
        StatisticModel(title: "Title", value: "Value", percentageChange: -7)
    ]

    @Published var coins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText = ""

    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()

    init() { addSubscribers() }

    func addSubscribers() {

        $searchText
            .combineLatest(dataService.$coins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .compactMap(filterCoins)
            .sink { [weak self] coins in
                self?.coins = coins
            }
            .store(in: &cancellables)
    }

    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else { return coins }
        let lowercased = text.lowercased()
        let filtered = coins.filter {
            $0.name.lowercased().contains(lowercased) ||
            $0.id.lowercased().contains(lowercased) ||
            $0.symbol.lowercased().contains(lowercased)
        }
        return filtered
    }
}
