// Copyright © 2022 Brian Drelling. All rights reserved.

import Tonic
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

        // Notes that should be identical
        XCTAssertEqual(Note.c(4), Note.c(4))
        XCTAssertEqual(Note.cSharp(4), Note.cSharp(4))
        XCTAssertEqual(Note.d(4), Note.d(4))
        XCTAssertEqual(Note.dSharp(4), Note.dSharp(4))
        XCTAssertEqual(Note.e(4), Note.e(4))
        XCTAssertEqual(Note.f(4), Note.f(4))
        XCTAssertEqual(Note.fSharp(4), Note.fSharp(4))
        XCTAssertEqual(Note.g(4), Note.g(4))
        XCTAssertEqual(Note.gSharp(4), Note.gSharp(4))
        XCTAssertEqual(Note.a(4), Note.a(4))
        XCTAssertEqual(Note.aSharp(4), Note.aSharp(4))
        XCTAssertEqual(Note.b(4), Note.b(4))
    }
}

// MARK: - Convenience

// TODO: Optimize by making these values static so the math never takes too long. Realistically, though, how often are these used and how long does it take?
public extension Note {
    static func c(_ octave: Int) -> Self {
        .init(.C, octave: octave)
    }

    static func cSharp(_ octave: Int) -> Self {
        .init(.C, accidental: .sharp, octave: octave)
    }

    static func d(_ octave: Int) -> Self {
        .init(.D, octave: octave)
    }

    static func dSharp(_ octave: Int) -> Self {
        .init(.D, accidental: .sharp, octave: octave)
    }

    static func e(_ octave: Int) -> Self {
        .init(.E, octave: octave)
    }

    static func f(_ octave: Int) -> Self {
        .init(.F, octave: octave)
    }

    static func fSharp(_ octave: Int) -> Self {
        .init(.F, accidental: .sharp, octave: octave)
    }

    static func g(_ octave: Int) -> Self {
        .init(.G, octave: octave)
    }

    static func gSharp(_ octave: Int) -> Self {
        .init(.G, accidental: .sharp, octave: octave)
    }

    static func a(_ octave: Int) -> Self {
        .init(.A, octave: octave)
    }

    static func aSharp(_ octave: Int) -> Self {
        .init(.A, accidental: .sharp, octave: octave)
    }

    static func b(_ octave: Int) -> Self {
        .init(.B, octave: octave)
    }
}
