//
//  User.swift
//  SampleNetwork
//
//  Created by Monu on 09/12/18.
//  Copyright © 2018 Monu. All rights reserved.
//

import UIKit

class User: NSObject, Codable {
    var userId: String?
    var deviceId: String?
    var fullName: String?
    var mobile: String?
    
    enum CodingKeys: String, CodingKey {
        case userId = "id"
        case deviceId = "device_id"
        case fullName = "full_name"
        case mobile
    }
    
}


/*
 {
 "status": 1,
 "message": "You have successfully logged in.",
 "data": {
 "id": "15",
 "device_id": "",
 "full_name": "Paa",
 "mobile": "9999999999",
 "email": "aaa@aa.com",
 "roll_no": null,
 "picture": "1503757122.jpeg",
 "institute_code": "",
 "batchTime": "",
 "email_verify": "1",
 "mobile_verify": "1",
 "created_at": "2017-08-26 07:18:42",
 "updated_at": null,
 "token": "8eGmRvOw.4Bp1fqxWscF16ZEA8SHIyLFBjSjCxE2r7ghcxCZNFvDAk93hR_PfcmHl4ROrmFGiMOl9h@MNvheDg8KXyr3.B_KxhpM",
 "institute": null,
 "subscription": {
 "version": 1,
 "isForceUpdate": 0,
 "start_date": "2017-08-26",
 "expiry_date": "2017-09-10",
 "remain_days": 0
 }
 },
 "created_at": "2018-12-09 11:18:18",
 "updatedAt": "2018-12-09 11:18:18"
 }
 */
