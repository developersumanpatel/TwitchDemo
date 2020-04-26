//
//  TwitchVideoDelegate.swift
//  TwitchDemo
//
//  Created by Suman on 26/04/20.
//  Copyright © 2020 Suman. All rights reserved.
//

import Foundation
protocol TwitchVideoDelegate: class {
    func finishGettingVideoWithSuccess()
    func finishGettingVideoWithError(message: String)
}
