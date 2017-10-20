//
//  BasicKey.swift
//  TouchBarPiano
//
//  Created by Joshua Breeden on 11/11/16.
//  Copyright © 2016 Joshua Breeden. All rights reserved.
//

import Cocoa

@available(OSX 10.12.2, *)
class BasicKey: NSView {

    // key press closure
    var onKeyPress: ((NSView) -> (Void))?

    // key release closure
    var onKeyRelease: ((NSView) -> (Void))?

    // key slide/pitch bend closure
    var onKeySlide: ((NSView, CGFloat) -> (Void))?

    var touch:NSTouch?

    override func touchesBegan(with event: NSEvent) {
        touch = event.touches(matching: .began, in: self).first
        onKeyPress?(self)
    }

    override func touchesMoved(with event: NSEvent) {
        if let move = event.touches(matching:.moved, in: self).first {
            let diff = move.location(in: self).x - touch!.location(in: self).x
            onKeySlide?(self, diff)
        }
    }

    override func touchesEnded(with event: NSEvent) {
        onKeyRelease?(self)
        touch = nil
    }

    override func touchesCancelled(with event: NSEvent) {
        onKeyRelease?(self)
        touch = nil
    }
    
}
