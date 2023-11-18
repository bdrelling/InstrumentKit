// Copyright © 2023 Brian Drelling. All rights reserved.

public extension Note {
    var midiNote: UInt8 {
        UInt8(exactly: (self.octave * PitchClass.allCases.count) + self.pitchClass.rawValue) ?? Note.standard.midiNote
    }
}
