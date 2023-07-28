//
//  MarvelProgressBlockingView.swift
//  MavelCharacters
//
//  Created by Munir Ahmed on 28/07/2023.
//

import Cocoa

import Cocoa

class MarvelBlockingProgressView: NSView {

    private let progressIndicator: NSProgressIndicator = {
        let progressIndicator = NSProgressIndicator()
        progressIndicator.style = .spinning
        progressIndicator.controlSize = .large
        progressIndicator.isIndeterminate = true
        progressIndicator.translatesAutoresizingMaskIntoConstraints = false
        return progressIndicator
    }()

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        commonInit()
    }

    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        commonInit()
    }

    private func commonInit() {
        wantsLayer = true
        isHidden = true
        layer?.backgroundColor = NSColor(white: 0, alpha: 0.3).cgColor
        addSubview(progressIndicator)

        NSLayoutConstraint.activate([
            progressIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            progressIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    override func hitTest(_ point: NSPoint) -> NSView? {
        // Return the view beneath the top view to pass the events through
        return nil
    }
    
    func setProgress(_ progress: Double) {
        progressIndicator.doubleValue = progress
    }

    func show() {
        progressIndicator.startAnimation(nil)
        isHidden = false
    }

    
    func hide() {
        progressIndicator.stopAnimation(nil)
        isHidden = true
    }
}
