//
//  Subscription.swift
//  SampleNetwork
//
//  Created by Monu on 09/12/18.
//  Copyright © 2018 Monu. All rights reserved.
//

import UIKit

class Subscription: NSObject, Codable {
    var version: Int?
    var isForceUpdate: Int?
    var startDate: String?
    var expiryDate: String?
    var remainDays: Int?
    
    enum CodingKeys: String, CodingKey {
        case version
        case isForceUpdate
        case startDate = "start_date"
        case expiryDate = "expiry_date"
        case remainDays = "remain_days"
    }
    
}
