//
//  FloatingView.swift
//  FloatingView
//
//  Created by Matheus Gois on 23/04/25.
//  Copyright © 2025 DoorDash. All rights reserved.
//

import SwiftUI

struct FloatingView<Content: View>: View {
    @ObservedObject var viewModel: FloatViewModel
    @State private var reveal = false
    let content: () -> Content

    var body: some View {
        GeometryReader { geo in
            let screenWidth = geo.size.width
            let screenHeight = geo.size.height
            
            let diagonal = sqrt(pow(screenWidth, 2) + pow(screenHeight, 2))
            
            let coverageMultiplier: CGFloat = 2
            let finalDiameter = diagonal * coverageMultiplier
            
            let offsetX = viewModel.currentBallPosition.x - screenWidth / 2
            let offsetY = viewModel.currentBallPosition.y - screenHeight / 2

            NavigationStack {
                content()
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                withAnimation {
                                    reveal = false
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                                    viewModel.isPresenting = false
                                }
                            } label: {
                                Image(systemName: "xmark")
                            }
                        }
                    }
            }
            .frame(width: screenWidth, height: screenHeight)
            .mask(
                Circle()
                    .frame(width: finalDiameter, height: finalDiameter)
                    .scaleEffect(reveal ? 1 : 0.01)
                    .offset(x: offsetX, y: offsetY)
            )
            .animation(.spring(response: 0.8, dampingFraction: 1), value: reveal)
            .onAppear {
                reveal = true
            }
        }
        .ignoresSafeArea()
    }
}
