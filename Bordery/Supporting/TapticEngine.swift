//
//  TapticEngine.swift
//  Bordery
//
//  Created by Kevin Laminto on 12/11/19.
//  Copyright © 2019 Kevin Laminto. All rights reserved.
//

import Foundation
import UIKit

struct TapticEngine {

    /**
     Creates an error Taptic feedback
     */
    static func errorTaptic() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
    
    /**
     Creates a success Taptic feedback
     */
    static func successTaptic() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    /**
     Creates a warning Taptic feedback
     */
    static func warningTaptic() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
    }
    
    /**
     Creates a light Taptic feedback
     */
    static func lightTaptic() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()
        generator.impactOccurred()
    }
    
    /**
     Creates a medium Taptic feedback
     */
    static func mediumTaptic() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
    }
    
    /**
     Creates a heavy Taptic feedback
     */
    static func heavyTaptic() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.prepare()
        generator.impactOccurred()
    }
    
}
