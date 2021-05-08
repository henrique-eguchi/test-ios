//
//  RedditAPI.swift
//  ios-reddit-challenge
//
//  Created by Henrique Akiyoshi Eguchi on 07/05/21.
//

import Moya

enum RedditAPI {
    case top(limit: Int, after: String, offset: Int?, _ time: String = "all", _ show: String = "all")
}

extension RedditAPI: TargetType {

    var baseURL: URL { return URL(string: "https://api.reddit.com")! }
    
    var path: String {
        switch self {
        case .top:
            return "/top"
        }
    }
    
    var method: Method {
        switch self {
        case .top:
            return .get
        }
    }

    var sampleData: Data {
        switch self {
        case .top:
            guard let url = Bundle.main.url(forResource: "top-sr_detail_true", withExtension: "json"),
                let data = try? Data(contentsOf: url) else {
                    return Data()
            }
            return data
        }
    }
    
    var task: Task {
        switch self {
        case let .top(limit, after, offset, time, show):
            let initialParameters: [String: Any] = ["t": time, "limit": limit, "after": after, "show": show]

            if let unwrappedOffset = offset {
                let optionalParameters: [String: Any] = ["count": unwrappedOffset]
                let mergedDictionary = initialParameters.merging(optionalParameters) { _, new in new }
                return .requestParameters(parameters: mergedDictionary,
                                          encoding: URLEncoding.queryString)
            }
            
            return .requestParameters(parameters: initialParameters,
                                      encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }

    
}
