//
//  FloatViewModel.swift
//  FloatingView
//
//  Created by Matheus Gois on 23/04/25.
//  Copyright © 2025 DoorDash. All rights reserved.
//

import SwiftUI
import Combine

enum BottomFloatState {
    case normal
    case cancelZoneEntered
}

final class FloatViewModel: ObservableObject {
    @Published var isBallVisible = true
    @Published var bottomState: BottomFloatState = .normal
    @Published var currentBallPosition: CGPoint = .zero
    @Published var isDragging = false
    @Published var isPresenting = false
    
    let ballSize: CGFloat = 40
    let padding: CGFloat = 10
    let snapAnimationDuration: Double = 0.3
    
    var initialBallPosition: CGPoint {
        CGPoint(x: padding + ballSize / 2, y: 300)
    }
    
    func snapX(_ x: CGFloat, screenWidth: CGFloat) -> CGFloat {
        let centerX = screenWidth / 2
        return x < centerX
        ? padding + ballSize / 2
        : screenWidth - padding - ballSize / 2
    }
    
    func updateBottomState(with point: CGPoint, screenSize: CGSize) {
        let cancelZone = CGRect(
            x: screenSize.width - 160,
            y: screenSize.height - 160,
            width: 160,
            height: 160
        )
        
        bottomState = cancelZone.contains(point) ? .cancelZoneEntered : .normal
    }
    
    func handleBallDrop(in screenSize: CGSize) {
        if bottomState == .cancelZoneEntered {
            isBallVisible = false
        }
        bottomState = .normal
    }
    
    func closestVerticalEdgeX(from x: CGFloat, screenWidth: CGFloat) -> CGFloat {
        let leftEdge = padding + ballSize / 2
        let rightEdge = screenWidth - padding - ballSize / 2
        let distanceToLeft = abs(x - leftEdge)
        let distanceToRight = abs(x - rightEdge)
        return distanceToLeft < distanceToRight ? leftEdge : rightEdge
    }
    
    func clampY(_ y: CGFloat, screenHeight: CGFloat) -> CGFloat {
        let top = padding + ballSize / 2
        let bottom = screenHeight - padding - ballSize / 2
        return min(max(y, top), bottom)
    }
} 
