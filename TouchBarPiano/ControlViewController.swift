//
//  ControlViewController.swift
//  TouchBarPiano
//
//  Created by Joshua Breeden on 11/11/16.
//  Copyright © 2016 Joshua Breeden. All rights reserved.
//

import Cocoa

@available(OSX 10.12.1, *)
class ControlViewController: NSViewController, NSTouchBarDelegate {

    let pianoBarViewController = PianoBarViewController(nibName: "PianoBarViewController", bundle: nil)!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    private let touchBarPianoItem = NSTouchBarItemIdentifier("com.MIDIBar.pianoBar")

    @available(OSX 10.12.1, *)
    override func makeTouchBar() -> NSTouchBar? {
        let pianoBar = NSTouchBar()
        pianoBar.delegate = self
        pianoBar.defaultItemIdentifiers = [touchBarPianoItem, .otherItemsProxy]

        return pianoBar
    }

    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItemIdentifier) -> NSTouchBarItem? {
        if identifier == touchBarPianoItem {
            let pianoViewBarItem = NSCustomTouchBarItem(identifier: touchBarPianoItem)

            pianoViewBarItem.view = pianoBarViewController.view

            return pianoViewBarItem
        }
        
        return nil
    }


}

