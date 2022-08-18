// Copyright © 2022 Brian Drelling. All rights reserved.

import NoteKit
import XCTest

final class PitchClassTests: XCTestCase {
    func testRawValueInitializationSucceeds() throws {
        // Exact values should match.
        XCTAssertEqual(PitchClass(rawValue: 0), .c)
        XCTAssertEqual(PitchClass(rawValue: 1), .cSharp)
        XCTAssertEqual(PitchClass(rawValue: 2), .d)
        XCTAssertEqual(PitchClass(rawValue: 3), .dSharp)
        XCTAssertEqual(PitchClass(rawValue: 4), .e)
        XCTAssertEqual(PitchClass(rawValue: 5), .f)
        XCTAssertEqual(PitchClass(rawValue: 6), .fSharp)
        XCTAssertEqual(PitchClass(rawValue: 7), .g)
        XCTAssertEqual(PitchClass(rawValue: 8), .gSharp)
        XCTAssertEqual(PitchClass(rawValue: 9), .a)
        XCTAssertEqual(PitchClass(rawValue: 10), .aSharp)
        XCTAssertEqual(PitchClass(rawValue: 11), .b)

        // Check that out-of-bounds values loop properly and return the right note.
        XCTAssertEqual(PitchClass(rawValue: 0 + 12), .c)
        XCTAssertEqual(PitchClass(rawValue: 1 + 12), .cSharp)
        XCTAssertEqual(PitchClass(rawValue: 2 + 12), .d)
        XCTAssertEqual(PitchClass(rawValue: 3 + 12), .dSharp)
        XCTAssertEqual(PitchClass(rawValue: 4 + 12), .e)
        XCTAssertEqual(PitchClass(rawValue: 5 + 12), .f)
        XCTAssertEqual(PitchClass(rawValue: 6 + 12), .fSharp)
        XCTAssertEqual(PitchClass(rawValue: 7 + 12), .g)
        XCTAssertEqual(PitchClass(rawValue: 8 + 12), .gSharp)
        XCTAssertEqual(PitchClass(rawValue: 9 + 12), .a)
        XCTAssertEqual(PitchClass(rawValue: 10 + 12), .aSharp)
        XCTAssertEqual(PitchClass(rawValue: 11 + 12), .b)

        XCTAssertEqual(PitchClass(rawValue: 0 - 12), .c)
        XCTAssertEqual(PitchClass(rawValue: 1 - 12), .cSharp)
        XCTAssertEqual(PitchClass(rawValue: 2 - 12), .d)
        XCTAssertEqual(PitchClass(rawValue: 3 - 12), .dSharp)
        XCTAssertEqual(PitchClass(rawValue: 4 - 12), .e)
        XCTAssertEqual(PitchClass(rawValue: 5 - 12), .f)
        XCTAssertEqual(PitchClass(rawValue: 6 - 12), .fSharp)
        XCTAssertEqual(PitchClass(rawValue: 7 - 12), .g)
        XCTAssertEqual(PitchClass(rawValue: 8 - 12), .gSharp)
        XCTAssertEqual(PitchClass(rawValue: 9 - 12), .a)
        XCTAssertEqual(PitchClass(rawValue: 10 - 12), .aSharp)
        XCTAssertEqual(PitchClass(rawValue: 11 - 12), .b)

        // Check that extreme values still work, just for sanity.
        XCTAssertEqual(PitchClass(rawValue: -200), .e)
        XCTAssertEqual(PitchClass(rawValue: 200), .gSharp)
    }

    func testNameInitializationSucceeds() {
        try XCTAssertEqual(PitchClass(name: "C"), .c)
        try XCTAssertEqual(PitchClass(name: "C#"), .cSharp)
        try XCTAssertEqual(PitchClass(name: "C♯"), .cSharp)
        try XCTAssertEqual(PitchClass(name: "Db"), .cSharp)
        try XCTAssertEqual(PitchClass(name: "D♭"), .cSharp)
        try XCTAssertEqual(PitchClass(name: "D"), .d)
        try XCTAssertEqual(PitchClass(name: "D#"), .dSharp)
        try XCTAssertEqual(PitchClass(name: "D♯"), .dSharp)
        try XCTAssertEqual(PitchClass(name: "Eb"), .dSharp)
        try XCTAssertEqual(PitchClass(name: "E♭"), .dSharp)
        try XCTAssertEqual(PitchClass(name: "E"), .e)
        try XCTAssertEqual(PitchClass(name: "F"), .f)
        try XCTAssertEqual(PitchClass(name: "F#"), .fSharp)
        try XCTAssertEqual(PitchClass(name: "F♯"), .fSharp)
        try XCTAssertEqual(PitchClass(name: "Gb"), .fSharp)
        try XCTAssertEqual(PitchClass(name: "G♭"), .fSharp)
        try XCTAssertEqual(PitchClass(name: "G"), .g)
        try XCTAssertEqual(PitchClass(name: "G#"), .gSharp)
        try XCTAssertEqual(PitchClass(name: "G♯"), .gSharp)
        try XCTAssertEqual(PitchClass(name: "Ab"), .gSharp)
        try XCTAssertEqual(PitchClass(name: "A♭"), .gSharp)
        try XCTAssertEqual(PitchClass(name: "A"), .a)
        try XCTAssertEqual(PitchClass(name: "A#"), .aSharp)
        try XCTAssertEqual(PitchClass(name: "A♯"), .aSharp)
        try XCTAssertEqual(PitchClass(name: "Bb"), .aSharp)
        try XCTAssertEqual(PitchClass(name: "B♭"), .aSharp)
        try XCTAssertEqual(PitchClass(name: "B"), .b)
    }

    func testPitchClassMathSucceeds() {}
}
