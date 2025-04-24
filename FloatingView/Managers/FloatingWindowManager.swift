//
//  FloatingView.swift
//  FloatingView
//
//  Created by Matheus Gois on 23/04/25.
//  Copyright © 2025 DoorDash. All rights reserved.
//

import Combine
import SwiftUI

public final class FloatingWindowManagerImpl: ObservableObject, FloatingWindowManager {
    private var window: PassthroughWindow?
    private var viewModel: FloatViewModel?
    private var cancellables = Set<AnyCancellable>()
    private var content: AnyView

    public init<Content: View>(content: Content) {
        self.content = AnyView(content)
    }
    
    public func open() {
        guard let windowScene = UIApplication.shared
            .connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene else {
            return
        }
        
        let viewModel = FloatViewModel()
        self.viewModel = viewModel
        
        let overlay = FloatingOverlay(viewModel: viewModel) {
            self.content
        }
        
        let host = UIHostingController(rootView: overlay)
        host.view.backgroundColor = .clear
        
        let passthroughWindow = PassthroughWindow(windowScene: windowScene)
        passthroughWindow.frame = UIScreen.main.bounds
        passthroughWindow.backgroundColor = .clear
        passthroughWindow.windowLevel = .alert + 1
        passthroughWindow.rootViewController = host
        passthroughWindow.makeKeyAndVisible()
        
        window = passthroughWindow
        
        viewModel.$currentBallPosition
            .receive(on: RunLoop.main)
            .sink { [weak self] position in
                guard let self, let window = self.window else { return }
                
                let size = viewModel.ballSize
                let rect = CGRect(
                    x: position.x - size / 2,
                    y: position.y - size / 2,
                    width: size,
                    height: size
                )
                window.touchableFrame = rect
            }
            .store(in: &cancellables)
        
        viewModel.$isPresenting
            .receive(on: RunLoop.main)
            .sink { [weak self] isPresenting in
                guard let self, let window = self.window else { return }
                window.forceTouchEnabled = isPresenting
            }
            .store(in: &cancellables)
        
        viewModel.$isBallVisible
            .receive(on: RunLoop.main)
            .sink { [weak self] isBallVisible in
                guard let self else { return }
                if !isBallVisible {
                    self.close()
                }
            }
            .store(in: &cancellables)
    }
    
    public func close() {
        window?.isHidden = true
        window = nil
        cancellables.removeAll()
    }
}

public protocol FloatingWindowManager {
    func open()
    func close()
}
