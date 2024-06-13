//
//  VideoView.swift
//  GIF_Search
//
//  Created by 동준 on 6/12/24.
//

import Foundation
import UIKit
import AVKit
import AVFoundation

final class VideoView: UIView {
    
    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    
    var playerLayer: AVPlayerLayer? {
        guard let layer = self.layer as? AVPlayerLayer else {
            return nil
        }
        layer.videoGravity = .resizeAspectFill
        return layer
    }
    
    var player: AVPlayer? {
        get {
            return playerLayer?.player
        }
        
        set {
            playerLayer?.player = newValue
        }
    }
}
