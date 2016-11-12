//
//  Note.swift
//  MIDIBar
//
//  Created by Joshua Breeden on 11/6/16.
//  Copyright © 2016 Joshua Breeden. All rights reserved.
//

import Foundation

enum Modifier: Int {
    case natural = 0
    case flat = -1
    case sharp = 1
}

class Note {
    let midiNumber: UInt8

    init(_ letter:String, _ modifier: Modifier, _ octave: Int) {
        var base = 0;
        switch letter {
            case "C": base = 12
            case "D": base = 14
            case "E": base = 16
            case "F": base = 17
            case "G": base = 19
            case "A": base = 21
            case "B": base = 23

        default: base = 12
        }

//        let note = base + modifier.rawValue +
        let val = base + modifier.rawValue + octave * 12 + 12

        midiNumber = UInt8(bitPattern: Int8(val))
    }

    init(withMidiNumber number: UInt8) {
        midiNumber = number
    }
}
