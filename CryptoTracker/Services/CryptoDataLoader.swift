/*
 CryptoDataLoader.swift
 
 A Singleton used to fetch the data
 through the API and decode it.
 
 Created by Cristina Dobson
 */


import Foundation
import Combine

class CryptoDataLoader: CryptoService {
  
  
  // MARK: - Properties
  
  static let shared = CryptoDataLoader()
  private let baseApiURL = "https://api.blockchain.com/v3/exchange/"
  private let urlSession = URLSession.shared
  private var subscriptions = Set<AnyCancellable>()
  
  private let jsonDecoder: JSONDecoder = {
    let jsonDecoder = JSONDecoder()
    return jsonDecoder
  }()
  
  
  // MARK: - Init method
  
  private init() {}
  
  
  // MARK: - CryptoService protocol
  
  func fetchCryptoMarkets<T: Codable>(from endpoint: String) -> Future<T, CryptoDataAPIError> {
    
    // Initialize and return Future
    return Future<T, CryptoDataAPIError> { [unowned self] promise in
      guard let url = self.createURL(with: endpoint)
      else {
        return promise(.failure(.urlError(URLError(.unsupportedURL))))
      }
      
      // Start fetching the data
      self.urlSession.dataTaskPublisher(for: url)
      /*
       Check that the http response status code
       is between 200 and 299.
       */
        .tryMap { (data, response) -> Data in
          guard let httpResponse = response as? HTTPURLResponse,
                200...299 ~= httpResponse.statusCode
          else {
            throw CryptoDataAPIError.responseError(
              (response as? HTTPURLResponse)?.statusCode ?? 500)
          }
          return data
        }
      /*
       Decode the published JSON data into the CryptoMarket model
       */
        .decode(type: T.self,
                decoder: self.jsonDecoder)
      /*
       Make sure completion runs on the main thread
       */
        .receive(on: RunLoop.main)
      /*
       Subscribe to receive a value
       */
        .sink { completion in
          if case let .failure(error) = completion {
            switch error {
              case let urlError as URLError:
                promise(.failure(.urlError(urlError)))
              case let decodingError as DecodingError:
                promise(.failure(.decodingError(decodingError)))
              case let apiError as CryptoDataAPIError:
                promise(.failure(apiError))
              default:
                promise(.failure(.anyError))
            }
          }
        }
      receiveValue: {
        promise(.success($0))
      }
      /*
       Make sure the subscription still works after
       the execution is finished.
       */
    .store(in: &self.subscriptions)
      
    }
  }
  
  
  // MARK: - Create Endpoint
  
  private func createURL(with endpoint: String) -> URL? {
    
    guard let urlComponents = URLComponents(string: "\(baseApiURL)/\(endpoint)")
    else { return nil }
    
    return urlComponents.url
  }
  
}



















