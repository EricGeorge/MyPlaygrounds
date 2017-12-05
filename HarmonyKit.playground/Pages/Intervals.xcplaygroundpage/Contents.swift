//: Intervals

import Foundation

enum NoteType: UInt, CustomStringConvertible {
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
    
    static func +(lhs: NoteType, rhs: UInt) -> NoteType {
        var rhs = rhs
        while rhs < 0 {
            rhs = rhs + 7
        }
        let newRawValue = (lhs.rawValue + UInt(rhs))%7
        return NoteType(rawValue: newRawValue)!
    }
    
    static postfix func ++(noteType: inout NoteType) -> NoteType {
        noteType = noteType + 1
        return noteType
    }
}

enum Accidental: Int, CustomStringConvertible {
//    case doubleFlat = -2
    case flat = -1
    case natural = 0
    case sharp = 1
//    case doubleSharp = 2
    
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
//        case .doubleFlat:
//            return "𝄫"
        case .flat:
            return "♭"
        case .natural:
            return "♮"
        case .sharp:
            return "♯"
//        case .doubleSharp:
//            return "𝄪"
        }
    }
}

struct Note: CustomStringConvertible {
    let noteType: NoteType
    let accidental: Accidental
    
    init(_ noteType: NoteType, _ accidental: Accidental) {
        self.noteType = noteType
        self.accidental = accidental
    }
    
    var value: Int {
        switch (noteType, accidental) {
        case (.B, .sharp): return 0
        case (.C, .natural): return 0
        case (.C, .sharp): return 1
        case (.D, .flat): return 1
        case (.D, .natural): return 2
        case (.D, .sharp): return 3
        case (.E, .flat): return 3
        case (.E, .natural): return 4
        case (.F, .flat): return 4
        case (.E, .sharp): return 5
        case (.F, .natural): return 5
        case (.F, .sharp): return 6
        case (.G, .flat): return 6
        case (.G, .natural): return 7
        case (.G, .sharp): return 8
        case (.A, .flat): return 8
        case (.A, .natural): return 9
        case (.A, .sharp): return 10
        case (.B, .flat): return 10
        case (.B, .natural): return 11
        case (.C, .flat): return 11
        }
    }
    
    static func -(lhs: Note, rhs: Note) -> Interval {
        return Interval(rawValue: abs(lhs.value - rhs.value))!
    }
    
    var description: String {
        return "\(noteType.description)\(accidental.description(true))"
    }
}

enum Interval: Int {
    case unison = 0, m2, M2, m3, M3, P4, D5, P5, m6, M6, m7, M7
    
    var halfsteps: Int {
        return self.rawValue
    }
}

enum ScaleType {
    case major
    case minor
    case harmonicMinor
    
    var intervals: [Interval] {
        switch self {
        case .major: return [.M2, .M3, .P4, .P5, .M6, .M7]
        case .minor: return [.M2, .m3, .P4, .P5, .m6, .m7]
        case .harmonicMinor: return [.M2, .m3, .P4, .P5, .m6, .M7]
        }
    }
}

struct Scale {
    let root: Note
    let type: ScaleType
    
    init(_ root: Note, _ type: ScaleType) {
        self.root = root
        self.type = type
    }
    
    var notes: [Note] {
        return type.intervals.reduce([root]) {
            (notes, interval) -> [Note] in
            return notes + [Note((notes.last?.noteType)! + 1, .natural)]
        }
    }
    
/*
     let scale = [root]
     for each interval in intervals {
        let newNote = Note(scale.last.noteType + 1, .natural
        let proposedInterval = newNote - root
        let accidental = Accidental(proposedInterval - interval)
        scale = scale + newNote
     
 */
        
}

let scale = Scale(Note(.F, .natural), ScaleType.major)
print(scale.notes)


