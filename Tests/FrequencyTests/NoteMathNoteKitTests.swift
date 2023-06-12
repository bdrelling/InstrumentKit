// Copyright © 2023 Brian Drelling. All rights reserved.

import Frequency
import NoteKit
import XCTest

final class NoteMathNoteKitTests: XCTestCase {
    // MARK: Interval

    func testIntervalForNoteSucceeds() {
        // A-1 to A9
        XCTAssertEqual(NoteMath.standardInterval(for: .a(-1)), -60)
        XCTAssertEqual(NoteMath.standardInterval(for: .a(0)), -48)
        XCTAssertEqual(NoteMath.standardInterval(for: .a(1)), -36)
        XCTAssertEqual(NoteMath.standardInterval(for: .a(2)), -24)
        XCTAssertEqual(NoteMath.standardInterval(for: .a(3)), -12)
        XCTAssertEqual(NoteMath.standardInterval(for: .a(4)), 0)
        XCTAssertEqual(NoteMath.standardInterval(for: .a(5)), 12)
        XCTAssertEqual(NoteMath.standardInterval(for: .a(6)), 24)
        XCTAssertEqual(NoteMath.standardInterval(for: .a(7)), 36)
        XCTAssertEqual(NoteMath.standardInterval(for: .a(8)), 48)
        XCTAssertEqual(NoteMath.standardInterval(for: .a(9)), 60)

        // C0
        XCTAssertEqual(NoteMath.standardInterval(for: .c(0)), -57)
        // C4
        XCTAssertEqual(NoteMath.standardInterval(for: .c(4)), -9)

        // Standard Guitar tuning
        XCTAssertEqual(NoteMath.standardInterval(for: .e(2)), -29)
        XCTAssertEqual(NoteMath.standardInterval(for: .a(2)), -24)
        XCTAssertEqual(NoteMath.standardInterval(for: .d(3)), -19)
        XCTAssertEqual(NoteMath.standardInterval(for: .g(3)), -14)
        XCTAssertEqual(NoteMath.standardInterval(for: .b(3)), -10)
        XCTAssertEqual(NoteMath.standardInterval(for: .e(4)), -5)
    }

    // MARK: Frequency

    func testFrequencyForNoteSucceeds() {
        // A-1 to A9
        XCTAssertEqual(NoteMath.frequencyForNote(.a(-1)), 13.75)
        XCTAssertEqual(NoteMath.frequencyForNote(.a(0)), 27.5)
        XCTAssertEqual(NoteMath.frequencyForNote(.a(1)), 55)
        XCTAssertEqual(NoteMath.frequencyForNote(.a(2)), 110)
        XCTAssertEqual(NoteMath.frequencyForNote(.a(3)), 220)
        XCTAssertEqual(NoteMath.frequencyForNote(.a(4)), 440)
        XCTAssertEqual(NoteMath.frequencyForNote(.a(5)), 880)
        XCTAssertEqual(NoteMath.frequencyForNote(.a(6)), 1760)
        XCTAssertEqual(NoteMath.frequencyForNote(.a(7)), 3520)
        XCTAssertEqual(NoteMath.frequencyForNote(.a(8)), 7040)
        XCTAssertEqual(NoteMath.frequencyForNote(.a(9)), 14080)

        // C0
        XCTAssertEqual(NoteMath.frequencyForNote(.c(0)), 16.35)
        // C4
        XCTAssertEqual(NoteMath.frequencyForNote(.c(4)), 261.63)

        // Standard Guitar tuning
        XCTAssertEqual(NoteMath.frequencyForNote(.e(2)), 82.41)
        XCTAssertEqual(NoteMath.frequencyForNote(.a(2)), 110.0)
        XCTAssertEqual(NoteMath.frequencyForNote(.d(3)), 146.83)
        XCTAssertEqual(NoteMath.frequencyForNote(.g(3)), 196.0)
        XCTAssertEqual(NoteMath.frequencyForNote(.b(3)), 246.94)
        XCTAssertEqual(NoteMath.frequencyForNote(.e(4)), 329.63)
    }

    func testFrequencyForPitchClassSucceeds() {
        // A-1 to A9
        XCTAssertEqual(NoteMath.frequencyForPitchClass(.a, octave: -1), 13.75)
        XCTAssertEqual(NoteMath.frequencyForPitchClass(.a, octave: 0), 27.5)
        XCTAssertEqual(NoteMath.frequencyForPitchClass(.a, octave: 1), 55)
        XCTAssertEqual(NoteMath.frequencyForPitchClass(.a, octave: 2), 110)
        XCTAssertEqual(NoteMath.frequencyForPitchClass(.a, octave: 3), 220)
        XCTAssertEqual(NoteMath.frequencyForPitchClass(.a, octave: 4), 440)
        XCTAssertEqual(NoteMath.frequencyForPitchClass(.a, octave: 5), 880)
        XCTAssertEqual(NoteMath.frequencyForPitchClass(.a, octave: 6), 1760)
        XCTAssertEqual(NoteMath.frequencyForPitchClass(.a, octave: 7), 3520)
        XCTAssertEqual(NoteMath.frequencyForPitchClass(.a, octave: 8), 7040)
        XCTAssertEqual(NoteMath.frequencyForPitchClass(.a, octave: 9), 14080)

        // C0
        XCTAssertEqual(NoteMath.frequencyForPitchClass(.c, octave: 0), 16.35)
        // C4
        XCTAssertEqual(NoteMath.frequencyForPitchClass(.c, octave: 4), 261.63)

        // Standard Guitar tuning
        XCTAssertEqual(NoteMath.frequencyForPitchClass(.e, octave: 2), 82.41)
        XCTAssertEqual(NoteMath.frequencyForPitchClass(.a, octave: 2), 110.0)
        XCTAssertEqual(NoteMath.frequencyForPitchClass(.d, octave: 3), 146.83)
        XCTAssertEqual(NoteMath.frequencyForPitchClass(.g, octave: 3), 196.0)
        XCTAssertEqual(NoteMath.frequencyForPitchClass(.b, octave: 3), 246.94)
        XCTAssertEqual(NoteMath.frequencyForPitchClass(.e, octave: 4), 329.63)
    }

    // MARK: Cents

    func testCentsFromNoteToFrequencySucceeds() {
        // From A4 to A5 is 1200 cents
        XCTAssertEqual(NoteMath.cents(from: .a(4), to: 880), NoteMath.centsPerOctave)
        // From A4 to A6 is 2400 cents
        XCTAssertEqual(NoteMath.cents(from: .a(4), to: 1760), NoteMath.centsPerOctave * 2)

        // From A4 to A3 is -1200 cents
        XCTAssertEqual(NoteMath.cents(from: .a(4), to: 220), -NoteMath.centsPerOctave)
        // From A4 to A2 is -2400 cents
        XCTAssertEqual(NoteMath.cents(from: .a(4), to: 110), -NoteMath.centsPerOctave * 2)

        // Standard Guitar tuning
        // There's no significane to using Standard Guitar tuning here,
        // these tests are arbitrarily selected to ensure accuracy.
        XCTAssertEqual(NoteMath.cents(from: .e(2), to: 110.0), 499.93454)
        XCTAssertEqual(NoteMath.cents(from: .a(2), to: 146.83), 499.972)
        XCTAssertEqual(NoteMath.cents(from: .d(3), to: 196.0), 500.0482)
        XCTAssertEqual(NoteMath.cents(from: .g(3), to: 246.94), 399.96826)
        XCTAssertEqual(NoteMath.cents(from: .b(3), to: 329.63), 500.02438)
        XCTAssertEqual(NoteMath.cents(from: .e(4), to: 82.41), -2399.9473)
    }

    func testCentsFromNoteToOtherNoteSucceeds() {
        // From A4 to A5 is 1200 cents
        XCTAssertEqual(NoteMath.cents(from: .a(4), to: .a(5)), NoteMath.centsPerOctave)
        // From A4 to A6 is 2400 cents
        XCTAssertEqual(NoteMath.cents(from: .a(4), to: .a(6)), NoteMath.centsPerOctave * 2)

        // From A4 to A3 is -1200 cents
        XCTAssertEqual(NoteMath.cents(from: .a(4), to: .a(3)), -NoteMath.centsPerOctave)
        // From A4 to A2 is -2400 cents
        XCTAssertEqual(NoteMath.cents(from: .a(4), to: .a(2)), -NoteMath.centsPerOctave * 2)

        // Standard Guitar tuning
        // There's no significane to using Standard Guitar tuning here,
        // these tests are arbitrarily selected to ensure accuracy.
        XCTAssertEqual(NoteMath.cents(from: .e(2), to: .a(2)), 499.93454)
        XCTAssertEqual(NoteMath.cents(from: .a(2), to: .d(3)), 499.972)
        XCTAssertEqual(NoteMath.cents(from: .d(3), to: .g(3)), 500.0482)
        XCTAssertEqual(NoteMath.cents(from: .g(3), to: .b(3)), 399.96826)
        XCTAssertEqual(NoteMath.cents(from: .b(3), to: .e(4)), 500.02438)
        XCTAssertEqual(NoteMath.cents(from: .e(4), to: .e(2)), -2399.9473)
    }

    // MARK: Note Class

    func testPitchClassForIntervalSucceeds() {
        // A-1
        // A-1 check currently fails -- reenable unless Tonic integration makes this unnecessary
        // XCTAssertEqual(NoteMath.pitchClassForInterval(-60), .a)

        // A0 to A9
        XCTAssertEqual(NoteMath.pitchClassForInterval(-48), .a)
        XCTAssertEqual(NoteMath.pitchClassForInterval(-36), .a)
        XCTAssertEqual(NoteMath.pitchClassForInterval(-24), .a)
        XCTAssertEqual(NoteMath.pitchClassForInterval(-12), .a)
        XCTAssertEqual(NoteMath.pitchClassForInterval(0), .a)
        XCTAssertEqual(NoteMath.pitchClassForInterval(12), .a)
        XCTAssertEqual(NoteMath.pitchClassForInterval(24), .a)
        XCTAssertEqual(NoteMath.pitchClassForInterval(36), .a)
        XCTAssertEqual(NoteMath.pitchClassForInterval(48), .a)
        XCTAssertEqual(NoteMath.pitchClassForInterval(60), .a)

        // C0
        XCTAssertEqual(NoteMath.pitchClassForInterval(-57), .c)
        // C4
        XCTAssertEqual(NoteMath.pitchClassForInterval(-9), .c)

        // Standard Guitar tuning
        XCTAssertEqual(NoteMath.pitchClassForInterval(-29), .e)
        XCTAssertEqual(NoteMath.pitchClassForInterval(-24), .a)
        XCTAssertEqual(NoteMath.pitchClassForInterval(-19), .d)
        XCTAssertEqual(NoteMath.pitchClassForInterval(-14), .g)
        XCTAssertEqual(NoteMath.pitchClassForInterval(-10), .b)
        XCTAssertEqual(NoteMath.pitchClassForInterval(-5), .e)
    }

    func testPitchClassForFrequencySucceeds() {
        // A-1
        // A-1 check currently fails -- reenable unless Tonic integration makes this unnecessary
        // try XCTAssertEqual(NoteMath.pitchClassForFrequency(13.75), .a)

        // A0 to A9
        try XCTAssertEqual(NoteMath.pitchClassForFrequency(27.5), .a)
        try XCTAssertEqual(NoteMath.pitchClassForFrequency(55), .a)
        try XCTAssertEqual(NoteMath.pitchClassForFrequency(110), .a)
        try XCTAssertEqual(NoteMath.pitchClassForFrequency(220), .a)
        try XCTAssertEqual(NoteMath.pitchClassForFrequency(440), .a)
        try XCTAssertEqual(NoteMath.pitchClassForFrequency(880), .a)
        try XCTAssertEqual(NoteMath.pitchClassForFrequency(1760), .a)
        try XCTAssertEqual(NoteMath.pitchClassForFrequency(3520), .a)
        try XCTAssertEqual(NoteMath.pitchClassForFrequency(7040), .a)
        try XCTAssertEqual(NoteMath.pitchClassForFrequency(14080), .a)

        // C0
        try XCTAssertEqual(NoteMath.pitchClassForFrequency(16.35), .c)
        // C4
        try XCTAssertEqual(NoteMath.pitchClassForFrequency(261.6), .c)

        // Standard Guitar tuning
        try XCTAssertEqual(NoteMath.pitchClassForFrequency(82.4), .e)
        try XCTAssertEqual(NoteMath.pitchClassForFrequency(110.0), .a)
        try XCTAssertEqual(NoteMath.pitchClassForFrequency(146.8), .d)
        try XCTAssertEqual(NoteMath.pitchClassForFrequency(196.0), .g)
        try XCTAssertEqual(NoteMath.pitchClassForFrequency(246.9), .b)
        try XCTAssertEqual(NoteMath.pitchClassForFrequency(329.6), .e)
    }

    // MARK: Note

    func testNoteForIntervalSucceeds() {
        // A-1
        // A-1 check currently fails -- reenable unless Tonic integration makes this unnecessary
        // XCTAssertEqual(NoteMath.noteForInterval(-60), .a(-1))

        // A0 to A9
        XCTAssertEqual(NoteMath.noteForInterval(-48), .a(0))
        XCTAssertEqual(NoteMath.noteForInterval(-36), .a(1))
        XCTAssertEqual(NoteMath.noteForInterval(-24), .a(2))
        XCTAssertEqual(NoteMath.noteForInterval(-12), .a(3))
        XCTAssertEqual(NoteMath.noteForInterval(0), .a(4))
        XCTAssertEqual(NoteMath.noteForInterval(12), .a(5))
        XCTAssertEqual(NoteMath.noteForInterval(24), .a(6))
        XCTAssertEqual(NoteMath.noteForInterval(36), .a(7))
        XCTAssertEqual(NoteMath.noteForInterval(48), .a(8))
        XCTAssertEqual(NoteMath.noteForInterval(60), .a(9))

        // C0
        XCTAssertEqual(NoteMath.noteForInterval(-57), .c(0))
        // C4
        XCTAssertEqual(NoteMath.noteForInterval(-9), .c(4))

        // Standard Guitar tuning
        XCTAssertEqual(NoteMath.noteForInterval(-29), .e(2))
        XCTAssertEqual(NoteMath.noteForInterval(-24), .a(2))
        XCTAssertEqual(NoteMath.noteForInterval(-19), .d(3))
        XCTAssertEqual(NoteMath.noteForInterval(-14), .g(3))
        XCTAssertEqual(NoteMath.noteForInterval(-10), .b(3))
        XCTAssertEqual(NoteMath.noteForInterval(-5), .e(4))
    }

    func testNoteForFrequencySucceeds() throws {
        // A-1
        // A-1 check currently fails -- reenable unless Tonic integration makes this unnecessary
        // try XCTAssertEqual(NoteMath.noteForFrequency(13.75), .a(-1))

        // A0 to A9
        try XCTAssertEqual(NoteMath.noteForFrequency(27.5), .a(0))
        try XCTAssertEqual(NoteMath.noteForFrequency(55), .a(1))
        try XCTAssertEqual(NoteMath.noteForFrequency(110), .a(2))
        try XCTAssertEqual(NoteMath.noteForFrequency(220), .a(3))
        try XCTAssertEqual(NoteMath.noteForFrequency(440), .a(4))
        try XCTAssertEqual(NoteMath.noteForFrequency(880), .a(5))
        try XCTAssertEqual(NoteMath.noteForFrequency(1760), .a(6))
        try XCTAssertEqual(NoteMath.noteForFrequency(3520), .a(7))
        try XCTAssertEqual(NoteMath.noteForFrequency(7040), .a(8))
        try XCTAssertEqual(NoteMath.noteForFrequency(14080), .a(9))

        // C0
        try XCTAssertEqual(NoteMath.noteForFrequency(16.35), .c(0))
        // C4
        try XCTAssertEqual(NoteMath.noteForFrequency(261.6), .c(4))

        // Standard Guitar tuning
        try XCTAssertEqual(NoteMath.noteForFrequency(82.4), .e(2))
        try XCTAssertEqual(NoteMath.noteForFrequency(110.0), .a(2))
        try XCTAssertEqual(NoteMath.noteForFrequency(146.8), .d(3))
        try XCTAssertEqual(NoteMath.noteForFrequency(196.0), .g(3))
        try XCTAssertEqual(NoteMath.noteForFrequency(246.9), .b(3))
        try XCTAssertEqual(NoteMath.noteForFrequency(329.6), .e(4))
    }
}
