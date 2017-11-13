//: MIDISampler

import MyPlaygrounds
import AudioKit

var sampler = AKMIDISampler()
let sequencer = AKSequencer(filename: "one-octave")

do {
    try sampler.loadEXS24("PianoEXSTest")
} catch {
    print("A file was not found.")
}

//let preset = Bundle.main.url(forResource: "Piano1Sample", withExtension: "aupreset")
//try sampler.samplerUnit.loadInstrument(at: preset!)

AudioKit.output = sampler

//: Do some basic setup to make the sequence loop correctly
sequencer.setTempo(80)
sequencer.setLength(AKDuration(beats: 8))
sequencer.enableLooping()
sequencer.setGlobalMIDIOutput(sampler.midiIn)

AudioKit.start()
sequencer.play()


import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
