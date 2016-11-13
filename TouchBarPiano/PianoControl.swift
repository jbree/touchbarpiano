//
//  PianoControl.swift
//  TouchBarPiano
//
//  Created by Joshua Breeden on 11/12/16.
//  Copyright © 2016 Joshua Breeden. All rights reserved.
//

import Cocoa

class PianoControl: NSView {

    var numberOfKeys = 12

    var onKeyPress: ((Int) -> Void)?

    var onKeyRelease: ((Int) -> Void)?

    var onKeySlide: ((Double) -> Void)?
    
}
