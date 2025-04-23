//
//  FloatingOverlay.swift
//  FloatingView
//
//  Created by Matheus Gois on 23/04/25.
//  Copyright © 2025 DoorDash. All rights reserved.
//

import SwiftUI

struct FloatingOverlay: View {
    @ObservedObject var viewModel: FloatViewModel
    
    var body: some View {
        ZStack {
            FloatBallView(viewModel: viewModel)
            
            if viewModel.isDragging {
                BottomFloatView(state: viewModel.bottomState)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .zIndex(-1)
            }
            
            if viewModel.isPresenting {
                FloatingView(viewModel: viewModel)
                    .transition(.identity)
                    .zIndex(1)
            }
        }
        .ignoresSafeArea()
        .background(Color.clear)
    }
}
