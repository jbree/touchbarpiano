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

    override init?(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }

    enum TouchMode {
        case monophonicFirstTouch
        case monophonicLastTouch
        case polyphonic
    }

    enum DragMode {
        case ignore
        case release
        case bend
        case slide
    }

    // defines how multiple touches are handled
    var touchMode = TouchMode.monophonicFirstTouch

    // defines how the keys respond when dragged left to right
    var dragMode = DragMode.bend
    
}
