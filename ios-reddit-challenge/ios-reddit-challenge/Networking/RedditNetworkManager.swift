//
//  RedditNetworkManager.swift
//  ios-reddit-challenge
//
//  Created by Henrique Akiyoshi Eguchi on 07/05/21.
//

import Moya

protocol RedditNetworkable {
    var provider: MoyaProvider<RedditAPI> { get }
    
    func listTopEntries(offset: Int, limit: Int, completion: @escaping (Result<RedditList, Error>) -> ())
}

class RedditNetworkManager: RedditNetworkable {
    var provider = MoyaProvider<RedditAPI>(plugins: [NetworkLoggerPlugin()])

    func listTopEntries(offset: Int, limit: Int, completion: @escaping (Result<RedditList, Error>) -> ()) {
        request(target: .top(offset: offset, limit: limit), completion: completion)
    }
    
}

private extension RedditNetworkManager {
    private func request<T: Decodable>(target: RedditAPI, completion: @escaping (Result<T, Error>) -> ()) {
        provider.request(target) { result in
            switch result {
            case .success(let response):
                do {
                    _ = try response.filterSuccessfulStatusCodes()
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
