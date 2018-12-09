//
//  DataManager.swift
//
//  Created by Monu on 02/09/18.
//  Copyright © 2018 Monu. All rights reserved.
//

import Foundation

class DataManager {
    
    let httpClient: HTTPRequestManager
    
    // MARK: - Singleton Instance
    class var shared: DataManager {
        struct Singleton {
            static let instance = DataManager()
        }
        return Singleton.instance
    }
    
    private init() {
        httpClient = HTTPRequestManager.shared
    }
    
}
