//
//  RedditAPI.swift
//  ios-reddit-challenge
//
//  Created by Henrique Akiyoshi Eguchi on 07/05/21.
//

import Moya

enum RedditAPI {
    case top(count: Int, limit: Int, _ time: String = "all", _ show: String = "all")
}

extension RedditAPI: TargetType {

    var baseURL: URL { return URL(string: "https://api.reddit.com")! }
    
    var path: String {
        switch self {
        case .top(_, _, _, _):
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
        case let .top(time, count, limit, show):
            return .requestParameters(parameters: ["t": time, "count": count, "limit": limit, "show": show], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }

    
}
