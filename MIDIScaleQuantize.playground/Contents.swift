//: MIDIScaleQuantize


import MyPlaygrounds
import AudioKit

let majorScale = [0, 2, 4, 5, 7, 9, 11]
let key = 7 // G Major for testing

let midi = AKMIDI()

midi.inputNames
midi.openInput()

class PlaygroundMIDIReceiver: AKMIDIListener {
    func receivedMIDINoteOn(noteNumber: MIDINoteNumber,
                            velocity: MIDIVelocity,
                            channel: MIDIChannel){
      
        let normalizedNote = (Int(noteNumber) - key) % 12
        let octave = (Int(noteNumber) - key) / 12
        var inScaleNote:Int?

        for number in majorScale {
            if number <= normalizedNote {
                inScaleNote = number
            }
        }

        let newNote = octave * 12 + inScaleNote! + key
        
        AKLog("noteOn: \(noteNumber) newNote: \(newNote)")
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

