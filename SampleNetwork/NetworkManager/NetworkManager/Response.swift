//
//  Response.swift
//
//  Created by Monu on 02/09/18.
//  Copyright © 2018 Monu. All rights reserved.
//

import Foundation

class Response {
    
    var httpStatusCode: HTTPStatusCode?
    var headers: [String: Any]?
    var connectionError: Error?
    
    private var responseData: ResponseData?
    
    init(_ data: Data?) {
        self.parseData(data)
    }
    
    private func parseData(_ data: Data?) {
        guard let data = data else { return }
        do {
            responseData = try JSONDecoder().decode(ResponseData.self, from: data)
            let apiResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any]
            if let apiData = apiResponse?[ResponseDataKey.data.rawValue] {
                responseData?.data = apiData
            }
        } catch {
            self.connectionError = error
        }
    }
    
    func success() -> Bool {
        if connectionError == nil, responseData?.isSuccess() == true, httpStatusCode == HTTPStatusCode.ok {
            return true
        }
        return false
    }
    
    func message() -> String {
        return responseData?.message ?? connectionError?.localizedDescription ?? ""
    }
    
    func error() -> Error? {
        if connectionError != nil {
            return connectionError
        } else if success() == false {
            return NSError(domain: "CONNECTION_ERROR", code: httpStatusCode?.rawValue ?? 0, userInfo: [NSLocalizedDescriptionKey : message()])
        } else {
            return nil
        }
    }
        
}

extension Response {
    
    func logRequest(_ request: URLRequest) {
        #if DEBUG
        guard let url = request.url?.absoluteString, let paramsData = request.httpBody, let method = request.httpMethod else { return }
        print("=================================\nURL: \(method) \(url)")
        guard let inputData: String = String(data: paramsData, encoding: String.Encoding.utf8) else { return }
        print("Input: \(inputData)")
        if let error = self.connectionError { print("\nError: \(error)\n") }
        print("\nMessage: \(self.message())\n")
        guard let outputData = responseData?.data else { return }
        print("\nOutput: \(outputData)\n=================================")
        #endif
    }
    
}

extension Response {
    
    func model<T: Codable>(_ type: T.Type) -> T? {
        guard let data = responseData?.data as? [String: Any] else { return nil }
        return NSObject.parseObject(T.self, data: data)
    }
    
    func modelList<T: Codable>(_ type: T.Type, encodingKey: String? = nil) -> [T]? {
        var data = [[String: Any]]()
        if let key = encodingKey, let response = responseData?.data as? [String: Any], let responseData = response[key] as? [[String: Any]] {
            data = responseData
        } else if let responseData = responseData?.data as? [[String: Any]] {
            data = responseData
        }
        var objects = [T]()
        for item in data {
            if let model = NSObject.parseObject(T.self, data: item) {
                objects.append(model)
            }
        }
        return objects
    }
    
}
