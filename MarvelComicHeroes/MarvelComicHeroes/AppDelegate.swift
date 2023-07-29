//
//  AppDelegate.swift
//  MarvelComicHeroes
//
//  Created by Munir Ahmed on 27/07/2023.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

     var window: NSWindow?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let mainWindow = NSApp.mainWindow {
            window = mainWindow
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if let window = window {
            window.makeKeyAndOrderFront(self)
        }
        return true
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }


}

