// Copyright © 2022 Brian Drelling. All rights reserved.

import Frequency
import XCTest

final class NoteMathTests: XCTestCase {
    // MARK: Half Step Interval

    func testStandardIntervalForFrequencySucceeds() throws {
        // A-1 to A9
        try XCTAssertEqual(NoteMath.standardIntervalForFrequency(13.75), -60)
        try XCTAssertEqual(NoteMath.standardIntervalForFrequency(27.5), -48)
        try XCTAssertEqual(NoteMath.standardIntervalForFrequency(55), -36)
        try XCTAssertEqual(NoteMath.standardIntervalForFrequency(110), -24)
        try XCTAssertEqual(NoteMath.standardIntervalForFrequency(220), -12)
        try XCTAssertEqual(NoteMath.standardIntervalForFrequency(440), 0)
        try XCTAssertEqual(NoteMath.standardIntervalForFrequency(880), 12)
        try XCTAssertEqual(NoteMath.standardIntervalForFrequency(1760), 24)
        try XCTAssertEqual(NoteMath.standardIntervalForFrequency(3520), 36)
        try XCTAssertEqual(NoteMath.standardIntervalForFrequency(7040), 48)
        try XCTAssertEqual(NoteMath.standardIntervalForFrequency(14080), 60)

        // C0
        try XCTAssertEqual(NoteMath.standardIntervalForFrequency(16.35), -57)
        // C4
        try XCTAssertEqual(NoteMath.standardIntervalForFrequency(261.6), -9)

        // Standard Guitar tuning
        try XCTAssertEqual(NoteMath.standardIntervalForFrequency(82.4), -29)
        try XCTAssertEqual(NoteMath.standardIntervalForFrequency(110.0), -24)
        try XCTAssertEqual(NoteMath.standardIntervalForFrequency(146.8), -19)
        try XCTAssertEqual(NoteMath.standardIntervalForFrequency(196.0), -14)
        try XCTAssertEqual(NoteMath.standardIntervalForFrequency(246.9), -10)
        try XCTAssertEqual(NoteMath.standardIntervalForFrequency(329.6), -5)
    }

    func testBaseIntervalForFrequencySucceeds() throws {
        // A-1 to A9
        try XCTAssertEqual(NoteMath.baseIntervalForFrequency(13.75), -60)
        try XCTAssertEqual(NoteMath.baseIntervalForFrequency(27.5), -48)
        try XCTAssertEqual(NoteMath.baseIntervalForFrequency(55), -36)
        try XCTAssertEqual(NoteMath.baseIntervalForFrequency(110), -24)
        try XCTAssertEqual(NoteMath.baseIntervalForFrequency(220), -12)
        try XCTAssertEqual(NoteMath.baseIntervalForFrequency(440), 0)
        try XCTAssertEqual(NoteMath.baseIntervalForFrequency(880), 12)
        try XCTAssertEqual(NoteMath.baseIntervalForFrequency(1760), 24)
        try XCTAssertEqual(NoteMath.baseIntervalForFrequency(3520), 36)
        try XCTAssertEqual(NoteMath.baseIntervalForFrequency(7040), 48)
        try XCTAssertEqual(NoteMath.baseIntervalForFrequency(14080), 60)

        // C0
        try XCTAssertEqual(NoteMath.baseIntervalForFrequency(16.35), -57)
        // C4
        try XCTAssertEqual(NoteMath.baseIntervalForFrequency(261.6), -9)

        // Standard Guitar tuning
        try XCTAssertEqual(NoteMath.baseIntervalForFrequency(82.4), -29)
        try XCTAssertEqual(NoteMath.baseIntervalForFrequency(110.0), -24)
        try XCTAssertEqual(NoteMath.baseIntervalForFrequency(146.8), -19)
        try XCTAssertEqual(NoteMath.baseIntervalForFrequency(196.0), -14)
        try XCTAssertEqual(NoteMath.baseIntervalForFrequency(246.9), -10)
        try XCTAssertEqual(NoteMath.baseIntervalForFrequency(329.6), -5)
    }

    func testInvalidIntervalMathReturnsNil() throws {
        try XCTAssertThrowsError(NoteMath.interval(from: -110, to: 440))
        try XCTAssertThrowsError(NoteMath.interval(from: 0, to: 440))
        try XCTAssertThrowsError(NoteMath.interval(from: 0, to: 0))
        try XCTAssertThrowsError(NoteMath.interval(from: 440, to: 0))
        try XCTAssertThrowsError(NoteMath.interval(from: 440, to: -110))

        do {
            let _ = try NoteMath.interval(from: -42, to: -66)
        } catch let NoteMathError.invalidFrequency(frequency) {
            XCTAssertEqual(frequency, -42)
        } catch {
            XCTFail("Error should not have occurred! Error: \(error.localizedDescription)")
        }

        do {
            let _ = try NoteMath.interval(from: 42, to: -66)
        } catch let NoteMathError.invalidFrequency(frequency) {
            XCTAssertEqual(frequency, -66)
        } catch {
            XCTFail("Error should not have occurred! Error: \(error.localizedDescription)")
        }
    }

    // MARK: Frequency

    func testFrequencyForIntervalSucceeds() {
        // A-1 to A9
        XCTAssertEqual(NoteMath.frequencyForInterval(-60), 13.75)
        XCTAssertEqual(NoteMath.frequencyForInterval(-48), 27.5)
        XCTAssertEqual(NoteMath.frequencyForInterval(-36), 55)
        XCTAssertEqual(NoteMath.frequencyForInterval(-24), 110)
        XCTAssertEqual(NoteMath.frequencyForInterval(-12), 220)
        XCTAssertEqual(NoteMath.frequencyForInterval(0), 440)
        XCTAssertEqual(NoteMath.frequencyForInterval(12), 880)
        XCTAssertEqual(NoteMath.frequencyForInterval(24), 1760)
        XCTAssertEqual(NoteMath.frequencyForInterval(36), 3520)
        XCTAssertEqual(NoteMath.frequencyForInterval(48), 7040)
        XCTAssertEqual(NoteMath.frequencyForInterval(60), 14080)

        // C0
        XCTAssertEqual(NoteMath.frequencyForInterval(-57), 16.35)
        // C4
        XCTAssertEqual(NoteMath.frequencyForInterval(-9), 261.63)

        // Standard Guitar tuning
        XCTAssertEqual(NoteMath.frequencyForInterval(-29), 82.41)
        XCTAssertEqual(NoteMath.frequencyForInterval(-24), 110.0)
        XCTAssertEqual(NoteMath.frequencyForInterval(-19), 146.83)
        XCTAssertEqual(NoteMath.frequencyForInterval(-14), 196.0)
        XCTAssertEqual(NoteMath.frequencyForInterval(-10), 246.94)
        XCTAssertEqual(NoteMath.frequencyForInterval(-5), 329.63)
    }

    // MARK: Cents

    func testCentsBetweenFrequenciesSucceeds() {
        // From A4 to A5 is 1200 cents
        XCTAssertEqual(NoteMath.cents(from: 220, to: 440), NoteMath.centsPerOctave)
        // From A4 to A6 is 2400 cents
        XCTAssertEqual(NoteMath.cents(from: 220, to: 880), NoteMath.centsPerOctave * 2)

        // From A4 to A3 is -1200 cents
        XCTAssertEqual(NoteMath.cents(from: 440, to: 220), -NoteMath.centsPerOctave)
        // From A4 to A2 is -2400 cents
        XCTAssertEqual(NoteMath.cents(from: 440, to: 110), -NoteMath.centsPerOctave * 2)

        // Standard Guitar tuning
        // There's no significane to using Standard Guitar tuning here,
        // these tests are arbitrarily selected to ensure accuracy.
        XCTAssertEqual(NoteMath.cents(from: 82.41, to: 110), 499.93454)
        XCTAssertEqual(NoteMath.cents(from: 110.0, to: 146.83), 499.972)
        XCTAssertEqual(NoteMath.cents(from: 146.83, to: 196.0), 500.0482)
        XCTAssertEqual(NoteMath.cents(from: 196.0, to: 246.94), 399.96826)
        XCTAssertEqual(NoteMath.cents(from: 246.94, to: 329.63), 500.02438)
        XCTAssertEqual(NoteMath.cents(from: 329.63, to: 82.41), -2399.9473)
    }

    // MARK: Octave

    func testOctaveForIntervalSucceeds() {
        // A-1 to A9
        XCTAssertEqual(NoteMath.octaveForInterval(-60), -1)
        XCTAssertEqual(NoteMath.octaveForInterval(-48), 0)
        XCTAssertEqual(NoteMath.octaveForInterval(-36), 1)
        XCTAssertEqual(NoteMath.octaveForInterval(-24), 2)
        XCTAssertEqual(NoteMath.octaveForInterval(-12), 3)
        XCTAssertEqual(NoteMath.octaveForInterval(0), 4)
        XCTAssertEqual(NoteMath.octaveForInterval(12), 5)
        XCTAssertEqual(NoteMath.octaveForInterval(24), 6)
        XCTAssertEqual(NoteMath.octaveForInterval(36), 7)
        XCTAssertEqual(NoteMath.octaveForInterval(48), 8)
        XCTAssertEqual(NoteMath.octaveForInterval(60), 9)

        // C0
        XCTAssertEqual(NoteMath.octaveForInterval(-57), 0)
        // C4
        XCTAssertEqual(NoteMath.octaveForInterval(-9), 4)

        // Standard Guitar tuning
        XCTAssertEqual(NoteMath.octaveForInterval(-29), 2)
        XCTAssertEqual(NoteMath.octaveForInterval(-24), 2)
        XCTAssertEqual(NoteMath.octaveForInterval(-19), 3)
        XCTAssertEqual(NoteMath.octaveForInterval(-14), 3)
        XCTAssertEqual(NoteMath.octaveForInterval(-10), 3)
        XCTAssertEqual(NoteMath.octaveForInterval(-5), 4)
    }

    func testOctaveForFrequencySucceeds() {
        // A-1 to A9
        try XCTAssertEqual(NoteMath.octaveForFrequency(13.75), -1)
        try XCTAssertEqual(NoteMath.octaveForFrequency(27.5), 0)
        try XCTAssertEqual(NoteMath.octaveForFrequency(55), 1)
        try XCTAssertEqual(NoteMath.octaveForFrequency(110), 2)
        try XCTAssertEqual(NoteMath.octaveForFrequency(220), 3)
        try XCTAssertEqual(NoteMath.octaveForFrequency(440), 4)
        try XCTAssertEqual(NoteMath.octaveForFrequency(880), 5)
        try XCTAssertEqual(NoteMath.octaveForFrequency(1760), 6)
        try XCTAssertEqual(NoteMath.octaveForFrequency(3520), 7)
        try XCTAssertEqual(NoteMath.octaveForFrequency(7040), 8)
        try XCTAssertEqual(NoteMath.octaveForFrequency(14080), 9)

        // C0
        try XCTAssertEqual(NoteMath.octaveForFrequency(16.35), 0)
        // C4
        try XCTAssertEqual(NoteMath.octaveForFrequency(261.6), 4)

        // Standard Guitar tuning
        try XCTAssertEqual(NoteMath.octaveForFrequency(82.4), 2)
        try XCTAssertEqual(NoteMath.octaveForFrequency(110.0), 2)
        try XCTAssertEqual(NoteMath.octaveForFrequency(146.8), 3)
        try XCTAssertEqual(NoteMath.octaveForFrequency(196.0), 3)
        try XCTAssertEqual(NoteMath.octaveForFrequency(246.9), 3)
        try XCTAssertEqual(NoteMath.octaveForFrequency(329.6), 4)
    }
}
