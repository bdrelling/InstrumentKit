// Copyright © 2022 Brian Drelling. All rights reserved.

import NoteKit
import XCTest

final class NoteMathTests: XCTestCase {
    // MARK: Frequency

    func testCalculatingFrequencyForNoteAndOctave() {
        XCTAssertEqual(NoteMath.frequencyForNote(.a, octave: 4), 440.0)
        XCTAssertEqual(NoteMath.frequencyForNote(.c, octave: 4), 261.63)

        XCTAssertEqual(NoteMath.frequencyForNote(.e, octave: 2), 82.41)
        XCTAssertEqual(NoteMath.frequencyForNote(.a, octave: 2), 110.0)
        XCTAssertEqual(NoteMath.frequencyForNote(.d, octave: 3), 146.83)
        XCTAssertEqual(NoteMath.frequencyForNote(.g, octave: 3), 196.0)
        XCTAssertEqual(NoteMath.frequencyForNote(.b, octave: 3), 246.94)
        XCTAssertEqual(NoteMath.frequencyForNote(.e, octave: 4), 329.63)
    }

    // MARK: Note Class

    func testCalculatingNoteClassForFrequency() {
        XCTAssertEqual(NoteMath.semitoneForFrequency(440.0), .a)
        XCTAssertEqual(NoteMath.semitoneForFrequency(261.6), .c)

        XCTAssertEqual(NoteMath.semitoneForFrequency(82.4), .e)
        XCTAssertEqual(NoteMath.semitoneForFrequency(110.0), .a)
        XCTAssertEqual(NoteMath.semitoneForFrequency(146.8), .d)
        XCTAssertEqual(NoteMath.semitoneForFrequency(196.0), .g)
        XCTAssertEqual(NoteMath.semitoneForFrequency(246.9), .b)
        XCTAssertEqual(NoteMath.semitoneForFrequency(329.6), .e)
    }

    // MARK: Octave

    func testCalculatingOctaveForFrequency() {
        XCTAssertEqual(NoteMath.octaveForFrequency(440.0), 4)
        XCTAssertEqual(NoteMath.octaveForFrequency(261.6), 4)

        XCTAssertEqual(NoteMath.octaveForFrequency(82.4), 2)
        XCTAssertEqual(NoteMath.octaveForFrequency(110.0), 2)
        XCTAssertEqual(NoteMath.octaveForFrequency(146.8), 3)
        XCTAssertEqual(NoteMath.octaveForFrequency(196.0), 3)
        XCTAssertEqual(NoteMath.octaveForFrequency(246.9), 3)
        XCTAssertEqual(NoteMath.octaveForFrequency(329.6), 4)
    }

    // MARK: Note

    func testCalculatingNoteForFrequency() {
        XCTAssertEqual(NoteMath.noteForFrequency(440.0), .middleA)
        XCTAssertEqual(NoteMath.noteForFrequency(261.6), .middleC)

        XCTAssertEqual(NoteMath.noteForFrequency(82.4), .e(2))
        XCTAssertEqual(NoteMath.noteForFrequency(110.0), .a(2))
        XCTAssertEqual(NoteMath.noteForFrequency(146.8), .d(3))
        XCTAssertEqual(NoteMath.noteForFrequency(196.0), .g(3))
        XCTAssertEqual(NoteMath.noteForFrequency(246.9), .b(3))
        XCTAssertEqual(NoteMath.noteForFrequency(329.6), .e(4))
    }

    func testCalculatingClosestNote() {
        // Notes for Guitar standard tuning.
        // E2 = 82.41
        // A2 = 110.00
        // D3 = 146.83
        // G3 = 196.00
        // B3 = 246.94
        // E4 = 329.63
        let notes: [Note] = [.e(2), .a(2), .d(3), .g(3), .b(3), .e(4)]

        // Exact middle between A2 and D3 is approximately 128.415.
        XCTAssertEqual(notes.closest(to: 120), .a(2))
        XCTAssertEqual(notes.closest(to: 130), .d(3))

        // Any frequency below the lowest note should return the lowest note.
        XCTAssertEqual(notes.closest(to: 82), .e(2))
        XCTAssertEqual(notes.closest(to: 10), .e(2))

        // Any frequency above the highest note should return the highest note.
        XCTAssertEqual(notes.closest(to: 330), .e(4))
        XCTAssertEqual(notes.closest(to: 1000), .e(4))
        XCTAssertEqual(notes.closest(to: 10000), .e(4))
        XCTAssertEqual(notes.closest(to: 100000), .e(4))

        // Any zero or negative frequencies should be treated as invalid frequencies and therefore return nil.
        XCTAssertEqual(notes.closest(to: 0), nil)
        XCTAssertEqual(notes.closest(to: -100), nil)
    }

    // MARK: Outliers

    func testFirstNegativeOctave() {
        let frequencies = NoteClass.allCases.map { Note($0, octave: -1) }.map(\.frequency)

        XCTAssertEqual(frequencies, [
            8.18,
            8.66,
            9.18,
            9.72,
            10.30,
            10.91,
            11.56,
            12.25,
            12.98,
            13.75,
            14.57,
            15.43,
        ])
    }

    func testNinthOctave() {
        let frequencies = NoteClass.allCases.map { Note($0, octave: 9) }.map(\.frequency)

        XCTAssertEqual(frequencies, [
            8372.02,
            8869.85,
            9397.27,
            9956.06,
            10548.08,
            11175.30,
            11839.82,
            12543.86,
            13289.75,
            14080.00,
            14917.24,
            15804.26,
        ])
    }

    // This test ensures that bounded index checks are respected and that outrageously high or low octaves
    // don't throw any errors. These sorts of octaves are usually picked up from microphone interference
    // or other inaudible noises.
    func testTheoreticalOctaves() {
        let lowNotes = NoteClass.allCases.map { Note($0, octave: -100) }
        let highNotes = NoteClass.allCases.map { Note($0, octave: 100) }

        XCTAssertEqual(lowNotes.count, NoteClass.count)
        XCTAssertEqual(lowNotes.map(\.noteClass), NoteClass.allCases)

        XCTAssertEqual(highNotes.count, NoteClass.count)
        XCTAssertEqual(highNotes.map(\.noteClass), NoteClass.allCases)
    }
}
