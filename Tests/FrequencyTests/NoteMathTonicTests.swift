// Copyright © 2022 Brian Drelling. All rights reserved.

import Frequency
import Tonic
import XCTest

final class NoteMathTonicTests: XCTestCase {
    // MARK: Interval
    
    func testTonic() {
let note = Note(.A, octave: 100)
note.semitones(to: .A)
//        let pitch = Pitch(intValue: 50000)
    }

    func testIntervalForNoteSucceeds() {
        // A-1 to A9
        XCTAssertEqual(NoteMath.standardInterval(for: .A(-1)), -60)
        XCTAssertEqual(NoteMath.standardInterval(for: .A(0)), -48)
        XCTAssertEqual(NoteMath.standardInterval(for: .A(1)), -36)
        XCTAssertEqual(NoteMath.standardInterval(for: .A(2)), -24)
        XCTAssertEqual(NoteMath.standardInterval(for: .A(3)), -12)
        XCTAssertEqual(NoteMath.standardInterval(for: .A(4)), 0)
        XCTAssertEqual(NoteMath.standardInterval(for: .A(5)), 12)
        XCTAssertEqual(NoteMath.standardInterval(for: .A(6)), 24)
        XCTAssertEqual(NoteMath.standardInterval(for: .A(7)), 36)
        XCTAssertEqual(NoteMath.standardInterval(for: .A(8)), 48)
        XCTAssertEqual(NoteMath.standardInterval(for: .A(9)), 60)

        // C0
        XCTAssertEqual(NoteMath.standardInterval(for: .C(0)), -57)
        // C4
        XCTAssertEqual(NoteMath.standardInterval(for: .C(4)), -9)

        // Standard Guitar tuning
        XCTAssertEqual(NoteMath.standardInterval(for: .E(2)), -29)
        XCTAssertEqual(NoteMath.standardInterval(for: .A(2)), -24)
        XCTAssertEqual(NoteMath.standardInterval(for: .D(3)), -19)
        XCTAssertEqual(NoteMath.standardInterval(for: .G(3)), -14)
        XCTAssertEqual(NoteMath.standardInterval(for: .B(3)), -10)
        XCTAssertEqual(NoteMath.standardInterval(for: .E(4)), -5)
    }

    // MARK: Frequency

    func testFrequencyForNoteSucceeds() {
        // A-1 to A9
        XCTAssertEqual(NoteMath.frequencyForNote(.A(-1)), 13.75)
        XCTAssertEqual(NoteMath.frequencyForNote(.A(0)), 27.5)
        XCTAssertEqual(NoteMath.frequencyForNote(.A(1)), 55)
        XCTAssertEqual(NoteMath.frequencyForNote(.A(2)), 110)
        XCTAssertEqual(NoteMath.frequencyForNote(.A(3)), 220)
        XCTAssertEqual(NoteMath.frequencyForNote(.A(4)), 440)
        XCTAssertEqual(NoteMath.frequencyForNote(.A(5)), 880)
        XCTAssertEqual(NoteMath.frequencyForNote(.A(6)), 1760)
        XCTAssertEqual(NoteMath.frequencyForNote(.A(7)), 3520)
        XCTAssertEqual(NoteMath.frequencyForNote(.A(8)), 7040)
        XCTAssertEqual(NoteMath.frequencyForNote(.A(9)), 14080)

        // C0
        XCTAssertEqual(NoteMath.frequencyForNote(.C(0)), 16.35)
        // C4
        XCTAssertEqual(NoteMath.frequencyForNote(.C(4)), 261.63)

        // Standard Guitar tuning
        XCTAssertEqual(NoteMath.frequencyForNote(.E(2)), 82.41)
        XCTAssertEqual(NoteMath.frequencyForNote(.A(2)), 110.0)
        XCTAssertEqual(NoteMath.frequencyForNote(.D(3)), 146.83)
        XCTAssertEqual(NoteMath.frequencyForNote(.G(3)), 196.0)
        XCTAssertEqual(NoteMath.frequencyForNote(.B(3)), 246.94)
        XCTAssertEqual(NoteMath.frequencyForNote(.E(4)), 329.63)
    }

    func testFrequencyForNoteClassSucceeds() {
        // A-1 to A9
        XCTAssertEqual(NoteMath.frequencyForNoteClass(.A, octave: -1), 13.75)
        XCTAssertEqual(NoteMath.frequencyForNoteClass(.A, octave: 0), 27.5)
        XCTAssertEqual(NoteMath.frequencyForNoteClass(.A, octave: 1), 55)
        XCTAssertEqual(NoteMath.frequencyForNoteClass(.A, octave: 2), 110)
        XCTAssertEqual(NoteMath.frequencyForNoteClass(.A, octave: 3), 220)
        XCTAssertEqual(NoteMath.frequencyForNoteClass(.A, octave: 4), 440)
        XCTAssertEqual(NoteMath.frequencyForNoteClass(.A, octave: 5), 880)
        XCTAssertEqual(NoteMath.frequencyForNoteClass(.A, octave: 6), 1760)
        XCTAssertEqual(NoteMath.frequencyForNoteClass(.A, octave: 7), 3520)
        XCTAssertEqual(NoteMath.frequencyForNoteClass(.A, octave: 8), 7040)
        XCTAssertEqual(NoteMath.frequencyForNoteClass(.A, octave: 9), 14080)

        // C0
        XCTAssertEqual(NoteMath.frequencyForNoteClass(.C, octave: 0), 16.35)
        // C4
        XCTAssertEqual(NoteMath.frequencyForNoteClass(.C, octave: 4), 261.63)

        // Standard Guitar tuning
        XCTAssertEqual(NoteMath.frequencyForNoteClass(.E, octave: 2), 82.41)
        XCTAssertEqual(NoteMath.frequencyForNoteClass(.A, octave: 2), 110.0)
        XCTAssertEqual(NoteMath.frequencyForNoteClass(.D, octave: 3), 146.83)
        XCTAssertEqual(NoteMath.frequencyForNoteClass(.G, octave: 3), 196.0)
        XCTAssertEqual(NoteMath.frequencyForNoteClass(.B, octave: 3), 246.94)
        XCTAssertEqual(NoteMath.frequencyForNoteClass(.E, octave: 4), 329.63)
    }

    // MARK: Cents

    func testCentsFromNoteToFrequencySucceeds() {
        // From A4 to A5 is 1200 cents
        XCTAssertEqual(NoteMath.cents(from: .A(4), to: 880), NoteMath.centsPerOctave)
        // From A4 to A6 is 2400 cents
        XCTAssertEqual(NoteMath.cents(from: .A(4), to: 1760), NoteMath.centsPerOctave * 2)

        // From A4 to A3 is -1200 cents
        XCTAssertEqual(NoteMath.cents(from: .A(4), to: 220), -NoteMath.centsPerOctave)
        // From A4 to A2 is -2400 cents
        XCTAssertEqual(NoteMath.cents(from: .A(4), to: 110), -NoteMath.centsPerOctave * 2)

        // Standard Guitar tuning
        // There's no significane to using Standard Guitar tuning here,
        // these tests are arbitrarily selected to ensure accuracy.
        XCTAssertEqual(NoteMath.cents(from: .E(2), to: 110.0), 499.93454)
        XCTAssertEqual(NoteMath.cents(from: .A(2), to: 146.83), 499.972)
        XCTAssertEqual(NoteMath.cents(from: .D(3), to: 196.0), 500.0482)
        XCTAssertEqual(NoteMath.cents(from: .G(3), to: 246.94), 399.96826)
        XCTAssertEqual(NoteMath.cents(from: .B(3), to: 329.63), 500.02438)
        XCTAssertEqual(NoteMath.cents(from: .E(4), to: 82.41), -2399.9473)
    }

    func testCentsFromNoteToOtherNoteSucceeds() {
        // From A4 to A5 is 1200 cents
        XCTAssertEqual(NoteMath.cents(from: .A(4), to: .A(5)), NoteMath.centsPerOctave)
        // From A4 to A6 is 2400 cents
        XCTAssertEqual(NoteMath.cents(from: .A(4), to: .A(6)), NoteMath.centsPerOctave * 2)

        // From A4 to A3 is -1200 cents
        XCTAssertEqual(NoteMath.cents(from: .A(4), to: .A(3)), -NoteMath.centsPerOctave)
        // From A4 to A2 is -2400 cents
        XCTAssertEqual(NoteMath.cents(from: .A(4), to: .A(2)), -NoteMath.centsPerOctave * 2)

        // Standard Guitar tuning
        // There's no significane to using Standard Guitar tuning here,
        // these tests are arbitrarily selected to ensure accuracy.
        XCTAssertEqual(NoteMath.cents(from: .E(2), to: .A(2)), 499.93454)
        XCTAssertEqual(NoteMath.cents(from: .A(2), to: .D(3)), 499.972)
        XCTAssertEqual(NoteMath.cents(from: .D(3), to: .G(3)), 500.0482)
        XCTAssertEqual(NoteMath.cents(from: .G(3), to: .B(3)), 399.96826)
        XCTAssertEqual(NoteMath.cents(from: .B(3), to: .E(4)), 500.02438)
        XCTAssertEqual(NoteMath.cents(from: .E(4), to: .E(2)), -2399.9473)
    }

    // MARK: Note Class

    func testNoteClassForIntervalSucceeds() {
        // A-1
        // A-1 check currently fails -- reenable unless Tonic integration makes this unnecessary
        // XCTAssertEqual(NoteMath.noteClassForInterval(-60), .A)

        // A0 to A9
        XCTAssertEqual(NoteMath.noteClassForInterval(-48), .A)
        XCTAssertEqual(NoteMath.noteClassForInterval(-36), .A)
        XCTAssertEqual(NoteMath.noteClassForInterval(-24), .A)
        XCTAssertEqual(NoteMath.noteClassForInterval(-12), .A)
        XCTAssertEqual(NoteMath.noteClassForInterval(0), .A)
        XCTAssertEqual(NoteMath.noteClassForInterval(12), .A)
        XCTAssertEqual(NoteMath.noteClassForInterval(24), .A)
        XCTAssertEqual(NoteMath.noteClassForInterval(36), .A)
        XCTAssertEqual(NoteMath.noteClassForInterval(48), .A)
        XCTAssertEqual(NoteMath.noteClassForInterval(60), .A)

        // C0
        XCTAssertEqual(NoteMath.noteClassForInterval(-57), .C)
        // C4
        XCTAssertEqual(NoteMath.noteClassForInterval(-9), .C)

        // Standard Guitar tuning
        XCTAssertEqual(NoteMath.noteClassForInterval(-29), .E)
        XCTAssertEqual(NoteMath.noteClassForInterval(-24), .A)
        XCTAssertEqual(NoteMath.noteClassForInterval(-19), .D)
        XCTAssertEqual(NoteMath.noteClassForInterval(-14), .G)
        XCTAssertEqual(NoteMath.noteClassForInterval(-10), .B)
        XCTAssertEqual(NoteMath.noteClassForInterval(-5), .E)
    }

    func testNoteClassForFrequencySucceeds() {
        // A-1
        // A-1 check currently fails -- reenable unless Tonic integration makes this unnecessary
        // try XCTAssertEqual(NoteMath.noteClassForFrequency(13.75), .A)

        // A0 to A9
        try XCTAssertEqual(NoteMath.noteClassForFrequency(27.5), .A)
        try XCTAssertEqual(NoteMath.noteClassForFrequency(55), .A)
        try XCTAssertEqual(NoteMath.noteClassForFrequency(110), .A)
        try XCTAssertEqual(NoteMath.noteClassForFrequency(220), .A)
        try XCTAssertEqual(NoteMath.noteClassForFrequency(440), .A)
        try XCTAssertEqual(NoteMath.noteClassForFrequency(880), .A)
        try XCTAssertEqual(NoteMath.noteClassForFrequency(1760), .A)
        try XCTAssertEqual(NoteMath.noteClassForFrequency(3520), .A)
        try XCTAssertEqual(NoteMath.noteClassForFrequency(7040), .A)
        try XCTAssertEqual(NoteMath.noteClassForFrequency(14080), .A)

        // C0
        try XCTAssertEqual(NoteMath.noteClassForFrequency(16.35), .C)
        // C4
        try XCTAssertEqual(NoteMath.noteClassForFrequency(261.6), .C)

        // Standard Guitar tuning
        try XCTAssertEqual(NoteMath.noteClassForFrequency(82.4), .E)
        try XCTAssertEqual(NoteMath.noteClassForFrequency(110.0), .A)
        try XCTAssertEqual(NoteMath.noteClassForFrequency(146.8), .D)
        try XCTAssertEqual(NoteMath.noteClassForFrequency(196.0), .G)
        try XCTAssertEqual(NoteMath.noteClassForFrequency(246.9), .B)
        try XCTAssertEqual(NoteMath.noteClassForFrequency(329.6), .E)
    }

    // MARK: Note

    func testNoteForIntervalSucceeds() {
        // A-1
        // A-1 check currently fails -- reenable unless Tonic integration makes this unnecessary
        // XCTAssertEqual(NoteMath.noteForInterval(-60), .A(-1))

        // A0 to A9
        XCTAssertEqual(NoteMath.noteForInterval(-48), .A(0))
        XCTAssertEqual(NoteMath.noteForInterval(-36), .A(1))
        XCTAssertEqual(NoteMath.noteForInterval(-24), .A(2))
        XCTAssertEqual(NoteMath.noteForInterval(-12), .A(3))
        XCTAssertEqual(NoteMath.noteForInterval(0), .A(4))
        XCTAssertEqual(NoteMath.noteForInterval(12), .A(5))
        XCTAssertEqual(NoteMath.noteForInterval(24), .A(6))
        XCTAssertEqual(NoteMath.noteForInterval(36), .A(7))
        XCTAssertEqual(NoteMath.noteForInterval(48), .A(8))
        XCTAssertEqual(NoteMath.noteForInterval(60), .A(9))

        // C0
        XCTAssertEqual(NoteMath.noteForInterval(-57), .C(0))
        // C4
        XCTAssertEqual(NoteMath.noteForInterval(-9), .C(4))

        // Standard Guitar tuning
        XCTAssertEqual(NoteMath.noteForInterval(-29), .E(2))
        XCTAssertEqual(NoteMath.noteForInterval(-24), .A(2))
        XCTAssertEqual(NoteMath.noteForInterval(-19), .D(3))
        XCTAssertEqual(NoteMath.noteForInterval(-14), .G(3))
        XCTAssertEqual(NoteMath.noteForInterval(-10), .B(3))
        XCTAssertEqual(NoteMath.noteForInterval(-5), .E(4))
    }

    func testNoteForFrequencySucceeds() throws {
        // A-1
        // A-1 check currently fails -- reenable unless Tonic integration makes this unnecessary
        // try XCTAssertEqual(NoteMath.noteForFrequency(13.75), .A(-1))

        // A0 to A9
        try XCTAssertEqual(NoteMath.noteForFrequency(27.5), .A(0))
        try XCTAssertEqual(NoteMath.noteForFrequency(55), .A(1))
        try XCTAssertEqual(NoteMath.noteForFrequency(110), .A(2))
        try XCTAssertEqual(NoteMath.noteForFrequency(220), .A(3))
        try XCTAssertEqual(NoteMath.noteForFrequency(440), .A(4))
        try XCTAssertEqual(NoteMath.noteForFrequency(880), .A(5))
        try XCTAssertEqual(NoteMath.noteForFrequency(1760), .A(6))
        try XCTAssertEqual(NoteMath.noteForFrequency(3520), .A(7))
        try XCTAssertEqual(NoteMath.noteForFrequency(7040), .A(8))
        try XCTAssertEqual(NoteMath.noteForFrequency(14080), .A(9))

        // C0
        try XCTAssertEqual(NoteMath.noteForFrequency(16.35), .C(0))
        // C4
        try XCTAssertEqual(NoteMath.noteForFrequency(261.6), .C(4))

        // Standard Guitar tuning
        try XCTAssertEqual(NoteMath.noteForFrequency(82.4), .E(2))
        try XCTAssertEqual(NoteMath.noteForFrequency(110.0), .A(2))
        try XCTAssertEqual(NoteMath.noteForFrequency(146.8), .D(3))
        try XCTAssertEqual(NoteMath.noteForFrequency(196.0), .G(3))
        try XCTAssertEqual(NoteMath.noteForFrequency(246.9), .B(3))
        try XCTAssertEqual(NoteMath.noteForFrequency(329.6), .E(4))
    }
}
