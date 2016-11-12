//
//  PianoView.swift
//  MIDIBar
//
//  Created by Joshua Breeden on 11/1/16.
//  Copyright © 2016 Joshua Breeden. All rights reserved.
//

import Cocoa

@available(OSX 10.12.1, *)
class PianoView: NSView {
    
    private let numberOfKeys = 12

    private let blackKeyHeight = CGFloat(26.0)

    private let backgroundColor = NSColor.black

    private let selectedWhiteColor = NSColor(calibratedWhite: 0.4, alpha: 1.0)

    private let selectedBlackColor = NSColor(calibratedWhite: 0.3, alpha: 1.0)

    private let separatorColor = NSColor(calibratedWhite: 0.083, alpha: 1.0)

    private let whiteKeyColor = NSColor(calibratedWhite: 0.166, alpha: 1.0)

    private let blackKeyColor = NSColor.black

    private let cornerRadius = CGFloat(13.0)

    private let spacing = CGFloat(1.0)

    private var keyWidth:CGFloat {
        get {
            return bounds.width / CGFloat(numberOfKeys)
        }
    }

    var touchedKeys = [Int]()

    enum KeyType {
        case black
        case white
    }

    let keyType:[KeyType] = [.white, .black, .white, .black, .white, .white, .black, .white, .black, .white, .black, .white]

    override var acceptsFirstResponder: Bool { return true }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        backgroundColor.set()
        NSBezierPath(rect: bounds).fill()

        let top = CGFloat(bounds.height)
        let effectiveTop = CGFloat(bounds.height - cornerRadius)

        let whiteBottom = CGFloat(0)
        let whiteEffectiveBottom = CGFloat(whiteBottom + cornerRadius)

        let blackBottom = CGFloat(bounds.height - blackKeyHeight)
        let blackEffectiveBottom = CGFloat(blackBottom + cornerRadius)

        for keyNumber in touchedKeys {
            if keyType[keyNumber] == .black {
                // paint a gradient
                let keyRect = NSRect(x: keyWidth * CGFloat(keyNumber) - spacing,
                                     y: bounds.height - blackKeyHeight,
                                     width: keyWidth + spacing * 2.0,
                                     height: blackKeyHeight * 1.2)
                let gradient = NSGradient(starting: selectedBlackColor, ending: backgroundColor)
                gradient?.draw(in: keyRect, angle: 90)
            }
        }

        for keyNumber in 0..<numberOfKeys {

            if keyType[keyNumber] == .black {
                continue
            }

            let left = keyWidth * CGFloat(keyNumber) + spacing
            let effectiveLeft = left + cornerRadius
            let right = keyWidth * CGFloat(keyNumber) + keyWidth - spacing
            let effectiveRight = right - cornerRadius

            let path = NSBezierPath()

            if keyNumber > 0, keyType[keyNumber - 1] == .white {
                // white key to the left, square the corner
                path.move(to: NSPoint(x: left, y: top))
            } else {
                path.move(to: NSPoint(x: left, y: effectiveTop))

            }

            path.curve(to: NSPoint(x: effectiveLeft, y: top),
                       controlPoint1: NSPoint(x: left, y: top),
                       controlPoint2: NSPoint(x: left, y: top))

            // go horizontal across top
            path.line(to: NSPoint(x: effectiveRight, y: top))

            // if the key to the right is a white key, this should be squared off.
            if keyNumber + 1 < numberOfKeys, keyType[keyNumber + 1] == .white {
                path.line(to: NSPoint(x: right, y: top))
            } else {
                // otherwise, rounded
                path.curve(to: NSPoint(x: right, y: effectiveTop),
                           controlPoint1: NSPoint(x: right, y: top),
                           controlPoint2: NSPoint(x: right, y: top))

            }

            // vertical to bottom
            path.line(to: NSPoint(x: right, y: blackEffectiveBottom))

            // if the next key is black, we need to draw the underbar portion
            if keyNumber + 1 < numberOfKeys {
                if keyType[keyNumber + 1] == .black {
                    path.curve(to: NSPoint(x: right + cornerRadius, y: blackBottom),
                               controlPoint1: NSPoint(x: right,     y: blackBottom),
                               controlPoint2: NSPoint(x: right,     y: blackBottom))

                    path.line(to: NSPoint(x: right + keyWidth / 2.0, y: blackBottom))
                    path.line(to: NSPoint(x: right + keyWidth / 2.0, y: whiteBottom))
                } else {
                    // if it's white, square it off.
                    path.line(to: NSPoint(x: right, y: whiteBottom))
                }
            } else {
                // but if this is the last key, round it off
                path.line(to: NSPoint(x: right, y: whiteEffectiveBottom))
                path.curve(to: NSPoint(x: effectiveRight, y: whiteBottom),
                           controlPoint1: NSPoint(x: right, y: whiteBottom),
                           controlPoint2: NSPoint(x: right, y: whiteBottom))
            }

            // horizontal line along the bottom
            path.line(to: NSPoint(x: effectiveLeft, y: whiteBottom))

            if keyNumber > 0 {
                if keyType[keyNumber - 1] == .black {
                    // black key to the left, draw underbar
                    path.line(to: NSPoint(x: left - keyWidth / 2.0, y: whiteBottom))
                    path.line(to: NSPoint(x: left - keyWidth / 2.0, y: blackBottom))
                    path.line(to: NSPoint(x: left - cornerRadius,   y: blackBottom))

                    path.curve(to: NSPoint(x: left, y: blackEffectiveBottom),
                               controlPoint1: NSPoint(x: left, y: blackBottom),
                               controlPoint2: NSPoint(x: left, y: blackBottom))
                } else {
                    // white key to the left, square it off
                    path.line(to: NSPoint(x: left, y: whiteBottom))
                }
            } else {
                // no key to the left, round it off
                path.curve(to: NSPoint(x: left, y: whiteEffectiveBottom),
                           controlPoint1: NSPoint(x: left, y: whiteBottom),
                           controlPoint2: NSPoint(x: left, y: whiteBottom))
            }

            path.close()

            if touchedKeys.contains(keyNumber) {
                selectedWhiteColor.set()
            } else {
                whiteKeyColor.set()
            }

            path.fill()
        }

    }

}

