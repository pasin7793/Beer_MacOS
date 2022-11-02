//
//  AppDelegate.swift
//  Beer_MacOS
//
//  Created by 임준화 on 2022/11/02.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    
    private var statusItem: NSStatusItem!
    private var popover: NSPopover!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let statusButton = statusItem.button{
            statusButton.image = NSImage(systemSymbolName: "drop", accessibilityDescription: "drop")
            statusButton.action = #selector(togglePopover)
        }
        self.popover = NSPopover()
        self.popover.behavior = .transient
        self.popover.contentSize = NSSize(width: 400, height: 200)
        self.popover.contentViewController = ViewController()
    }
    
    @objc func togglePopover(){
        if let button = statusItem.button{
            if popover.isShown{
                self.popover.performClose(false)
            }else{
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            }
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }


}

