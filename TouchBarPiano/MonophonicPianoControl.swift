//
//  MonophonicPianoControl.swift
//  TouchBarPiano
//
//  Created by Joshua Breeden on 11/12/16.
//  Copyright © 2016 Joshua Breeden. All rights reserved.
//

import Cocoa

class MonophonicPianoControl: PianoControl {

    var currentTouch:NSTouch?

    var dragMode = DragMode.slide

    @available(OSX 10.12.1, *)
    func key(forTouch touch:NSTouch) -> Int {
        let keyWidth = bounds.width / CGFloat(numberOfKeys)
        let position = touch.location(in: self).x
        
        return Int(position / keyWidth)
    }

    override func touchesBegan(with event: NSEvent) {
        currentTouch = event.touches(matching: .began, in: self).first
        if currentTouch != nil {
            if #available(OSX 10.12.1, *) {
                onKeyPress?(key(forTouch: currentTouch!))
            } else {
                // Fallback on earlier versions
            }
        }

    }

    override func touchesMoved(with event: NSEvent) {
        if #available(OSX 10.12.1, *) {
            if let touch = event.touches(matching: .moved, in: self).first {
                if currentTouch != nil, touch.identity.isEqual(currentTouch!.identity) {
                    switch dragMode {
                    case .bend:
                        let offset = currentTouch!.location(in: self).x - touch.location(in: self).x
                        onKeySlide?(Double(offset))
                    case .release:
                        if key(forTouch: touch) != key(forTouch: currentTouch!) {
                            onKeyRelease?(key(forTouch: currentTouch!))
                        }
                    case .slide:
                        if key(forTouch: touch) != key(forTouch: currentTouch!) {
                            onKeyRelease?(key(forTouch: currentTouch!))
                            currentTouch = touch
                            onKeyPress?(key(forTouch: currentTouch!))
                        }
                    case .ignore:
                        break
                    }
                }
            }
        } else {
            self.print("need 10.12.1")
        }

    }

    override func touchesEnded(with event: NSEvent) {
        if #available(OSX 10.12.1, *) {
            if currentTouch != nil {
                onKeyRelease?(key(forTouch: currentTouch!))
                    // Fallback on earlier versions
            } else {
                // handle it
            }
        }
        currentTouch = nil
    }

    override func touchesCancelled(with event: NSEvent) {
        if #available(OSX 10.12.1, *) {
            if currentTouch != nil {
                onKeyRelease?(key(forTouch: currentTouch!))
            }
        }
        currentTouch = nil
    }



}
