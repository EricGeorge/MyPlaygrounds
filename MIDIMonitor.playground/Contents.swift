//: MIDIMonitor


import MyPlaygrounds
import AudioKit

let midi = AKMIDI()

midi.inputNames
midi.openInput()

class PlaygroundMIDIReceiver: AKMIDIListener {
}

let receiver = PlaygroundMIDIReceiver()

midi.addListener(receiver)

import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

