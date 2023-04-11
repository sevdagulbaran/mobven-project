//
//  DataFormatter+Ext.swift
//  MobvenProject
//
//  Created by Sevda Gul Baran on 10.04.2023.
//

import Foundation
import AVFoundation

extension DateFormatter {
    static func formatTime(duration: CMTime ) -> String {
        let timeInSeconds = CMTimeGetSeconds(duration)
        
        let hours = Int(timeInSeconds / 3600)
        let minutes = Int(timeInSeconds.truncatingRemainder(dividingBy: 3600) / 60)
        let seconds = Int(timeInSeconds.truncatingRemainder(dividingBy: 60))
        let durationString  = "\(hours):\(minutes):\(seconds)"
        
        return durationString
    }
}
