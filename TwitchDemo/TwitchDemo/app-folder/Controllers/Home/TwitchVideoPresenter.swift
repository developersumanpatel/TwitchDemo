//
//  TwitchVideoPresenter.swift
//  TwitchDemo
//
//  Created by Suman on 26/04/20.
//  Copyright © 2020 Suman. All rights reserved.
//

import Foundation
import SwiftTwitch

class TwitchVideoPresenter {
    var provider: TwitchVideoProvider?
    weak var delegate: TwitchVideoDelegate?
    var videos: [VideoData]?
    
    init(provider: TwitchVideoProvider, delegate: TwitchVideoDelegate) {
        self.provider = provider
        self.delegate = delegate
    }
    
    func getVideos() {
        provider?.getVideos(completion: { (success, result) in
            if success, let videoData = result as? [VideoData] {
                self.videos = videoData
                self.delegate?.finishGettingVideoWithSuccess()
            } else if let errorMessage = result as? String {
                self.delegate?.finishGettingVideoWithError(message: errorMessage)
            }
        })
    }
    
    func getToken() {
        provider?.getToken(completion: { (success, result) in
            if success {
                self.getVideos()
            }else if let errorMessage = result as? String {
                self.delegate?.finishGettingVideoWithError(message: errorMessage)
            }
        })
    }
}
