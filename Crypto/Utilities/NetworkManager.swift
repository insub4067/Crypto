//
//  NetworkManager.swift
//  Crypto
//
//  Created by Kim Insub on 2023/01/12.
//

import Foundation
import Combine

class NetworkManager {

    enum NetworkError: LocalizedError {
        case badURLResponse(url: URL)
        case unknow

        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url): return "⚠️ Bad response from URL: \(url)"
            case .unknow: return "⚠️ Unknown error"
            }
        }
    }

    static func download(url: URL) -> AnyPublisher<Data, Error> {

        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleURLResponse(output: $0, url: url) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300
        else { throw NetworkError.badURLResponse(url: url) }
        return output.data
    }

    static func handleCompletion(completion: Subscribers.Completion<Publishers.Decode<AnyPublisher<Data, Error>, [CoinModel], JSONDecoder>.Failure>) {
        
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
