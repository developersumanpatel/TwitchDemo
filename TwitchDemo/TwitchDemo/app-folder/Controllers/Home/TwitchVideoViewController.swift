//
//  TwitchVideoViewController.swift
//  TwitchDemo
//
//  Created by Suman on 26/04/20.
//  Copyright © 2020 Suman. All rights reserved.
//

import UIKit

class TwitchVideoViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorLabel: UILabel!
    lazy var presenter = TwitchVideoPresenter(provider: TwitchVideoProvider(), delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.getToken()
    }
    
    func setupUI() {
        tableView.estimatedRowHeight = 100.0
        tableView.tableFooterView = UIView()
    }
}

extension TwitchVideoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension TwitchVideoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.videos?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell"), let videoCell = cell as? VideoCell, let data = presenter.videos?[indexPath.row] else {
            return UITableViewCell()
        }
        
        videoCell.configureData(videoData: data)
        return videoCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailViewController = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            return
        }
        detailViewController.videos = presenter.videos ?? []
        detailViewController.currentIndex = indexPath.row
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension TwitchVideoViewController: TwitchVideoDelegate {
    func finishGettingVideoWithSuccess() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.isHidden = false
            self.errorLabel.text = ""
        }
        
    }
    
    func finishGettingVideoWithError(message: String) {
        DispatchQueue.main.async {
            self.tableView.isHidden = true
            self.errorLabel.text = message
        }
    }
}
