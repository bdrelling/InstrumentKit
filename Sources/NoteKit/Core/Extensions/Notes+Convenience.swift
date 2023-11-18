// Copyright © 2023 Brian Drelling. All rights reserved.

extension Array where Element == Note {
    static let standard: Self = .octave(4)

    static func octave(_ octave: Int) -> Self {
        PitchClass.allCases.map { Note($0, octave: octave) }
    }

    static func octaves(_ octaves: ClosedRange<Int>) -> Self {
        octaves.flatMap { octave in
            PitchClass.allCases.map { Note($0, octave: octave) }
        }
    }
}
