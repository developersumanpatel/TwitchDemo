//
//  NetworkManager.swift
//  TwitchDemo
//
//  Created by Suman on 26/04/20.
//  Copyright © 2020 Suman. All rights reserved.
//

import Foundation
typealias CompletionBlock = (_ success: Bool, _ response: Any?) -> Void

class NetworkManager {
    static let shared = NetworkManager()
    // TODO: Need to check network first
    func callPOSTApI(url: URL, parameterDictionary: [String: Any]? = nil, showLog: Bool? = true, completion: @escaping CompletionBlock) {
        if showLog ?? false {
            debugPrint(url)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        if let parameterDictionary = parameterDictionary {
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
                completion(false, nil)
                return
            }
            request.httpBody = httpBody
        }
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                if showLog ?? false {
                    debugPrint(response )
                }
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    completion(true, json)
                } catch {
                    completion(false, error)
                }
            }
        }
        .resume()
    }
}
