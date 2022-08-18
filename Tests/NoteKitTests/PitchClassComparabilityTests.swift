// Copyright © 2022 Brian Drelling. All rights reserved.

import NoteKit
import XCTest

final class PitchComparabilityTests: XCTestCase {
    func testPitchClassComparisonSucceeds() {
        // Evaluate every pitch class in turn
        XCTAssertLessThan(PitchClass.cSharp, PitchClass.d)
        XCTAssertLessThan(PitchClass.d, PitchClass.dSharp)
        XCTAssertLessThan(PitchClass.dSharp, PitchClass.e)
        XCTAssertLessThan(PitchClass.e, PitchClass.f)
        XCTAssertLessThan(PitchClass.f, PitchClass.fSharp)
        XCTAssertLessThan(PitchClass.fSharp, PitchClass.g)
        XCTAssertLessThan(PitchClass.g, PitchClass.gSharp)
        XCTAssertLessThan(PitchClass.gSharp, PitchClass.a)
        XCTAssertLessThan(PitchClass.a, PitchClass.aSharp)
        XCTAssertLessThan(PitchClass.aSharp, PitchClass.b)

        // Finally, close the loop by comparing B to C#
        XCTAssertGreaterThan(PitchClass.b, PitchClass.cSharp)
    }
}
