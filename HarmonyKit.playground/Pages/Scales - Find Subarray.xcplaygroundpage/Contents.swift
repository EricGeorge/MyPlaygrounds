//: Scales - Find Subarray

import Foundation

enum Note {
    case bFlatFlat
    case fFlat
    case cFlat
    case gFlat
    case dFlat
    case aFlat
    case eFlat
    case bFlat
    case f
    case c
    case g
    case d
    case a
    case e
    case b
    case fSharp
    case cSharp
    case gSharp
    case dSharp
    case aSharp
    case eSharp
    case bSharp
    case fSharpSharp
    
    public static var notes: [Note] {
        return [
        .bFlatFlat,
        .fFlat,
        .cFlat,
        .gFlat,
        .dFlat,
        .aFlat,
        .eFlat,
        .bFlat,
        .f,
        .c,
        .g,
        .d,
        .a,
        .e,
        .b,
        .fSharp,
        .cSharp,
        .gSharp,
        .dSharp,
        .aSharp,
        .eSharp,
        .bSharp,
        .fSharpSharp]
    }
}

extension Note : CustomStringConvertible {
    public var description: String {
        switch self {
        case.bFlatFlat: return "B𝄫"
        case .fFlat: return "F♭"
        case .cFlat: return "C♭"
        case .gFlat: return "G♭"
        case .dFlat: return "D♭"
        case .aFlat: return "A♭"
        case .eFlat: return "E♭"
        case .bFlat: return "B♭"
        case .f: return "F"
        case .c: return "C"
        case .g: return "G"
        case .d: return "D"
        case .a: return "A"
        case .e: return "E"
        case .b: return "B"
        case .fSharp: return "F♯"
        case .cSharp: return "C♯"
        case .gSharp: return "G♯"
        case .dSharp: return "D♯"
        case .aSharp: return "A♯"
        case .eSharp: return "E♯"
        case .bSharp: return "B♯"
        case .fSharpSharp: return "F𝄪"
        }
    }
}

let root = Note.e
let i = Note.notes.index(where: { $0 == root })
let unorderedScale = Array(Note.notes[i!-1...i!+5])
//print(unorderedScale)

let scale = [unorderedScale[1],
             unorderedScale[3],
             unorderedScale[5],
             unorderedScale[0],
             unorderedScale[2],
             unorderedScale[4],
             unorderedScale[6]]

print(scale)



