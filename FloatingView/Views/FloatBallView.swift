//
//  FloatBallView.swift
//  FloatingView
//
//  Created by Matheus Gois on 23/04/25.
//

import SwiftUI

struct FloatBallView: View {
    @ObservedObject var viewModel: FloatViewModel
    @GestureState private var dragOffset = CGSize.zero
    @State private var currentPosition: CGPoint
    
    init(viewModel: FloatViewModel) {
        self.viewModel = viewModel
        _currentPosition = State(initialValue: viewModel.initialBallPosition)
    }
    
    var body: some View {
        GeometryReader { geometry in
            Circle()
                .fill(Color.brown)
                .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 0)
                .frame(width: viewModel.ballSize, height: viewModel.ballSize)
                .frame(width: viewModel.ballSize, height: viewModel.ballSize)
                .position(
                    x: currentPosition.x + dragOffset.width,
                    y: currentPosition.y + dragOffset.height
                )
                .gesture(
                    DragGesture()
                        .updating($dragOffset) { value, state, _ in
                            viewModel.isDragging = true
                            state = value.translation
                            let draggedPoint = CGPoint(
                                x: currentPosition.x + state.width,
                                y: currentPosition.y + state.height
                            )
                            viewModel.currentBallPosition = draggedPoint
                            viewModel.updateBottomState(with: draggedPoint, screenSize: geometry.size)
                        }
                        .onEnded { value in
                            withAnimation(.easeInOut(duration: 0.3)) {
                                viewModel.isDragging = false
                            }
                            
                            let draggedX = currentPosition.x + value.translation.width
                            let draggedY = currentPosition.y + value.translation.height
                            currentPosition = CGPoint(x: draggedX, y: draggedY)
                            
                            let snappedX = viewModel.closestVerticalEdgeX(from: draggedX, screenWidth: geometry.size.width)
                            let clampedY = viewModel.clampY(draggedY, screenHeight: geometry.size.height)
                            
                            withAnimation(.easeInOut(duration: viewModel.snapAnimationDuration)) {
                                let snapped = CGPoint(x: snappedX, y: clampedY)
                                currentPosition = snapped
                                viewModel.currentBallPosition = snapped
                            }
                            
                            viewModel.handleBallDrop(in: geometry.size)
                        }
                )
                .onTapGesture {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                        viewModel.isPresenting = true
                    }
                }
                .opacity(viewModel.isBallVisible ? 1.0 : 0.0)
                .onAppear {
                    currentPosition = viewModel.initialBallPosition
                    viewModel.currentBallPosition = currentPosition
                }
                .accessibilityIdentifier("floatBall")
        }
    }
}
