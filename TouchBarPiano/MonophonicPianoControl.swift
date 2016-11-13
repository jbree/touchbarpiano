//
//  MonophonicPianoControl.swift
//  TouchBarPiano
//
//  Created by Joshua Breeden on 11/12/16.
//  Copyright © 2016 Joshua Breeden. All rights reserved.
//

import Cocoa

@available(OSX 10.12.1, *)
class MonophonicPianoControl: PianoControl {

    var currentTouch:NSTouch?

    var dragMode = DragMode.slide

    @available(OSX 10.12.1, *)
    func key(forTouch touch:NSTouch) -> Int {
        let keyWidth = bounds.width / CGFloat(numberOfKeys)
        let position = touch.location(in: self).x
        
        return Int(position / keyWidth)
    }

    override func touch(key: Int) {
        touchedKeys.removeAll()
        super.touch(key: key)
    }
    
    override func touchesBegan(with event: NSEvent) {
        currentTouch = event.touches(matching: .began, in: self).first
        if currentTouch != nil {
            touch(key: key(forTouch: currentTouch!))
        }
    }

    override func touchesMoved(with event: NSEvent) {
        if let newTouch = event.touches(matching: .moved, in: self).first {
            if currentTouch != nil, newTouch.identity.isEqual(currentTouch!.identity) {
                switch dragMode {
                case .bend:
                    let offset = currentTouch!.location(in: self).x - newTouch.location(in: self).x
                    onKeySlide?(Double(offset))
                case .release:
                    if key(forTouch: newTouch) != key(forTouch: currentTouch!) {
                        release(key: key(forTouch: currentTouch!))
                    }
                case .slide:
                    if key(forTouch: newTouch) != key(forTouch: currentTouch!) {
                        onKeyRelease?(key(forTouch: currentTouch!))
                        currentTouch = newTouch
                        touch(key: key(forTouch: currentTouch!))
                    }
                case .ignore:
                    break
                }
            }
        }

    }

    override func touchesEnded(with event: NSEvent) {
        if currentTouch != nil {
            release(key: key(forTouch: currentTouch!))
                // Fallback on earlier versions
        }
        currentTouch = nil
    }

    override func touchesCancelled(with event: NSEvent) {
        if currentTouch != nil {
            release(key: key(forTouch: currentTouch!))
        }
        currentTouch = nil
    }



}
