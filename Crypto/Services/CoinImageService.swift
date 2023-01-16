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
    private let fileManager = LocalFileManager.shared
    private let folderName = "coin_images"
    private let imageName: String

    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }

    private func getCoinImage() {

        // 만약 캐시 처리되어있다면
        if let image = fileManager.getImage(imageName: self.imageName, folderName: self.folderName) {
            self.image = image
        } else {
            downloadCoinImage()
        }
    }

    private func downloadCoinImage() {
        
        guard let url = URL(string: coin.image) else { return }
        imageSubscription = NetworkManager.download(url: url)
            .compactMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(
                receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] image in
                    guard let self = self else { return }
                    self.image = image
                    self.imageSubscription?.cancel()
                    self.fileManager.saveImage(image: image, imageName: self.imageName, folderName: self.folderName)
            })
    }
}
