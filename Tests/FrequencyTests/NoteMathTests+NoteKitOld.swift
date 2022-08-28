// Copyright © 2022 Brian Drelling. All rights reserved.

//// Copyright © 2022 Brian Drelling. All rights reserved.
//
// import Frequency
// import NoteKit
// import XCTest
//
// final class NoteMathNoteKitTests: XCTestCase {
//    // MARK: Frequency
//
//    func testIntervals() {
//        XCTAssertEqual(NoteMath.baseInterval(for: .c(4)), 48)
//        XCTAssertEqual(NoteMath.baseInterval(for: .a(4)), 57)
//        XCTAssertEqual(NoteMath.baseInterval(for: .c(5)), 60)
//    }
//
//    func testCalculatingFrequencyForNoteAndOctave() {
//        XCTAssertEqual(NoteMath.frequencyForNote(.a, octave: 4), 440.0)
//        XCTAssertEqual(NoteMath.frequencyForNote(.c, octave: 4), 261.63)
//
//        XCTAssertEqual(NoteMath.frequencyForNote(.e, octave: 2), 82.41)
//        XCTAssertEqual(NoteMath.frequencyForNote(.a, octave: 2), 110.0)
//        XCTAssertEqual(NoteMath.frequencyForNote(.d, octave: 3), 146.83)
//        XCTAssertEqual(NoteMath.frequencyForNote(.g, octave: 3), 196.0)
//        XCTAssertEqual(NoteMath.frequencyForNote(.b, octave: 3), 246.94)
//        XCTAssertEqual(NoteMath.frequencyForNote(.e, octave: 4), 329.63)
//    }
//
//    // MARK: Note Class
//
//    func testCalculatingPitchClassForFrequency() {
//        XCTAssertEqual(NoteMath.semitoneForFrequency(440.0), .a)
//        XCTAssertEqual(NoteMath.semitoneForFrequency(261.6), .c)
//
//        XCTAssertEqual(NoteMath.semitoneForFrequency(82.4), .e)
//        XCTAssertEqual(NoteMath.semitoneForFrequency(110.0), .a)
//        XCTAssertEqual(NoteMath.semitoneForFrequency(146.8), .d)
//        XCTAssertEqual(NoteMath.semitoneForFrequency(196.0), .g)
//        XCTAssertEqual(NoteMath.semitoneForFrequency(246.9), .b)
//        XCTAssertEqual(NoteMath.semitoneForFrequency(329.6), .e)
//    }
//
//    // MARK: Note
//
//    func testCalculatingNoteForFrequency() {
//        XCTAssertEqual(NoteMath.noteForFrequency(440.0), .middleA)
//        XCTAssertEqual(NoteMath.noteForFrequency(261.6), .middleC)
//
//        XCTAssertEqual(NoteMath.noteForFrequency(82.4), .e(2))
//        XCTAssertEqual(NoteMath.noteForFrequency(110.0), .a(2))
//        XCTAssertEqual(NoteMath.noteForFrequency(146.8), .d(3))
//        XCTAssertEqual(NoteMath.noteForFrequency(196.0), .g(3))
//        XCTAssertEqual(NoteMath.noteForFrequency(246.9), .b(3))
//        XCTAssertEqual(NoteMath.noteForFrequency(329.6), .e(4))
//    }
//
//    func testCalculatingClosestNote() {
//        // Notes for Guitar standard tuning.
//        // E2 = 82.41
//        // A2 = 110.00
//        // D3 = 146.83
//        // G3 = 196.00
//        // B3 = 246.94
//        // E4 = 329.63
//        let notes: [Note] = [.e(2), .a(2), .d(3), .g(3), .b(3), .e(4)]
//
//        // Exact middle between A2 and D3 is approximately 128.415.
//        XCTAssertEqual(notes.closest(to: 120), .a(2))
//        XCTAssertEqual(notes.closest(to: 130), .d(3))
//
//        // Any frequency below the lowest note should return the lowest note.
//        XCTAssertEqual(notes.closest(to: 82), .e(2))
//        XCTAssertEqual(notes.closest(to: 10), .e(2))
//
//        // Any frequency above the highest note should return the highest note.
//        XCTAssertEqual(notes.closest(to: 330), .e(4))
//        XCTAssertEqual(notes.closest(to: 1000), .e(4))
//        XCTAssertEqual(notes.closest(to: 10000), .e(4))
//        XCTAssertEqual(notes.closest(to: 100000), .e(4))
//
//        // Any zero or negative frequencies should be treated as invalid frequencies and therefore return nil.
//        XCTAssertEqual(notes.closest(to: 0), nil)
//        XCTAssertEqual(notes.closest(to: -100), nil)
//    }
//
//    // MARK: Tuning
//
//    #warning("Update, but just remove the InstrumentKit dependency.")
////    func testGuitarStandardTuning() {
////        let tuning = Tuning.Guitar.standard.rawValue
////
////        let frequencies = tuning.notes.map(\.frequency)
////        XCTAssertEqual(frequencies, [
////            82.41, // E2
////            110.0, // A2
////            146.83, // D3
////            196.0, // G3
////            246.94, // B3
////            329.63, // E4
////        ])
////    }
//
//    // MARK: Outliers
//
//    // This test is primarily for the sake of ensuring precision.
//    func testFirstNegativeOctave() {
//        let frequencies = PitchClass.allCases.map { Note($0, octave: -1) }.map(\.frequency)
//
//        XCTAssertEqual(frequencies, [
//            8.18,
//            8.66,
//            9.18,
//            9.72,
//            10.30,
//            10.91,
//            11.56,
//            12.25,
//            12.98,
//            13.75,
//            14.57,
//            15.43,
//        ])
//    }
//
//    // This test is primarily for the sake of ensuring precision.
//    func testNinthOctave() {
//        let frequencies = PitchClass.allCases.map { Note($0, octave: 9) }.map(\.frequency)
//
//        XCTAssertEqual(frequencies, [
//            8372.02,
//            8869.85,
//            9397.27,
//            9956.06,
//            10548.08,
//            11175.30,
//            11839.82,
//            12543.86,
//            13289.75,
//            14080.00,
//            14917.24,
//            15804.26,
//        ])
//    }
//
//    // This test ensures that bounded index checks are respected and that outrageously high or low octaves
//    // don't throw any errors. These sorts of octaves are usually picked up from microphone interference
//    // or other inaudible noises.
//    func testTheoreticalOctaves() {
//        let lowNotes = PitchClass.allCases.map { Note($0, octave: -100) }
//        let highNotes = PitchClass.allCases.map { Note($0, octave: 100) }
//
//        XCTAssertEqual(lowNotes.count, NoteMath.semitonesPerOctave)
//        XCTAssertEqual(lowNotes.map(\.pitchClass), PitchClass.allCases)
//
//        XCTAssertEqual(highNotes.count, NoteMath.semitonesPerOctave)
//        XCTAssertEqual(highNotes.map(\.pitchClass), PitchClass.allCases)
//    }
// }
