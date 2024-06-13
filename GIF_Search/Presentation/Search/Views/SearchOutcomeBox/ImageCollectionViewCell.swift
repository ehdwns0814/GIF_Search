//
//  ImageCollectionViewCell.swift
//  GIF_Search
//
//  Created by 동준 on 5/28/24.
//

import UIKit
import AVFoundation

final class ImageCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "imageCell"
    
    private let videoView: VideoView = {
        let imageView = VideoView()
        return imageView
    }()
    
    private var player: AVPlayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setHierarchy()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.player = nil
    }
    
    func configureContent(_ viewModel: ImageObjectViewModel) {
        guard let videoURL = URL(string: viewModel.image.imageCollection.mp4URL) else {
            return
        }
        
        CacheManager.fetchVideo(videoURL: videoURL) { asset in
            self.player = AVPlayer(playerItem: AVPlayerItem(asset: asset))
            DispatchQueue.main.async {
                self.videoView.player = self.player
                self.player?.play()
                self.player?.actionAtItemEnd = .none
                NotificationCenter.default.addObserver(
                    forName: AVPlayerItem.didPlayToEndTimeNotification,
                    object: self.player?.currentItem,
                    queue: .main
                ) { [weak self] _ in
                    self?.player?.seek(to: CMTime.zero)
                    self?.player?.play()
                }
            }
        }
    }
    
    private func setHierarchy() {
        self.contentView.addSubview(self.videoView)
    }
    
    private func setConstraint() {
        self.contentView.clipsToBounds = true
        self.contentView.layer.cornerRadius = 10
        self.videoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.videoView.topAnchor.constraint(
                equalTo: self.contentView.topAnchor
            ),
            self.videoView.leadingAnchor.constraint(
                equalTo: self.leadingAnchor
            ),
            self.videoView.trailingAnchor.constraint(
                equalTo: self.contentView.trailingAnchor
            ),
            self.videoView.bottomAnchor.constraint(
                equalTo: self.contentView.bottomAnchor
            )
        ])
    }
    
    func playVideo() {
        self.player?.play()
    }
    
    func stopVideo() {
        self.player?.play()
    }
}
