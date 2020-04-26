//
//  TwitchVideoProvider.swift
//  TwitchDemo
//
//  Created by Suman on 26/04/20.
//  Copyright © 2020 Suman. All rights reserved.
//

import Foundation
import SwiftTwitch

struct TwitchVideoProvider {
    func getVideos(completion: @escaping CompletionBlock) {
        Twitch.Videos.getVideos(videoIds: nil, userId: Constants.userId, gameId: nil) {
            switch $0 {
            case .success(let videosData):
                completion(true, videosData.videoData)
                
            case .failure(let data, _, _):
                if let data = data,
                    let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                    let jsonDict = jsonObject as? [String: Any]{
                    let errorMessage = jsonDict["message"] as? String
                    completion(false, errorMessage ?? "There is some issue with api call.")
                }
            }
        }
    }
    
    func getToken(completion: @escaping CompletionBlock){
        TwitchManager.shared.getToken { (success, response) in
            if success, let response = response as? [String: Any], let token = response["access_token"] as? String {
                TwitchTokenManager.shared.accessToken = token
                completion(true, token)
            }
            else {
                let jsonDict = response as? [String: Any]
                let errorMessage = jsonDict?["message"] as? String
                completion(false, errorMessage ?? "There is some issue with api call.")
            }
        }
    }
}
