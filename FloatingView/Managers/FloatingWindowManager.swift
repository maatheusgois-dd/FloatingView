//
//  FloatingWindowManager.swift
//  FloatingView
//
//  Created by Matheus Gois on 23/04/25.
//  Copyright © 2025 DoorDash. All rights reserved.
//

import SwiftUI
import Combine

final class FloatingWindowManager: ObservableObject {
    private var window: PassthroughWindow?
    private var viewModel: FloatViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    func open() {
        guard let windowScene = UIApplication.shared
            .connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene else { return }
        
        let viewModel = FloatViewModel()
        self.viewModel = viewModel
        
        let content = FloatingOverlay(viewModel: viewModel)
        let host = UIHostingController(rootView: content)
        host.view.backgroundColor = .clear
        
        let passthroughWindow = PassthroughWindow(windowScene: windowScene)
        passthroughWindow.frame = UIScreen.main.bounds
        passthroughWindow.backgroundColor = .clear
        passthroughWindow.windowLevel = .alert + 1
        passthroughWindow.rootViewController = host
        passthroughWindow.makeKeyAndVisible()
        
        self.window = passthroughWindow
        
        viewModel.$currentBallPosition
            .receive(on: RunLoop.main)
            .sink { [weak self] position in
                guard let self = self, let window = self.window else { return }
                
                let size = viewModel.ballSize
                let rect = CGRect(x: position.x - size / 2,
                                  y: position.y - size / 2,
                                  width: size,
                                  height: size)
                
                window.touchableFrame = rect
            }
            .store(in: &cancellables)
        
        viewModel.$isPresenting
            .receive(on: RunLoop.main)
            .sink { [weak self] isPresenting in
                guard let self = self, let window = self.window else { return }
                window.forceTouchEnabled = isPresenting
            }
            .store(in: &cancellables)
        
        viewModel.$isBallVisible
            .receive(on: RunLoop.main)
            .sink { [weak self] isBallVisible in
                guard let self = self, let window = self.window else { return }
                if !isBallVisible {
                    self.close()
                }
            }
            .store(in: &cancellables)
        
    }
    
    func close() {
        window?.isHidden = true
        window = nil
        cancellables.removeAll()
    }
} 
