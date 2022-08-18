// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation
import Tonic

// MARK: - Supporting Types

public extension NoteMath {
    // MARK: Half Step Interval

    static func interval(from fromNote: Note, to toNote: Note) -> Int {
        var halfSteps: Int = fromNote.pitchClass.index - toNote.pitchClass.index
        halfSteps += Self.semitonesPerOctave * (fromNote.octave - toNote.octave)

        return halfSteps
    }

    static func standardInterval(for note: Note) -> Int {
        self.interval(from: note, to: .standard)
    }

    static func baseInterval(for note: Note) -> Int {
        self.interval(from: note, to: .lowest)
    }

    // MARK: Frequency

    static func frequencyForNote(_ note: Note) -> Float {
        let interval = Self.standardInterval(for: note)
        return self.frequencyForInterval(interval)
    }

    static func frequencyForPitchClass(_ pitchClass: PitchClass, octave: Int) -> Float {
        self.frequencyForNote(.init(pitchClass, octave: octave))
    }

    // MARK: Cents

    static func cents(from note: Note, to frequency: Float) -> Float {
        self.cents(from: note.frequency, to: frequency)
    }

    static func cents(from fromNote: Note, to toNote: Note) -> Float {
        self.cents(from: fromNote.frequency, to: toNote.frequency)
    }

    // MARK: Note Class

    static func pitchClassForInterval(_ interval: Int) -> PitchClass {
        // First, get the interval of the standard note from the lowest note, C0.
        let baseInterval = self.baseInterval(for: .standard)

        // Next, add the relative interval we're calculating to the standard note's inteval.
        // This will give us the resultant PitchClass's interval from the lowest note, C0.
        let resultInterval = baseInterval + interval

        // Finally, determine the index of the PitchClass in its array using the remainder operation.
        let pitchClassIndex = resultInterval % Self.semitonesPerOctave

        guard pitchClassIndex >= 0 else {
            let reversedIndex = abs(pitchClassIndex)
            return PitchClass.allCases.reversed()[reversedIndex]
        }

        return PitchClass.allCases[pitchClassIndex]
    }

    static func pitchClassForFrequency(_ frequency: Float) throws -> PitchClass {
        let interval = try self.standardIntervalForFrequency(frequency)
        return self.pitchClassForInterval(interval)
    }

    // MARK: Note

    static func noteForInterval(_ interval: Int) -> Note {
        let pitchClass = self.pitchClassForInterval(interval)
        let octave = self.octaveForInterval(interval)

        return .init(pitchClass, octave: octave)
    }

    static func noteForFrequency(_ frequency: Float) throws -> Note {
        let interval = try self.standardIntervalForFrequency(frequency)
        return self.noteForInterval(interval)
    }
}
