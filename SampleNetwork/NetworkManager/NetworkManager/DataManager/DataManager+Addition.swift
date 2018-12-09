//
//  DataManager+Addition.swift
//
//  Created by Monu on 02/09/18.
//  Copyright © 2018 Monu. All rights reserved.
//

import Foundation

extension DataManager {
    
    class func fetch<T: Codable>(_ service: APIService, type: T.Type, handler: @escaping (_ object: T?,_ error: Error?) -> Void) {
        DataManager.shared.httpClient.performRequest(service.request) { (response) in
            if response.success() == true {
                handler(response.model(T.self), nil)
            } else {
                handler(nil, response.error())
            }
        }
    }
    
    class func fetchList<T: Codable>(_ service: APIService, type: T.Type, handler: @escaping (_ object: [T]?, _ paging: Paging?, _ error: Error?) -> Void) {
        DataManager.shared.httpClient.performRequest(service.request) { (response) in
            if response.success() == true {
                handler(response.modelList(T.self, encodingKey: service.listDataKey), response.model(Paging.self), nil)
            } else {
                handler(nil, nil, response.error())
            }
        }
    }
    
    class func perform(_ service: APIService, handler: @escaping (_ response: Response?,_ error: Error?) -> Void) {
        DataManager.shared.httpClient.performRequest(service.request) { (response) in
            if response.success() == true {
                handler(response, nil)
            } else {
                handler(nil, response.error())
            }
        }
    }
    
}
