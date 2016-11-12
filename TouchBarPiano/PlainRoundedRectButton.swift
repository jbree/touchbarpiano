//
//  PlainRoundedRectButton.swift
//  TouchBarPiano
//
//  Created by Joshua Breeden on 11/12/16.
//  Copyright © 2016 Joshua Breeden. All rights reserved.
//

import Cocoa

@IBDesignable
class PlainRoundedRectButton: NSButton {

    @IBInspectable
    var cornerRadius:CGFloat = 8.0

    @IBInspectable
    var borderThickness:CGFloat = 1.5

    @IBInspectable
    var backgroundColor:NSColor = NSColor.white

    @IBInspectable
    var borderColor:NSColor = NSColor.black

    override func draw(_ dirtyRect: NSRect) {
        var insetBounds = bounds
        insetBounds.size.width -= borderThickness
        insetBounds.size.height -= borderThickness
        insetBounds.origin.x += borderThickness / 2.0
        insetBounds.origin.y += borderThickness / 2.0

        let path = NSBezierPath(roundedRect: insetBounds, xRadius: cornerRadius, yRadius: cornerRadius)
        path.lineWidth = borderThickness

        backgroundColor.setFill()
        borderColor.setStroke()

        path.fill()
        path.stroke()
    }
    
}
