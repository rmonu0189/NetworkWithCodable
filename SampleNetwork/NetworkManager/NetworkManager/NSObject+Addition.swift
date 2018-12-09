//
//  NSObject+Addition.swift
//
//  Created by Monu on 02/09/18.
//  Copyright © 2018 Monu. All rights reserved.
//

import Foundation

extension NSObject {
    
    class func parseObject<T: Codable>(_: T.Type, data: [String: Any]) -> T? {
        do {
            let resultsData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            return try JSONDecoder().decode(T.self, from: resultsData)
        } catch {
            print(error)
            return nil
        }
    }
    
    class func parseList<T: Codable>(_: T.Type, data: [[String: Any]]) -> [T]? {
        do {
            let resultsData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            return try JSONDecoder().decode([T].self, from: resultsData)
        } catch {
            print(error)
            return nil
        }
    }
    
    class func parseJsonString<T: Codable>(_: T.Type, string: String) -> T? {
        do {
            let data = string.data(using: String.Encoding.utf8)
            let jsonData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            let resultsData = try JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted)
            return try JSONDecoder().decode(T.self, from: resultsData)
        } catch {
            print(error)
            return nil
        }
    }
}
