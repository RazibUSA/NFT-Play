//
//  OpenSeaAPI.swift
//  nftPlay
//
//  Created by Razib Mollick on 1/22/22.
//

import Foundation
import Combine

// MARK: - Protocol
protocol NFTCollectible {
    func getCollection(offset: Int, limit: Int) -> AnyPublisher<OpenSeaCollection, ErrorType>

}

class OpenSeaAPI {
  private let session: URLSession
  
  init(session: URLSession = .shared) {
    self.session = session
  }
}


extension OpenSeaAPI: NFTCollectible {
    func getCollection(offset: Int, limit: Int) -> AnyPublisher<OpenSeaCollection, ErrorType> {
        return serviceRequest(with: createCollectionComponents(offset: offset, limit: limit))
    }

  private func serviceRequest<T>(with components: URLComponents) -> AnyPublisher<T, ErrorType> where T: Decodable {
    guard let url = components.url else {
      let error = ErrorType.network(description: "Couldn't create URL")
      return Fail(error: error).eraseToAnyPublisher()
    }
    return session.dataTaskPublisher(for: URLRequest(url: url))
      .mapError { error in
        .network(description: error.localizedDescription)
      }
      .flatMap(maxPublishers: .max(1)) { pair in
          self.decode(pair.data)
      }
      .eraseToAnyPublisher()
  }
   
    // TBD:- Move to utils
    func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, ErrorType> {
      let decoder = JSONDecoder()
      decoder.dateDecodingStrategy = .secondsSince1970

      return Just(data)
        .decode(type: T.self, decoder: decoder)
        .mapError { error in
          .parsing(description: error.localizedDescription)
        }
        .eraseToAnyPublisher()
    }
    
}

// MARK: - OpenSea API
//https://api.opensea.io/api/v1/collections?offset=0&limit=30

// TBD:- Make enum type

private extension OpenSeaAPI {
  struct API {
    static let scheme = "https"
    static let host = "api.opensea.io"
    static let path = "/api/v1"
    static let key = "<your key>"
  }
  
    func createCollectionComponents(offset: Int, limit: Int) -> URLComponents {
    var components = URLComponents()
    components.scheme = API.scheme
    components.host = API.host
    components.path = API.path + "/collections"
    
    components.queryItems = [
      URLQueryItem(name: "offset", value: String(offset)),
      URLQueryItem(name: "limit", value: String(limit))
    ]
    print(components)
    return components
  }
  
}

// MARK: - Simpler way
/*
 .dataTaskPublisher(for: req.buildURLRequest(with: url))
             .tryMap { output in
                      // throw an error if response is nil
                 guard output.response is HTTPURLResponse else {
                     throw NetworkError.serverError(code: 0, error: "Server error")
                 }
                 return output.data
             }
             .decode(type: T.self, decoder: JSONDecoder())
             .mapError { error in
                        // return error if json decoding fails
                 NetworkError.invalidJSON(String(describing: error))
             }
             .eraseToAnyPublisher()
 */
