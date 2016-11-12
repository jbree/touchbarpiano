//
//  ControlViewController.swift
//  TouchBarPiano
//
//  Created by Joshua Breeden on 11/11/16.
//  Copyright © 2016 Joshua Breeden. All rights reserved.
//

import Cocoa

@available(OSX 10.12.1, *)
class ControlViewController: NSViewController {

    @IBOutlet weak var pianoView: PianoView!

    override func viewDidLoad() {
        super.viewDidLoad()

        pianoView.touchedKeys = [0, 3, 7]
        pianoView.setNeedsDisplay(pianoView.bounds)


        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

