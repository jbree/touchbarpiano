//
//  PianoModes.swift
//  TouchBarPiano
//
//  Created by Joshua Breeden on 11/12/16.
//  Copyright © 2016 Joshua Breeden. All rights reserved.
//

import Cocoa

enum TouchMode {
    case monophonic
    case polyphonic
}

enum DragMode {
    case ignore
    case release
    case bend
    case slide
}
