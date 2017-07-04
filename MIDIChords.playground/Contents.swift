//: MIDIChords


import MyPlaygrounds
import AudioKit

let keys = ["C" : 0,
            "Db": 1,
            "D" : 2,
            "Eb": 3,
            "E" : 4,
            "F" : 5,
            "Gb": 6,
            "G" : 7,
            "Ab": 8,
            "A" : 9,
            "Bb": 10,
            "B" : 11]

let modes = ["major": [0, 2, 4, 5, 7, 9, 11],
             "minor": [0, 2, 3, 5, 7, 8, 10]]

let majorTriad      = [0, 4, 7]
let minorTriad      = [0, 3, 7]
let diminishedTriad = [0, 3, 6]

let chords = ["major":[majorTriad, minorTriad, minorTriad, majorTriad, majorTriad, minorTriad, diminishedTriad],
              "minor":[minorTriad, diminishedTriad, majorTriad, minorTriad, minorTriad, majorTriad, majorTriad]]

// TODO:  Add UI to change key and mode
let key = keys["C"]             // C Major for testing
let mode = modes["major"]       // C Major for testing
let chordSet = chords["major"]  // C Major for testing

let midi = AKMIDI()

midi.inputNames
midi.openInput()

class PlaygroundMIDIReceiver: AKMIDIListener {
    func receivedMIDINoteOn(noteNumber: MIDINoteNumber,
                            velocity: MIDIVelocity,
                            channel: MIDIChannel){
        
        // first quantize the note to the key
        let normalizedNote = (Int(noteNumber) - key!) % 12
        let octave = (Int(noteNumber) - key!) / 12
        var inScaleNote:Int?
        
        for number in mode! {
            if number <= normalizedNote {
                inScaleNote = number
            }
        }
        
        let newNote = octave * 12 + inScaleNote! + key!
        
        // then build the appropriate chord
        let scaleDegree = mode!.index(of: inScaleNote!)!
        let chordTemplate = chordSet![scaleDegree]
 
        AKLog("ScaleDegree: \(scaleDegree + 1)")

        for note in chordTemplate {
            AKLog("chord note is: \(note + newNote)")
        }
    }
    
    // override to suppress the default logging
    func receivedMIDINoteOff(noteNumber: MIDINoteNumber,
                             velocity: MIDIVelocity,
                             channel: MIDIChannel) {
        //        AKLog("channel: \(channel) noteOff: \(noteNumber) velocity: \(velocity)")
    }
    
    func receivedMIDIAftertouch(noteNumber: MIDINoteNumber,
                                pressure: MIDIByte,
                                channel: MIDIChannel) {
        //        AKLog("channel: \(channel) MIDI Aftertouch Note: \(noteNumber) pressure: \(pressure)")
    }
    
    func receivedMIDIAfterTouch(_ pressure: MIDIByte,
                                channel: MIDIChannel) {
        //        AKLog("channel: \(channel) MIDI AfterTouch pressure: \(pressure)")
    }
    
}

let receiver = PlaygroundMIDIReceiver()

midi.addListener(receiver)

import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

