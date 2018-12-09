//
//  APIService+EndPoint.swift
//  DataCave
//
//  Created by Monu on 02/09/18.
//  Copyright © 2018 Monu. All rights reserved.
//

import Foundation

extension APIService {
    
    var apiURL: String {
        return "http://hamaradamoh.com/studentapi/" + path
    }
    
    // Put all end points with corresponding case.
    private var path: String {
        switch self {
        case .login:
            return "auth/login"
        case .signUp:
            return "auth/signup"
        }
    }
    
}
