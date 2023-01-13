//
//  CoinImageViewModel.swift
//  Crypto
//
//  Created by Kim Insub on 2023/01/12.
//

import UIKit
import Combine

class CoinImageViewModel: ObservableObject {

    @Published var image: UIImage? = nil
    @Published var isLoading = false

    private let coin: CoinModel
    private let dataService: CoinImageService
    private var cancellables = Set<AnyCancellable>()

    init(coin: CoinModel) {
        self.isLoading = true
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        addSubscribers()
    }

    private func addSubscribers() {
        dataService.$image
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] image in
                self?.image = image
            }
            .store(in: &cancellables)
    }
}
