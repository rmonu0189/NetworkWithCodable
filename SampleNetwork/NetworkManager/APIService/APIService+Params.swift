//
//  APIService+Params.swift
//  DataCave
//
//  Created by Monu on 02/09/18.
//  Copyright © 2018 Monu. All rights reserved.
//

import Foundation

extension APIService {
    
    var parameters: [String: Any] {
        switch self {
        case let .login(mobile, password):
            return ["mobile": mobile, "password": password]
        case let .signUp(mobile, password):
            return ["mobile": mobile, "password": password]
        }
    }
    
}
