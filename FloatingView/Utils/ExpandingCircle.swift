//
//  ExpandingCircle.swift
//  FloatingView
//
//  Created by Matheus Gois on 23/04/25.
//  Copyright © 2025 DoorDash. All rights reserved.
//

import SwiftUI

struct ExpandingCircle: Shape {
    var center: CGPoint
    var scale: CGFloat
    
    var animatableData: CGFloat {
        get { scale }
        set { scale = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius = max(rect.width, rect.height) * scale
        path.addEllipse(in: CGRect(
            x: center.x - radius,
            y: center.y - radius,
            width: radius * 2,
            height: radius * 2
        ))
        return path
    }
} 
