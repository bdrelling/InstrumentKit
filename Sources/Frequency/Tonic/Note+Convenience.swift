// Copyright © 2022 Brian Drelling. All rights reserved.

import Tonic

public extension Note {
    static let standard: Self = .A
    static let lowest: Self = .init(.C, octave: 0)
}

public extension Note {
    init(_ noteClass: NoteClass, octave: Int) {
        self.init(noteClass.letter, accidental: noteClass.accidental, octave: octave)
    }
}

// MARK: - Convenience

// TODO: Optimize by making these values static so the math never takes too long. Realistically, though, how often are these used and how long does it take?
public extension Note {
    static func C(_ octave: Int) -> Self {
        .init(.C, octave: octave)
    }

    static func CSharp(_ octave: Int) -> Self {
        .init(.C, accidental: .sharp, octave: octave)
    }

    static func D(_ octave: Int) -> Self {
        .init(.D, octave: octave)
    }

    static func DSharp(_ octave: Int) -> Self {
        .init(.D, accidental: .sharp, octave: octave)
    }

    static func E(_ octave: Int) -> Self {
        .init(.E, octave: octave)
    }

    static func F(_ octave: Int) -> Self {
        .init(.F, octave: octave)
    }

    static func FSharp(_ octave: Int) -> Self {
        .init(.F, accidental: .sharp, octave: octave)
    }

    static func G(_ octave: Int) -> Self {
        .init(.G, octave: octave)
    }

    static func GSharp(_ octave: Int) -> Self {
        .init(.G, accidental: .sharp, octave: octave)
    }

    static func A(_ octave: Int) -> Self {
        .init(.A, octave: octave)
    }

    static func ASharp(_ octave: Int) -> Self {
        .init(.A, accidental: .sharp, octave: octave)
    }

    static func B(_ octave: Int) -> Self {
        .init(.B, octave: octave)
    }
}
