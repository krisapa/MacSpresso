//
//  AppDelegate.swift
//  MacSpresso
//
//  Created by ksp237 on 9/8/24.
//

import Cocoa
import SwiftUI

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    var popover: NSPopover!
    var statusBarItem: NSStatusItem!
    

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
            
        let contentView = Main()
        let popover = NSPopover()
        popover.contentSize = NSSize(width: 300, height: 300)
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: contentView)
        self.popover = popover
        
        self.popover.contentViewController?.view.window?.becomeKey()

        if let button = statusBarItem.button {
            button.image = NSImage(systemSymbolName: "cup.and.saucer.fill", accessibilityDescription: "Caffeinated")
    
            button.imagePosition = NSControl.ImagePosition.imageLeft
            button.action = #selector(togglePopover(_:))
            button.sendAction(on: [.leftMouseUp, .rightMouseUp])
        }
    }
    

    func applicationWillTerminate(_ aNotification: Notification) {
        CaffeinateService.shared.killCaffeinate()
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
    
    @objc func openAbout() {
        AboutWindowController.createWindow()
    }
    
    @objc func quit() {
        NSApp.terminate(self)
    }
    
    @objc func togglePopover(_ sender: AnyObject?) {
        let event = NSApp.currentEvent!

        if let button = statusBarItem.button {
            if event.type == .leftMouseUp {
                if popover.isShown {
                    popover.performClose(sender)
                } else {
                    NSApp.activate(ignoringOtherApps: true)
                    popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
                }
            } else if event.type == .rightMouseUp {
                let menu = NSMenu()
                menu.addItem(withTitle: "About MacSpresso", action: #selector(openAbout), keyEquivalent: "c")
                menu.addItem(NSMenuItem.separator())
                if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                    menu.addItem(NSMenuItem(title: "MacSpresso v\(appVersion)", action: nil, keyEquivalent: ""))
                }
                menu.addItem(withTitle: "Quit App", action: #selector(quit), keyEquivalent: "q")

                statusBarItem.menu = menu
                statusBarItem.button?.performClick(nil)
                statusBarItem.menu = nil
            }
        }
    }

}

