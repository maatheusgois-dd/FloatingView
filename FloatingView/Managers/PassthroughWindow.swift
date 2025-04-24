//
//  PassthroughWindow.swift
//  FloatingView
//
//  Created by Matheus Gois on 23/04/25.
//

import UIKit

final class PassthroughWindow: UIWindow {
    var touchableFrame: CGRect = .zero
    var forceTouchEnabled = false
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if forceTouchEnabled || touchableFrame.contains(point) {
            return super.hitTest(point, with: event)
        }
        return nil
    }
} 
