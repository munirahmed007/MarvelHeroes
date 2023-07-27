//
//  AppDelegate.swift
//  MarvelComicHeroes
//
//  Created by Munir Ahmed on 27/07/2023.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        MarvelAPIService().requestMarvelCharacters(amount: 20) { result in
            switch result {
            case .success(let response):
                print("total characters \(response.total) - right now \(response.characters)")
                for character in response.characters {
                    MarvelAPIService().requestMarvelComics(of: character,
                                                           amount: 20) { result in
                        switch result {
                        case .success(let response):
                            print("total characters \(response.total) - right now \(response.commics)")
                        case .failure(let error):
                            print("I got into an error \(error)")
                        }
                    }
                }
            case .failure(let error):
                print("I got into an error \(error)")
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

