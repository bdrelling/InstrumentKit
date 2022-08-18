// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation
import Tonic

// MARK: - Supporting Types

extension Note {
    func interval(to otherNote: Note) -> Int {
        let semitones = Int(self.semitones(to: otherNote))

        if self.pitch < otherNote.pitch {
            return -semitones
        } else {
            return semitones
        }
    }
}

public extension NoteMath {
    // MARK: Half Step Interval

    static func interval(from fromNote: Note, to toNote: Note) -> Int {
        fromNote.interval(to: toNote)
//        var halfSteps: Int = fromNote.noteClass.intValue - toNote.noteClass.intValue
//        halfSteps += Self.semitonesPerOctave * (fromNote.octave - toNote.octave)

//        return halfSteps
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

    static func frequencyForNoteClass(_ noteClass: NoteClass, octave: Int) -> Float {
        self.frequencyForNote(.init(noteClass, octave: octave))
    }

    // MARK: Cents

    static func cents(from note: Note, to frequency: Float) -> Float {
        self.cents(from: note.frequency, to: frequency)
    }

    static func cents(from fromNote: Note, to toNote: Note) -> Float {
        self.cents(from: fromNote.frequency, to: toNote.frequency)
    }

    // MARK: Note Class

    static func noteClassForInterval(_ interval: Int) -> NoteClass {
        // First, get the interval of the standard note from the lowest note, C0.
        let baseInterval = self.baseInterval(for: .standard)

        // Next, add the relative interval we're calculating to the standard note's inteval.
        // This will give us the resultant NoteClass's interval from the lowest note, C0.
        let resultInterval = baseInterval + interval

        // Finally, determine the index of the NoteClass in its array using the remainder operation.
        let noteClassIndex = resultInterval % Self.semitonesPerOctave

        guard noteClassIndex >= 0 else {
            let reversedIndex = abs(noteClassIndex)
            return NoteClass.allCasesInStandardOctave.reversed()[reversedIndex]
        }

        return NoteClass.allCasesInStandardOctave[noteClassIndex]
    }

    static func noteClassForFrequency(_ frequency: Float) throws -> NoteClass {
        let interval = try self.standardIntervalForFrequency(frequency)
        return self.noteClassForInterval(interval)
    }

    // MARK: Note

    static func noteForInterval(_ interval: Int) -> Note {
        let noteClass = self.noteClassForInterval(interval)
        let octave = self.octaveForInterval(interval)

        return .init(noteClass, octave: octave)
    }

    static func noteForFrequency(_ frequency: Float) throws -> Note {
        let interval = try self.standardIntervalForFrequency(frequency)
        return self.noteForInterval(interval)
    }
}
