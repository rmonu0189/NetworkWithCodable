//
//  User+Service.swift
//  SampleNetwork
//
//  Created by Monu on 09/12/18.
//  Copyright © 2018 Monu. All rights reserved.
//

import Foundation

extension User {
    
    class func loginWithMobile(_ mobile: String, password: String, handler: @escaping (_ user: User?,_ error: Error?) -> ()) {
        let service = APIService.login(mobile: mobile, password: password)
        DataManager.fetch(service, type: User.self) { (user, error) in
            handler(user, error)
        }
    }
    
}
