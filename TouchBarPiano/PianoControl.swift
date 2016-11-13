//
//  PianoControl.swift
//  TouchBarPiano
//
//  Created by Joshua Breeden on 11/12/16.
//  Copyright © 2016 Joshua Breeden. All rights reserved.
//

import Cocoa

@available (OSX 10.12.1, *)
class PianoControl: PianoView {

    var onKeyPress: ((Int) -> Void)?

    var onKeyRelease: ((Int) -> Void)?

    var onKeySlide: ((Double) -> Void)?

    func touch(key: Int) {
        touchedKeys.insert(key)
        onKeyPress?(key)
    }

    func release(key: Int) {
        touchedKeys.remove(key)
        onKeyRelease?(key)
    }

    
}
