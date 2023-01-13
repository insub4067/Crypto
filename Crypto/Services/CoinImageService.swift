//
//  CoinImageService.swift
//  Crypto
//
//  Created by Kim Insub on 2023/01/12.
//

import UIKit
import Combine

class CoinImageService {

    @Published var image: UIImage? = nil

    private var imageSubscription: AnyCancellable?
    private let coin: CoinModel

    init(coin: CoinModel) {
        self.coin = coin
        getCoinImage()
    }

    private func getCoinImage() {
        guard let url = URL(string: coin.image) else { return }

        imageSubscription = NetworkManager.download(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
//            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(
                receiveCompletion: NetworkManager.handleCompletion,
                receiveValue: { [weak self] image in
                self?.image = image
                self?.imageSubscription?.cancel()
            })
    }
}
