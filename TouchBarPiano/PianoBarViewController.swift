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

        pianoControl?.onKeyPress = {
            print("key \($0) press")
        }

        pianoControl?.onKeyRelease = {
            print("key \($0) release")
        }
    }

    func setupPolyphonicKeys() {

    }

    func setupMonophonicKeys() {
        pianoControl = MonophonicPianoControl(frame: view.bounds)
    }
    
}
