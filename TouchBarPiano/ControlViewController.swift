//
//  ControlViewController.swift
//  TouchBarPiano
//
//  Created by Joshua Breeden on 11/11/16.
//  Copyright © 2016 Joshua Breeden. All rights reserved.
//

import Cocoa

@available(OSX 10.12.2, *)
class ControlViewController: NSViewController, NSTouchBarDelegate {

    let piano:PianoControl = MonophonicPianoControl()
    let midiDevice = VirtualMidiDevice()
    var currentNotes = [Int:Note]()

    var octave = 0 {
        didSet {
            if octave < 2 {
                octave = 1
                decreaseOctaveButton.isEnabled = false
            } else {
                decreaseOctaveButton.isEnabled = true

                if octave > 8 {
                    octave = 9
                    increaseOctaveButton.isEnabled = false
                } else {
                    increaseOctaveButton.isEnabled = true
                }
            }

            octaveLabel.stringValue = "\(octave)"
        }
    }

    // defines how multiple touches are handled
    var touchMode = TouchMode.monophonic

    // defines how the keys respond when dragged left to right
    var dragMode = DragMode.slide

    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO: load and store in defaults
        octave = 4

        // Do any additional setup after loading the view.
        midiDevice.enabled = true

        piano.onKeyPress = {
//            print ("key \($0) down")
            let midi = $0 + 12 * self.octave
            let note = Note(withMidiNumber: UInt8(midi))
            self.currentNotes[$0] = note
            self.midiDevice.send(note: note, command: .on)
        }

        piano.onKeyRelease = {
//            print("key \($0) release")
            if let note = self.currentNotes[$0] {
                self.midiDevice.send(note:note, command: .off)
                self.currentNotes[$0] = nil
            }
        }
    }

    // MARK: - Musical Control & Status

    @IBOutlet weak var decreaseOctaveButton: NSButton!
    @IBOutlet weak var increaseOctaveButton: NSButton!
    @IBOutlet weak var octaveLabel: NSTextField!

    @IBAction func decreaseOctave(_ sender: Any) {
        octave -= 1
    }

    @IBAction func increaseOctave(_ sender: Any) {
        octave += 1
    }


    // MARK: - TouchBar methods

    private let touchBarPianoItem = NSTouchBarItemIdentifier("com.MIDIBar.pianoBar")

    @available(OSX 10.12.2, *)
    override func makeTouchBar() -> NSTouchBar? {
        let pianoBar = NSTouchBar()
        pianoBar.delegate = self
        pianoBar.defaultItemIdentifiers = [touchBarPianoItem, .otherItemsProxy]

        return pianoBar
    }

    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItemIdentifier) -> NSTouchBarItem? {
        if identifier == touchBarPianoItem {
            let pianoViewBarItem = NSCustomTouchBarItem(identifier: touchBarPianoItem)

            pianoViewBarItem.view = piano

            return pianoViewBarItem
        }
        
        return nil
    }


}

