//
//  FloatingView.swift
//  FloatingView
//
//  Created by Matheus Gois on 23/04/25.
//  Copyright © 2025 DoorDash. All rights reserved.
//

import SwiftUI

struct FloatingView: View {
    @ObservedObject var viewModel: FloatViewModel
    let screenSize = UIScreen.main.bounds

    @State private var reveal = false

    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
                .overlay(
                    VStack {
                        Spacer()
                        Button("Close") {
                            reveal = false

                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                                viewModel.isPresenting = false
                            }
                        }
                        .padding(.bottom, 40)
                    }
                )
                .clipShape(
                    ExpandingCircle(center: viewModel.currentBallPosition, scale: reveal ? 1 : 0.01)
                )
                .animation(.spring(response: 0.8, dampingFraction: 1), value: reveal)
                .onAppear {
                    reveal = true
                }
        }
    }
} 
