//
//  ContentView.swift
//  FloatingView
//
//  Created by Matheus Gois on 22/04/25.
//  Copyright © 2025 DoorDash. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    @EnvironmentObject var windowManager: FloatingWindowManager
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Main App Window")
            
            Button("Open Overlay") {
                windowManager.open()
            }
            
            Button("Close Overlay", role: .cancel) {
                windowManager.close()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
