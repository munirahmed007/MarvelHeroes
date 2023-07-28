//
//  MarvelComicView.swift
//  MavelCharacters
//
//  Created by Munir Ahmed on 28/07/2023.
//

import Cocoa

class MarvelComicView: NSView {
    private let imageView: NSImageView = {
        let imageView = NSImageView(frame: NSRect(x: 0, y: 28, width: 200, height: 150))
        // Add any additional image view configurations here (e.g., image, content mode)
        return imageView
    }()
    
    private let textField: NSTextField = {
        let textField = NSTextField(frame: NSRect(x: 0, y: 0, width: 200, height: 25))
        // Add any additional text field configurations here (e.g., font, alignment)
        textField.alignment = .center
        textField.backgroundColor = NSColor.clear
        textField.isBordered = false
        textField.isEditable = false
        textField.focusRingType = .none
        return textField
    }()
        
    public func setupSubviews(image: NSImage, description: String) {
        self.addSubview(imageView)
        self.addSubview(textField)
        
        imageView.image = image
        textField.stringValue = description
    }
}
