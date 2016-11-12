//
//  SolidColorView.swift
//  TouchBarPiano
//
//  Created by Joshua Breeden on 11/11/16.
//  Copyright © 2016 Joshua Breeden. All rights reserved.
//

import Cocoa

@IBDesignable
class SolidColorView: NSView {

    @IBInspectable
    var color = NSColor.black { didSet { setNeedsDisplay(bounds) } }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
        let path = NSBezierPath(rect: bounds)
        color.set()
        path.fill()
    }
    
}
