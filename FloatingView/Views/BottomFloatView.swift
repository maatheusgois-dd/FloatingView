//
//  BottomFloatView.swift
//  FloatingView
//
//  Created by Matheus Gois on 23/04/25.
//  Copyright © 2025 DoorDash. All rights reserved.
//

import SwiftUI

struct BottomFloatView: View {
    let state: BottomFloatState
    
    @State private var position = CGPoint(x: UIScreen.main.bounds.width + 80,
                                          y: UIScreen.main.bounds.height + 80)
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            if state == .normal {
                Image(systemName: "circle")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.white)
                    .offset(x: -30, y: -30)
            } else {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundStyle(.white)
                    .offset(x: -30, y: -30)
            }
        }
        .frame(width: 160, height: 160)
        .background(state == .cancelZoneEntered ? Color.red : Color.red.opacity(0.6))
        .clipShape(Circle())
        .position(position)
        .onAppear {
            withAnimation(.easeInOut(duration: 0.3)) {
                position = CGPoint(x: UIScreen.main.bounds.width - 10,
                                   y: UIScreen.main.bounds.height - 10)
            }
        }
        .animation(.easeInOut, value: state)
    }
} 
