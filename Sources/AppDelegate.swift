import SwiftUI
import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusBarItem: NSStatusItem!
    var popover: NSPopover!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Check if first run
        let hasCompletedSetup = UserDefaults.standard.bool(forKey: "hasCompletedSetup")
        
        if !hasCompletedSetup {
            showFirstRunWindow()
        }
        
        setupStatusBar()
    }
    
    func setupStatusBar() {
        statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusBarItem.button {
            button.image = NSImage(systemSymbolName: "network", accessibilityDescription: "Kill Port")
            button.action = #selector(togglePopover(_:))
            button.target = self
        }
        
        setupPopover()
    }
    
    func setupPopover() {
        popover = NSPopover()
        popover.contentSize = NSSize(width: 300, height: 400)
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: ConfigView())
    }
    
    @objc func togglePopover(_ sender: AnyObject?) {
        if let button = statusBarItem.button {
            if popover.isShown {
                popover.performClose(sender)
            } else {
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
            }
        }
    }
    
    func showFirstRunWindow() {
        let firstRunWindow = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 400, height: 300),
            styleMask: [.titled, .closable],
            backing: .buffered,
            defer: false
        )
        firstRunWindow.center()
        firstRunWindow.title = "Welcome to Kill Port App"
        firstRunWindow.contentView = NSHostingView(rootView: FirstRunView())
        firstRunWindow.makeKeyAndOrderFront(nil)
        
        // Make it modal
        NSApp.runModal(for: firstRunWindow)
    }
}
