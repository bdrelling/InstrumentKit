// Copyright © 2022 Brian Drelling. All rights reserved.

import NoteKit
import XCTest

final class NoteComparabilityTests: XCTestCase {
    func testNoteComparisonSucceeds() {
        // Notes within the same pitch class
        XCTAssertLessThan(Note.a(-1), Note.a(0))
        XCTAssertLessThan(Note.a(0), Note.a(1))
        XCTAssertLessThan(Note.a(1), Note.a(2))
        XCTAssertLessThan(Note.a(2), Note.a(3))
        XCTAssertLessThan(Note.a(3), Note.a(4))
        XCTAssertLessThan(Note.a(4), Note.a(5))
        XCTAssertLessThan(Note.a(5), Note.a(6))
        XCTAssertLessThan(Note.a(6), Note.a(7))
        XCTAssertLessThan(Note.a(7), Note.a(8))
        XCTAssertLessThan(Note.a(8), Note.a(9))

        // Notes within the same octave
        XCTAssertLessThan(Note.b(3), Note.c(4))
        XCTAssertLessThan(Note.c(4), Note.cSharp(4))
        XCTAssertLessThan(Note.cSharp(4), Note.d(4))
        XCTAssertLessThan(Note.d(4), Note.dSharp(4))
        XCTAssertLessThan(Note.dSharp(4), Note.e(4))
        XCTAssertLessThan(Note.e(4), Note.f(4))
        XCTAssertLessThan(Note.f(4), Note.fSharp(4))
        XCTAssertLessThan(Note.fSharp(4), Note.g(4))
        XCTAssertLessThan(Note.g(4), Note.gSharp(4))
        XCTAssertLessThan(Note.gSharp(4), Note.a(4))
        XCTAssertLessThan(Note.a(4), Note.aSharp(4))
        XCTAssertLessThan(Note.aSharp(4), Note.b(4))
        XCTAssertLessThan(Note.b(4), Note.c(5))
    }
}
