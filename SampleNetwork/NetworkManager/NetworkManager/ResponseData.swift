//
//  ResponseData.swift
//
//  Created by Monu on 02/09/18.
//  Copyright © 2018 Monu. All rights reserved.
//

import Foundation

enum ResponseDataKey: String {
    case data = "data"
}

class ResponseData: NSObject, Codable {
    
    var message: String?
    var status: Int?
    var data: Any?
    
    enum CodingKeys: String, CodingKey {
        case status
        case message
    }
    
    func isSuccess() -> Bool {
        return status == 1
    }
    
}

class Paging: NSObject, Codable {
    
    // MARK: Properties
    
    public var currentPage: Int?
    public var firstPageUrl: String?
    public var lastPageUrl: String?
    public var nextPageUrl: String?
    public var prevPageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case currentPage
        case firstPageUrl
        case lastPageUrl
        case nextPageUrl
        case prevPageUrl
    }
}
