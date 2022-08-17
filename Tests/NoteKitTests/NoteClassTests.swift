// Copyright © 2022 Brian Drelling. All rights reserved.

import NoteKit
import XCTest

final class NoteClassTests: XCTestCase {
    func testRawValueInitializationSucceeds() throws {
        // Exact values should match.
        XCTAssertEqual(NoteClass(rawValue: 0), .c)
        XCTAssertEqual(NoteClass(rawValue: 1), .cSharp)
        XCTAssertEqual(NoteClass(rawValue: 2), .d)
        XCTAssertEqual(NoteClass(rawValue: 3), .dSharp)
        XCTAssertEqual(NoteClass(rawValue: 4), .e)
        XCTAssertEqual(NoteClass(rawValue: 5), .f)
        XCTAssertEqual(NoteClass(rawValue: 6), .fSharp)
        XCTAssertEqual(NoteClass(rawValue: 7), .g)
        XCTAssertEqual(NoteClass(rawValue: 8), .gSharp)
        XCTAssertEqual(NoteClass(rawValue: 9), .a)
        XCTAssertEqual(NoteClass(rawValue: 10), .aSharp)
        XCTAssertEqual(NoteClass(rawValue: 11), .b)

        // Check that out-of-bounds values loop properly and return the right note.
        XCTAssertEqual(NoteClass(rawValue: 0 + 12), .c)
        XCTAssertEqual(NoteClass(rawValue: 1 + 12), .cSharp)
        XCTAssertEqual(NoteClass(rawValue: 2 + 12), .d)
        XCTAssertEqual(NoteClass(rawValue: 3 + 12), .dSharp)
        XCTAssertEqual(NoteClass(rawValue: 4 + 12), .e)
        XCTAssertEqual(NoteClass(rawValue: 5 + 12), .f)
        XCTAssertEqual(NoteClass(rawValue: 6 + 12), .fSharp)
        XCTAssertEqual(NoteClass(rawValue: 7 + 12), .g)
        XCTAssertEqual(NoteClass(rawValue: 8 + 12), .gSharp)
        XCTAssertEqual(NoteClass(rawValue: 9 + 12), .a)
        XCTAssertEqual(NoteClass(rawValue: 10 + 12), .aSharp)
        XCTAssertEqual(NoteClass(rawValue: 11 + 12), .b)

        XCTAssertEqual(NoteClass(rawValue: 0 - 12), .c)
        XCTAssertEqual(NoteClass(rawValue: 1 - 12), .cSharp)
        XCTAssertEqual(NoteClass(rawValue: 2 - 12), .d)
        XCTAssertEqual(NoteClass(rawValue: 3 - 12), .dSharp)
        XCTAssertEqual(NoteClass(rawValue: 4 - 12), .e)
        XCTAssertEqual(NoteClass(rawValue: 5 - 12), .f)
        XCTAssertEqual(NoteClass(rawValue: 6 - 12), .fSharp)
        XCTAssertEqual(NoteClass(rawValue: 7 - 12), .g)
        XCTAssertEqual(NoteClass(rawValue: 8 - 12), .gSharp)
        XCTAssertEqual(NoteClass(rawValue: 9 - 12), .a)
        XCTAssertEqual(NoteClass(rawValue: 10 - 12), .aSharp)
        XCTAssertEqual(NoteClass(rawValue: 11 - 12), .b)

        // Check that extreme values still work, just for sanity.
        XCTAssertEqual(NoteClass(rawValue: -200), .e)
        XCTAssertEqual(NoteClass(rawValue: 200), .gSharp)
    }

    func testNameInitializationSucceeds() {
        try XCTAssertEqual(NoteClass(name: "C"), .c)
        try XCTAssertEqual(NoteClass(name: "C#"), .cSharp)
        try XCTAssertEqual(NoteClass(name: "C♯"), .cSharp)
        try XCTAssertEqual(NoteClass(name: "Db"), .cSharp)
        try XCTAssertEqual(NoteClass(name: "D♭"), .cSharp)
        try XCTAssertEqual(NoteClass(name: "D"), .d)
        try XCTAssertEqual(NoteClass(name: "D#"), .dSharp)
        try XCTAssertEqual(NoteClass(name: "D♯"), .dSharp)
        try XCTAssertEqual(NoteClass(name: "Eb"), .dSharp)
        try XCTAssertEqual(NoteClass(name: "E♭"), .dSharp)
        try XCTAssertEqual(NoteClass(name: "E"), .e)
        try XCTAssertEqual(NoteClass(name: "F"), .f)
        try XCTAssertEqual(NoteClass(name: "F#"), .fSharp)
        try XCTAssertEqual(NoteClass(name: "F♯"), .fSharp)
        try XCTAssertEqual(NoteClass(name: "Gb"), .fSharp)
        try XCTAssertEqual(NoteClass(name: "G♭"), .fSharp)
        try XCTAssertEqual(NoteClass(name: "G"), .g)
        try XCTAssertEqual(NoteClass(name: "G#"), .gSharp)
        try XCTAssertEqual(NoteClass(name: "G♯"), .gSharp)
        try XCTAssertEqual(NoteClass(name: "Ab"), .gSharp)
        try XCTAssertEqual(NoteClass(name: "A♭"), .gSharp)
        try XCTAssertEqual(NoteClass(name: "A"), .a)
        try XCTAssertEqual(NoteClass(name: "A#"), .aSharp)
        try XCTAssertEqual(NoteClass(name: "A♯"), .aSharp)
        try XCTAssertEqual(NoteClass(name: "Bb"), .aSharp)
        try XCTAssertEqual(NoteClass(name: "B♭"), .aSharp)
        try XCTAssertEqual(NoteClass(name: "B"), .b)
    }

    func testNoteClassMathSucceeds() {}
}
