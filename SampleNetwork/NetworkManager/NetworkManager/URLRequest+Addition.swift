//
//  URLRequest+Addition.swift
//
//  Created by Monu on 02/09/18.
//  Copyright © 2018 Monu. All rights reserved.
//

import Foundation
import UIKit

enum RequestBodyType {
    case json
    case urlencode
    case queryItem
}

/**
 * HTTP Methods
 */
enum HTTPRequestMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

extension URLRequest {
    
    mutating func appendDeviceInfoHeaders() {
        self.addValue(UIDevice.deviceID(), forHTTPHeaderField: "deviceId")
        self.addValue(UIDevice.current.systemName, forHTTPHeaderField: "deviceType")
        self.addValue(UIDevice.current.systemVersion, forHTTPHeaderField: "deviceOSVersion")
        self.addValue(UIDevice.current.model, forHTTPHeaderField: "deviceModel")
    }
    
    mutating func appendUserAuthHeader() {
//        if UserManager.shared.isLoggedInUser(), let token = UserManager.shared.accessToken {
//            self.addValue(token, forHTTPHeaderField: "token")
//        }
    }
    
    mutating func appendBody(_ body: [String: Any]?, type: RequestBodyType = .json) {
        guard let body = body else { return }
        if type == .json {
            self.addValue("application/json", forHTTPHeaderField: "Content-Type")
            self.addValue("application/json", forHTTPHeaderField: "Accept")
            self.appendJsonBody(body)
        } else if type == .urlencode {
            self.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        } else {
            
        }
    }
    
}

extension URLRequest {
    
    private mutating func appendJsonBody(_ json: [String: Any]) {
        do {
            let data: Data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            self.httpBody = data
        } catch let parseError {
            print("Error could not parse JSON.\n \(parseError)") // Log the error thrown by `JSONObjectWithData`
        }
    }
    
}

extension UIDevice {
    
    static func deviceID() -> String {
        if let deviceID = UserDefaults.standard.value(forKey: "deviceID") {
            return deviceID as! String
        } else {
            let deviceID = UIDevice.current.identifierForVendor?.uuidString ?? ""
            UserDefaults.standard.set(deviceID as AnyObject?, forKey: "deviceID")
            return deviceID
        }
    }
    
}
