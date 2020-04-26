//
//  TwitchManager.swift
//  TwitchDemo
//
//  Created by Suman on 26/04/20.
//  Copyright © 2020 Suman. All rights reserved.
//

import Foundation
class TwitchManager {
    static let shared = TwitchManager()
    func getToken(completion: @escaping CompletionBlock) {
        guard let url = URL(string: "https://id.twitch.tv/oauth2/token?client_id=\(Constants.clientId)&client_secret=\(Constants.token)&grant_type=client_credentials&scope=user_read"
            ) else { return completion(false, nil) }
        NetworkManager.shared.callPOSTApI(url: url) { (success, result) in
            completion(success, result)
        }
    }
}
