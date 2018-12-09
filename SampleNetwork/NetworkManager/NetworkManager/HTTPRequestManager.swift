//
//  HTTPRequestManager.swift
//
//  Created by Monu on 02/09/18.
//  Copyright © 2018 Monu. All rights reserved.
//

import Foundation

extension Notification {
    
    static let requestUnAuthorizedAccess = NSNotification.Name("requestUnAuthorizedAccess")
    
}

final class HTTPRequestManager {
    
    fileprivate var urlSession: URLSession
    
    // MARK: - Singleton Instance
    class var shared: HTTPRequestManager {
        struct Singleton {
            static let instance = HTTPRequestManager()
        }
        return Singleton.instance
    }
    
    fileprivate init() {
        // Craete Urlsession from default configuration.
        urlSession = URLSession(configuration: URLSessionConfiguration.default)
    }

}

extension HTTPRequestManager {
    
    // MARK: - Public Methods
    
    /**
     Perform request to fetch data
     - parameter request:           request
     - parameter userInfo:          userinfo
     - parameter completionHandler: handler
     */
    func performRequest(_ request: URLRequest, completionHandler: @escaping (_ response: Response) -> Void) {
        // Set required headers
        var urlRequest = request
        urlRequest.appendDeviceInfoHeaders()
        urlRequest.appendUserAuthHeader()
        performSessionDataTaskWithRequest(urlRequest, completionHandler: completionHandler)
    }
    
    private func performSessionDataTaskWithRequest(_ request: URLRequest, completionHandler: @escaping (_ response: Response) -> Void) {
        urlSession.dataTask(with: request) { (data, response, error) in
            let apiResponse = self.parseAPIResponse(data, response, error)
            apiResponse.logRequest(request)
            DispatchQueue.main.async {
                completionHandler(apiResponse)
            }
        }.resume()
    }
    
    private func parseAPIResponse(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Response {
        let apiResponse = Response(data)
        apiResponse.connectionError = error
        if let httpResponse = response as? HTTPURLResponse {
            apiResponse.headers = httpResponse.allHeaderFields as? [String: Any]
            apiResponse.httpStatusCode = HTTPStatusCode(rawValue: httpResponse.statusCode)
        }
        if let token = apiResponse.headers?["accessToken"] as? String {
            //UserManager.shared.accessToken = token
        }
        
        return apiResponse
    }
    
    private func checkUnAuthorizedAccess(_ response: Response) {
        if response.httpStatusCode == HTTPStatusCode.unauthorized {
            cancelRequests()
            NotificationCenter.default.post(name: Notification.requestUnAuthorizedAccess, object: response.error())
        }
    }
    
    func cancelRequests(_ url: URL? = nil) {
        urlSession.getTasksWithCompletionHandler({ (dataTasks: [URLSessionDataTask], uploadTasks: [URLSessionUploadTask], downloadTasks: [URLSessionDownloadTask]) -> Void in
            let capacity: NSInteger = dataTasks.count + uploadTasks.count + downloadTasks.count
            let tasks: NSMutableArray = NSMutableArray(capacity: capacity)
            tasks.addObjects(from: dataTasks)
            tasks.addObjects(from: uploadTasks)
            tasks.addObjects(from: downloadTasks)
            
            if let url = url {
                let predicate: NSPredicate = NSPredicate(format: "originalRequest.URL.path = %@", url.path as CVarArg)
                tasks.filter(using: predicate)
            }
            
            for task in tasks {
                (task as! URLSessionTask).cancel()
            }
        })
    }
    
}
