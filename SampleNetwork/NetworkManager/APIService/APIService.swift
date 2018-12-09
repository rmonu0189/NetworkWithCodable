//
//  APIService.swift
//  DataCave
//
//  Created by Monu on 02/09/18.
//  Copyright © 2018 Monu. All rights reserved.
//

import Foundation

enum APIService {
    
    case login(mobile: String, password: String)
    case signUp(mobile: String, password: String)
    
}

extension APIService {
    
    var listDataKey: String? {
        switch self {
//        case .login:
//            return "users"
        default:
            return nil
        }
    }
    
}

extension APIService {
    
    // MARK: - API Methods
    var method: HTTPRequestMethod {
        switch self {
//        case .login:
//            return .GET
        default:
            return .POST
        }
    }
    
    var request: URLRequest {
        var mutableURLRequest: URLRequest = URLRequest(url: URL(string: apiURL)!)
        mutableURLRequest.timeoutInterval = 30
        mutableURLRequest.httpMethod = method.rawValue
        mutableURLRequest.appendBody(parameters, type: method == .GET ? .queryItem : .json)
        return mutableURLRequest
    }
    
}
