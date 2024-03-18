//
//  ApiService.swift
//  DS_ExpertIOS
//
//  Created by Admin on 20/01/24.
//

import Foundation
import Alamofire
import Combine

public protocol NetworkServiceProtocol {
  func getGames() -> AnyPublisher<GamesResponse, Error>
  func getDetailGame(id: Int) -> AnyPublisher<GameDetailResponse, Error>
  func getGameByName(name: String) -> AnyPublisher<GamesResponse, Error>
}

public class NetworkService: BaseNetworkService, NetworkServiceProtocol {
  
  public override init() {
    
  }
  
  override func getBaseUrl() -> String {
    return API.baseUrl
  }
  
  override func getApiKey() -> String? {
    return API.apiKey
  }
  
  public func getGames() -> AnyPublisher<GamesResponse, Error> {
    return Future { completion in
      guard let url = self.createRequest(
        urlPath: Endpoints.games.rawValue
      ).url else {  return }
      
      AF.request(url)
        .validate()
        .responseDecodable(of: GamesResponse.self) { response in
          switch response.result {
          case .success(let value):
            completion(.success(value))
          case .failure(let error):
            completion(.failure(error))
          }
        }
    }.eraseToAnyPublisher()
  }
  
  public func getDetailGame(id: Int) -> AnyPublisher<GameDetailResponse, Error> {
    return Future { completion in
      guard let url = self.createRequest(
        urlPath: Endpoints.gameById.rawValue + "\(id)"
      ).url else { return }
      
      AF.request(url)
        .validate()
        .responseDecodable(of: GameDetailResponse.self) { response in
          switch response.result {
          case .success(let value):
            completion(.success(value))
          case .failure(let error):
            completion(.failure(error))
          }
        }
    }.eraseToAnyPublisher()
  }
  
  public func getGameByName(name: String) -> AnyPublisher<GamesResponse, Error> {
    return Future { completion in
      var componentUrl = self.createRequest(
        urlPath: Endpoints.games.rawValue
      )
      componentUrl.queryItems?.append(
        URLQueryItem(name: "search", value: name)
      )
      guard let url = componentUrl.url else { return }
      
      AF.request(url)
        .validate()
        .responseDecodable(of: GamesResponse.self) { response in
          switch response.result {
          case .success(let value):
            completion(.success(value))
          case .failure(let error):
            completion(.failure(error))
          }
        }
    }.eraseToAnyPublisher()
  }
  
}
