//
//  VideoPlayerViewController.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 10.04.2023.
//

import UIKit
import AVFoundation

final class VideoPlayerViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var durationLabel: UILabel!
    
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    
    var isPlaying: Bool = false
    var playbackSpeed: Float = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        setVideoPlayer()
        setupTimeObserver()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer.frame = playerView.bounds
    }
    
    //MARK: - Private Methods
    
    private func setVideoPlayer() {
        guard let videoPath = Bundle.main.path(forResource: "testVideo", ofType: "mp4") else {
            print("Video path not found.")
            return
        }
        
        let videoPathURL = URL(fileURLWithPath: videoPath)
        player = AVPlayer(url: videoPathURL)
        
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resize
        
        playerView.layer.addSublayer(playerLayer)
    }
    
    private func setupTimeObserver() {
        let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        let mainQeue = DispatchQueue.main
        
        _ = player.addPeriodicTimeObserver(forInterval: interval, queue: mainQeue, using: { [weak self] time in
            
            guard let self = self else { return}
            guard let current = self.player.currentItem else {
                return
            }
            
            self.timeSlider.maximumValue = Float(current.duration.seconds)
            self.timeSlider.minimumValue = 0
            self.timeSlider.value = Float(current.currentTime().seconds)
            
            let currentTime = current.currentTime()
            self.durationLabel.text = DateFormatter.formatTime(duration: currentTime)
        })
        
    }

    //MARK: - Actions
    @IBAction private func playButtonTapped(_ sender: UIButton) {
        
        if isPlaying {
            player.pause()
        } else {
            player.play()
        }
        
        isPlaying.toggle()
        
        let buttonText = !isPlaying ? "Play" : "Pause"
        sender.setTitle(buttonText, for: .normal)
    }
    
    @IBAction private func forwardButtonTapped(_ sender: UIButton) {
        guard let currentDuration = player.currentItem?.duration else {
            return
        }
        
        let currentTime = CMTimeGetSeconds(player.currentTime())
        let newTime = currentTime + 10.0
        
        if newTime < (CMTimeGetSeconds(currentDuration) - 5.0) {
            let time = CMTimeMake(value: Int64(newTime * 1000), timescale: 1000)
            player.seek(to: time)
        }
    }
    
    @IBAction private func backButtonTapped(_ sender: UIButton) {
        let currentTime = CMTimeGetSeconds(player.currentTime())
        var newTime = currentTime - 10.0
        
        if newTime < 0 {
            newTime = 0
        }
        
        let time = CMTimeMake(value: Int64(newTime * 1000), timescale: 1000)
        player.seek(to: time)
    }
    
    @IBAction private func timeSliderAction(_ sender: UISlider) {
        player.seek(to: CMTimeMake(value: Int64(sender.value * 1000), timescale: 1000))
    }
    
    @IBAction private func speedUpButtonTapped(_ sender: UIButton) {
        playbackSpeed += 0.25
        player.rate = playbackSpeed
    }
    
    @IBAction private func speedDownButtonTapped(_ sender: UIButton) {
        if playbackSpeed > 0.25 {
            playbackSpeed -= 0.25
            player.rate = playbackSpeed
        }
    }
}

