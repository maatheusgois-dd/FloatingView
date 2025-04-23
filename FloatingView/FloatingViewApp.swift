//
//  FloatingViewApp.swift
//  FloatingView
//
//  Created by Matheus Gois on 22/04/25.
//  Copyright © 2025 DoorDash. All rights reserved.
//

import SwiftUI

@main
struct FloatingViewApp: App {
    @StateObject private var windowManager = FloatingWindowManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(windowManager)
        }
    }
}
