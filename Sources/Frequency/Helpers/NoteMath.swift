// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation
import NoteKit

public final class NoteMath {}

// MARK: - Supporting Types

public typealias SimpleNote = (noteClass: NoteClass, octave: Int)

// MARK: - Constants

public extension NoteMath {
    static let semitonesPerOctave = 12
    static let centsPerOctave = 1200
    static let standardNoteFrequency: Float = 440
    static let precision: Float = 100.0
}

// MARK: - Extensions

public extension NoteMath {
    // MARK: Half Step Interval

    private static func intervalForFrequency(_ frequency: Float) -> Int {
        guard frequency > 0 else {
            return 0
        }

        let numberOfNoteClasss = Float(Self.semitonesPerOctave)
        return Int(round(numberOfNoteClasss * log2f(frequency / Self.standardNoteFrequency)))
    }

    private static func interval(
        from fromNote: SimpleNote,
        to toNote: SimpleNote
    ) -> Int {
        var halfSteps: Int = fromNote.noteClass.index - toNote.noteClass.index
        halfSteps += NoteClass.allCases.count * (fromNote.octave - toNote.octave)

        return halfSteps
    }

    static func interval(from fromNote: Note, to toNote: Note) -> Int {
        self.interval(from: (fromNote.noteClass, fromNote.octave), to: (toNote.noteClass, toNote.octave))
    }

    private static func standardInterval(for note: Note) -> Int {
        self.interval(from: note, to: .standard)
    }

    private static func standardInterval(for note: SimpleNote) -> Int {
        self.interval(from: note, to: (Note.standard.noteClass, Note.standard.octave))
    }

    private static func baseInterval(for note: Note) -> Int {
        self.interval(from: note, to: .lowest)
    }

    private static func baseInterval(for note: SimpleNote) -> Int {
        self.interval(from: note, to: (Note.lowest.noteClass, Note.lowest.octave))
    }

    // MARK: Frequency

    static func frequencyForInterval(_ interval: Int) -> Float {
        // Multiply the frequency by 2^(n/12), where n is the number of half-steps away from the reference note.
        let power = Float(interval) / Float(Self.semitonesPerOctave)
        let frequency = Self.standardNoteFrequency * powf(2, power)

        return round(frequency * NoteMath.precision) / NoteMath.precision
    }

    static func frequencyForNote(_ noteClass: NoteClass, octave: Int) -> Float {
        let interval = Self.standardInterval(for: (noteClass, octave))
        return self.frequencyForInterval(interval)
    }

    static func frequencyForNote(_ note: Note) -> Float {
        self.frequencyForNote(note.noteClass, octave: note.octave)
    }

    // MARK: Cents

    static func cents(from fromFrequency: Float, to toFrequency: Float) -> Float {
        let centsPerOctave = Float(Self.semitonesPerOctave * 100)
        return centsPerOctave * log2f(fromFrequency / toFrequency)
    }

    static func cents(from note: Note, to frequency: Float) -> Float {
        self.cents(from: note.frequency, to: frequency)
    }

    static func cents(from fromNote: Note, to toNote: Note) -> Float {
        self.cents(from: fromNote.frequency, to: toNote.frequency)
    }

    // MARK: Note Class

    static func noteClassForInterval(_ interval: Int) -> NoteClass {
        // First, get the interval of the standard note from the lowest note, C0.
        let baseInterval = self.baseInterval(for: Note.standard)

        // Next, add the relative interval we're calculating to the standard note's inteval.
        // This will give us the resultant NoteClass's interval from the lowest note, C0.
        let resultInterval = baseInterval + interval

        // Finally, determine the index of the NoteClass in its array using the remainder operation.
        let noteClassIndex = resultInterval % Self.semitonesPerOctave

        guard noteClassIndex >= 0 else {
            let reversedIndex = abs(noteClassIndex)
            return NoteClass.allCases.reversed()[reversedIndex]
        }

        return NoteClass.allCases[noteClassIndex]
    }

    static func semitoneForFrequency(_ frequency: Float) -> NoteClass {
        let interval = self.intervalForFrequency(frequency)
        return self.noteClassForInterval(interval)
    }

    // MARK: Octave

    static func octaveForInterval(_ interval: Int) -> Int {
        let count = Self.semitonesPerOctave
        let resNegativeIndex = Note.standard.octave - (abs(interval) + 2) / count
        let resPositiveIndex = Note.standard.octave + (interval + 9) / count

        return interval < 0
            ? resNegativeIndex
            : resPositiveIndex
    }

    static func octaveForFrequency(_ frequency: Float) -> Int {
        let interval = self.intervalForFrequency(frequency)
        return self.octaveForInterval(interval)
    }

    // MARK: Note

    static func noteForInterval(_ interval: Int) -> Note {
        let noteClass = self.noteClassForInterval(interval)
        let octave = self.octaveForInterval(interval)

        return .init(noteClass, octave: octave)
    }

    static func noteForFrequency(_ frequency: Float) -> Note {
        let interval = self.intervalForFrequency(frequency)
        return self.noteForInterval(interval)
    }
}
