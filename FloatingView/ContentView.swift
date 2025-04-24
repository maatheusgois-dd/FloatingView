//
//  ContentView.swift
//  FloatingView
//
//  Created by Matheus Gois on 22/04/25.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject private var windowManager = FloatingWindowManagerImpl(content: InternalContentView())
    
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

struct InternalContentView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Hello, World!")
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color.brown)
        }
        .ignoresSafeArea()
    }
}
