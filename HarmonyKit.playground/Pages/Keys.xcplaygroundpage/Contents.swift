//: Keys

import Foundation

enum NoteType: CustomStringConvertible {
    case C
    case D
    case E
    case F
    case G
    case A
    case B

    var description: String {
        switch self {
        case .C: return "C"
        case .D: return "D"
        case .E: return "E"
        case .F: return "F"
        case .G: return "G"
        case .A: return "A"
        case .B: return "B"
        }
    }
}

enum Accidental: Float, CustomStringConvertible {
    case doubleFlat = -2
    case flat = -1
    case natural = 0
    case sharp = 1
    case doubleSharp = 2
    
    func description(_ stripNatural: Bool) -> String {
        switch self {
        case .natural:
            return stripNatural ? "" : description
        default:
            return description
        }
    }
    
    var description: String {
        switch self {
        case .doubleFlat:
            return "𝄫"
        case .flat:
            return "♭"
        case .natural:
            return "♮"
        case .sharp:
            return "♯"
        case .doubleSharp:
            return "𝄪"
        }
    }
}

struct Note: CustomStringConvertible {
    let noteType: NoteType
    let accidental: Accidental
    
    init(noteType: NoteType, accidental: Accidental) {
        self.noteType = noteType
        self.accidental = accidental
    }
    
    var description: String {
        return "\(noteType.description)\(accidental.description(true))"
    }
}

struct Pitch: CustomStringConvertible {
    let note: Note
    let octave: Int
    
    init(note: Note, octave: Int) {
        self.note = note
        self.octave = octave
    }
    
    var description: String {
        return "\(note.description)\(octave.description)"
    }
}

enum Key: CustomStringConvertible {
    case cMajor
    case bMajor
    case bFlatMajor
    
    var scale: [Note] {
        switch self {
        case .cMajor: return [Note(noteType: .C, accidental: .natural),
                              Note(noteType: .D, accidental: .natural),
                              Note(noteType: .E, accidental: .natural),
                              Note(noteType: .F, accidental: .natural),
                              Note(noteType: .G, accidental: .natural),
                              Note(noteType: .A, accidental: .natural),
                              Note(noteType: .B, accidental: .natural)]
            
        case .bMajor: return [Note(noteType: .B, accidental: .natural),
                              Note(noteType: .C, accidental: .sharp),
                              Note(noteType: .D, accidental: .sharp),
                              Note(noteType: .E, accidental: .natural),
                              Note(noteType: .F, accidental: .sharp),
                              Note(noteType: .G, accidental: .sharp),
                              Note(noteType: .A, accidental: .sharp)]
            
        case .bFlatMajor: return [Note(noteType: .B, accidental: .flat),
                              Note(noteType: .C, accidental: .natural),
                              Note(noteType: .D, accidental: .natural),
                              Note(noteType: .E, accidental: .flat),
                              Note(noteType: .F, accidental: .natural),
                              Note(noteType: .G, accidental: .natural),
                              Note(noteType: .A, accidental: .natural)]
        }
    }
    
    var description: String {
        switch self {
        case .cMajor: return "C Major"
        case .bMajor: return "B Major"
        case .bFlatMajor: return "B♭ Major"
        }
    }
    
    func triad(forDegree root: ScaleDegree)->[Note] {
        return [self.scale[root.rawValue], self.scale[root.rawValue + 2], self.scale[root.rawValue + 4]]
    }
}

enum ScaleDegree: Int, CustomStringConvertible {
    case first = 0
    case second
    case third
    case fourth
    case fifth
    case sixth
    case seventh
    
    var description: String {
        switch self {
        case .first: return "1"
        case .second: return "2"
        case .third: return "3"
        case .fourth: return "4"
        case .fifth: return "5"
        case .sixth: return "6"
        case .seventh: return "7"
        }
    }
    
    static func +(degree: ScaleDegree, offset: Int) -> ScaleDegree {
        return ScaleDegree(rawValue: (degree.rawValue + offset) % 7)!
    }
}

struct ChordTransform: CustomStringConvertible {
    let degree: ScaleDegree
    let accidental: Accidental
    
    init(degree: ScaleDegree, accidental: Accidental) {
        self.degree = degree
        self.accidental = accidental
    }
    
    var description: String {
        return "\(accidental.description(true))\(degree.description)"
    }
}

enum Chord: CustomStringConvertible {
    case major
    case minor
    case diminished
    case dominantSeventh
    
    var transforms: [ChordTransform] {
        switch self {
        case .major: return [ChordTransform(degree: .first, accidental: .natural),
                             ChordTransform(degree: .third, accidental: .natural),
                             ChordTransform(degree: .fifth, accidental: .natural)]
        case .minor: return [ChordTransform(degree: .first, accidental: .natural),
                             ChordTransform(degree: .third, accidental: .flat),
                             ChordTransform(degree: .fifth, accidental: .natural)]
        case .diminished: return [ChordTransform(degree: .first, accidental: .natural),
                                  ChordTransform(degree: .third, accidental: .flat),
                                  ChordTransform(degree: .fifth, accidental: .flat)]
        case .dominantSeventh: return [ChordTransform(degree: .first, accidental: .natural),
                                       ChordTransform(degree: .third, accidental: .natural),
                                       ChordTransform(degree: .fifth, accidental: .natural),
                                       ChordTransform(degree: .seventh, accidental: .flat)]
        }
    }
    
    var description: String {
        switch self {
        case .major: return "major: \(transforms.description)"
        case .minor: return "minor: \(transforms.description)"
        case .diminished: return "diminished: \(transforms.description)"
        case .dominantSeventh: return "dominant seventh: \(transforms.description)"
        }
    }
}

// Probably can make use of this IndexSet learned from here: https://stackoverflow.com/questions/40264624/filter-array-by-indices
//let array = ["sun", "moon", "star", "meteor"]
//let indexSet: IndexSet = [2, 3]
//
//let result = indexSet.map { array[$0] } // Magic happening here!
//print(result) // ["star", "meteor"]

let pitch = Pitch(note: Note(noteType: .G, accidental: .sharp), octave: 4)
print(pitch)

let key = Key.bMajor
print(key.scale)
print(key)

let chord = Chord.minor
print(chord)

print(key.triad(forDegree: .first))



