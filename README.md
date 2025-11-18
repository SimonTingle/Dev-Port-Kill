# KillPortApp - macOS Menu Bar Port Killer

![macOS](https://img.shields.io/badge/macOS-11.0+-blue?style=flat&logo=apple)
![Swift](https://img.shields.io/badge/Swift-5.5+-orange?style=flat&logo=swift)
![License](https://img.shields.io/badge/License-MIT-green?style=flat)

A native macOS menu bar application that helps developers quickly terminate processes running on specific ports. Perfect for resolving port conflicts during development.

## 🚀 Features

- **🖥️ Menu Bar Integration** - Always accessible from your menu bar
- **⚡ Quick Port Killing** - Terminate processes with one click
- **🔧 No Dependencies** - Uses built-in macOS tools (no Node.js required)
- **🎯 Smart Defaults** - Configurable default ports and protocols
- **📊 Result History** - Visual feedback with success/failure states
- **🚀 Auto-Start** - Launch at login for convenience
- **🎨 Native UI** - Clean SwiftUI interface with macOS design

## 📸 Screenshots

*Config Window with port input and results history*
*First-run onboarding experience*
*Menu bar icon with quick access*

## 🛠️ System Requirements

- **macOS** 11.0 or later
- **Xcode** 13.0 or later (for building from source)
- **Swift** 5.5 or later

## 📦 Installation

### Option 1: Download Pre-built Binary
*(Coming soon - download the latest release from GitHub Releases)*

### Option 2: Build from Source

```bash
# Clone or download the project
cd KillPortApp

# Build the project
swift build -c release

# Run the application
./.build/release/KillPortApp
