//
//  PianoBarViewController.swift
//  TouchBarPiano
//
//  Created by Joshua Breeden on 11/12/16.
//  Copyright © 2016 Joshua Breeden. All rights reserved.
//

import Cocoa

@available(OSX 10.12.1, *)
class PianoBarViewController: NSViewController {

    @IBOutlet weak var pianoView: PianoView!

    var octave: Int = 4 {
        didSet {
            octave = octave > 0 ? (octave < 8 ? octave : 8) : 0
        }
    }

    let midiDevice = VirtualMidiDevice()

    var currentNotes = [Int:Note]()

    var pianoControl: PianoControl? {
        willSet {
            if newValue != pianoControl {
                pianoControl?.removeFromSuperview()
            }
        }
        didSet {
            if pianoControl != nil {
                pianoControl!.frame = view.bounds
                view.addSubview(pianoControl!, positioned: .above, relativeTo: pianoView)
            }
        }
    }

    override func viewDidLayout() {
        pianoControl?.frame = view.bounds
    }

    // defines how multiple touches are handled
    var touchMode = TouchMode.monophonic

    // defines how the keys respond when dragged left to right
    var dragMode = DragMode.bend

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.

        setupMonophonicKeys()
        midiDevice.enabled = true

        pianoControl?.onKeyPress = {
            print ("key \($0) down")
            let midi = $0 + 12 * self.octave
            let note = Note(withMidiNumber: UInt8(midi))
            self.currentNotes[$0] = note
            self.midiDevice.send(note: note, command: .on)
        }

        pianoControl?.onKeyRelease = {
            print("key \($0) release")
            if let note = self.currentNotes[$0] {
                self.midiDevice.send(note:note, command: .off)
                self.currentNotes[$0] = nil
            }
        }
    }

    func setupPolyphonicKeys() {

    }

    func setupMonophonicKeys() {
        pianoControl = MonophonicPianoControl(frame: view.bounds)
    }
    
}
