//
//  VideoCell.swift
//  TwitchDemo
//
//  Created by Suman on 26/04/20.
//  Copyright © 2020 Suman. All rights reserved.
//

import UIKit
import SwiftTwitch

class VideoCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var videoImageView: UIImageView!
    @IBOutlet weak var viewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureData(videoData: VideoData) {
        titleLabel.text = videoData.title
        userLabel.text = videoData.ownerName
        viewLabel.text = "\(videoData.viewCount) view(s)"
        
        if let videoUrl = getThumbnailImageURLToMatchView(videoImageView, fromVideoData: videoData) {
            videoImageView.setImage(from: videoUrl)
        }
    }
    
    private func getThumbnailImageURLToMatchView(_ view: UIView, fromVideoData videoData: VideoData) -> URL? {
        return URL(string: videoData.thumbnailURLString
            .replacingOccurrences(of: "%{width}", with: "\(Int(view.frame.width))")
            .replacingOccurrences(of: "%{height}", with: "\(Int(view.frame.height))"))
    }
}
