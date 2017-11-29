//: Diatonic triads

typealias NoteNameTuple = (LetterName, Accidental)

enum LetterName: UInt, CustomStringConvertible {
    case c = 0
    case d = 1
    case e = 2
    case f = 3
    case g = 4
    case a = 5
    case b = 6
    
    static let names: [String] = ["C", "D", "E", "F", "G", "A", "B"]
    public var description: String {
        return LetterName.names[Int(rawValue)]
    }
}

enum Accidental: Float, CustomStringConvertible {
    case doubleFlat = -2
    case flat = -1
    case natural = 0
    case sharp = 1
    case doubleSharp = 2
    
    public func description(_ stripNatural: Bool) -> String {
        switch self {
        case .natural:
            return stripNatural ? "" : description
        default:
            return description
        }
    }
    
    public var description: String {
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

enum NoteType: Int, CustomStringConvertible {
    case C = 0, Cs, D, Ds, E, F, Fs, G, Gs, A, As, B
    
    var names: [NoteNameTuple] {
        switch self.rawValue {
        case 0:
            return [(.c, .natural), (.b, .sharp)]
        case 1:
            return [(.c, .sharp), (.d, .flat)]
        case 2:
            return [(.d, .natural)]
        case 3:
            return [(.d, .sharp), (.e, .flat)]
        case 4:
            return [(.e, .natural), (.f, .flat)]
        case 5:
            return [(.f, .natural), (.e, .sharp)]
        case 6:
            return [(.f, .sharp), (.g, .flat)]
        case 7:
            return [(.g, .natural)]
        case 8:
            return [(.g, .sharp), (.a, .flat)]
        case 9:
            return [(.a, .natural)]
        case 10:
            return [(.a, .sharp), (.b, .flat)]
        case 11:
            return [(.b, .natural), (.c, .flat)]
        default:
            return []
        }
    }
    
    // this is always returning the first enharmonic variation.  I need logic to fix this.
    public var description: String {
        let (letterName, accidental) = self.names.first!
        return "\(letterName.description)\(accidental.description(true))"
     }
}

// MIDI ranges from 0 to 127
// Octaves range -2 to 8 which gives a total Note range of C-2 to G8

struct Note: CustomStringConvertible {
    let midi: Int
    
    init(midi: Int) {
        self.midi = midi
    }
    
    init(type: NoteType, octave: Int) {
        self.midi = (octave + 2) * 12 + type.rawValue
    }
    
    var type: NoteType {
        return NoteType(rawValue: self.midi % 12)!
    }
    
    var octave: Int {
        return midi/12 - 2
    }
    
    static func +(lhs: Note, rhs: Int) -> Note {
        return Note(midi: lhs.midi + rhs)
    }
    
    var description: String {
        return type.description
    }
}

enum Steps: Int {
    case H = 1, W, WH
}

enum ScaleType {
    case major
    case minor
    case harmonicMinor
    case melodicMinor
    
    var steps: [Steps] {
        switch self {
        case .major: return [.W, .W, .H, .W, .W, .W]
        case .minor: return [.W, .H, .W, .W, .H, .W]
        case .harmonicMinor: return [.W, .H, .W, .W, .H, .WH]
        case .melodicMinor: return [.W, .H, .W, .W, .W, .W]
        }
    }
}

struct Scale {
    let key: Note
    let type: ScaleType
    
    init(_ key: Note, _ type: ScaleType) {
        self.key = key
        self.type = type
    }
    
    var notes: [Note] {
        return type.steps.reduce([key]) {
            (notes, steps) -> [Note] in
            return notes + [notes.last! + steps.rawValue]
        }
    }
}



let scale = Scale(Note(type: .F, octave: 4), ScaleType.major)
print(scale.notes)

