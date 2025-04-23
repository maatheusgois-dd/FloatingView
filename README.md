# FloatingView

A SwiftUI-based floating view implementation that allows for draggable, interactive floating elements in iOS applications.


https://github.com/user-attachments/assets/fdc2a1e9-1586-45dd-b92f-5787035109dd



## Features

- Draggable floating ball that snaps to screen edges
- Interactive cancel zone for removing the floating element
- Smooth animations and transitions
- Customizable appearance and behavior
- Overlay presentation with expanding circle animation

## Project Structure

```
FloatingView/
├── Views/
│   ├── FloatBallView.swift      # Draggable floating ball implementation
│   ├── BottomFloatView.swift    # Cancel zone view
│   └── FloatingView.swift       # Main floating view with overlay
├── Models/
│   └── FloatViewModel.swift     # View model managing state and behavior
├── Managers/
│   ├── FloatingWindowManager.swift  # Window management
│   └── PassthroughWindow.swift      # Custom window implementation
├── Utils/
│   └── ExpandingCircle.swift    # Custom shape for overlay animation
└── ContentView.swift            # Main app view
```

## Components

### FloatBallView
- A draggable circular view that snaps to screen edges
- Handles touch gestures and animations
- Manages position and visibility state

### BottomFloatView
- Represents the cancel zone at the bottom of the screen
- Changes appearance based on interaction state
- Provides visual feedback for drag operations

### FloatingView
- Main overlay view that appears when the floating ball is tapped
- Uses expanding circle animation for presentation
- Contains dismiss functionality

### FloatViewModel
- Manages the state of the floating view system
- Handles position calculations and edge snapping
- Controls visibility and presentation states

### FloatingWindowManager
- Manages the floating window lifecycle
- Handles window creation and dismissal
- Coordinates between views and window system

## Usage

1. Initialize the `FloatingWindowManager`:
```swift
@StateObject private var windowManager = FloatingWindowManager()
```

2. Add controls to show/hide the floating view:
```swift
Button("Show Floating View") {
    windowManager.open()
}

Button("Hide Floating View") {
    windowManager.close()
}
```

3. Customize the appearance by modifying the view model properties:
```swift
let viewModel = FloatViewModel()
viewModel.ballSize = 80  // Change ball size
viewModel.padding = 20   // Adjust edge padding
```

## Requirements

- iOS 15.0+
- Swift 5.5+
- Xcode 13.0+

## Installation

1. Clone the repository
2. Open the project in Xcode
3. Build and run

## License

Copyright © 2025 DoorDash. All rights reserved. 
