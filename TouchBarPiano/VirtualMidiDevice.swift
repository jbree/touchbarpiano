//
//  VirtualMidiDevice.swift
//  MIDIBar
//
//  Created by Joshua Breeden on 11/6/16.
//  Copyright © 2016 Joshua Breeden. All rights reserved.
//

import Foundation
import CoreMIDI

enum MidiCommand : UInt8 {
    case on         = 0x90
    case off        = 0x80
    case pitchBend  = 0xe0
}

class VirtualMidiDevice {
    private var midiClient = MIDIClientRef()
    private var midiSource = MIDIEndpointRef()

    private var defaultVelocity = UInt8(96)

    var enabled: Bool = false {
        didSet {
            if enabled {
                MIDIClientCreate("MIDIBar" as CFString, nil, nil, &midiClient)
                MIDISourceCreate(midiClient, "MIDIBar" as CFString, &midiSource)
            } else {
                MIDIClientDispose(midiClient)
            }
        }
    }

    func send(note aNote: Note, command aCommand:MidiCommand) {
        let velocity:UInt8 = aCommand == .on ? defaultVelocity : 0
        send(command: aCommand, withData1: aNote.midiNumber, withData2: velocity)
    }

    func send(command aCommand: MidiCommand, withData1 data1:UInt8, withData2 data2: UInt8) {
        let data = [aCommand.rawValue, data1, data2]

        send(data: data)
    }

    func send(command aCommand: MidiCommand, with14BitNumber number:UInt16) {
        let byte1 = UInt8(truncatingBitPattern: number) & 0x7f
        let byte2 = UInt8(truncatingBitPattern:(number >> 9) & 0x7f)

        print("sending \(aCommand.rawValue): \(String(format:"%2X", byte1)), \(String(format:"%2X", byte2))")
        send(command: aCommand, withData1: byte1, withData2: byte2)
    }

    func send(data: [UInt8]) {

        var packet = MIDIPacket()
        packet.data.0 = data[0]
        packet.data.1 = data[1]
        packet.data.2 = data[2]
        packet.length = 3
        packet.timeStamp = 0

        var packets = MIDIPacketList(numPackets: 1, packet: packet)

        MIDIReceived(midiSource, &packets)
    }
}
