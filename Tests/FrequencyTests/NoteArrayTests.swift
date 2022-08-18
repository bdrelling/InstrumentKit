// Copyright © 2022 Brian Drelling. All rights reserved.

//// Copyright © 2022 Brian Drelling. All rights reserved.
//
// import Frequency
// import XCTest
// import Tonic
//
// final class NoteArrayTests: XCTestCase {
//    func testClosestNoteToFrequencySucceeds() {
//        let notes: [Note] = [.a(3), .a(4), .a(5)]
//
//        // Exact matches
//        XCTAssertEqual(notes.closestToFrequency(220), .a(3))
//        XCTAssertEqual(notes.closestToFrequency(440), .a(4))
//        XCTAssertEqual(notes.closestToFrequency(880), .a(5))
//
//        // Middle frequencies
//        XCTAssertEqual(notes.closestToFrequency(329), .a(3))
//        XCTAssertEqual(notes.closestToFrequency(330), .a(4))
//        XCTAssertEqual(notes.closestToFrequency(659), .a(4))
//        XCTAssertEqual(notes.closestToFrequency(660), .a(5))
//
//        // Other cases
//        XCTAssertEqual(notes.closestToFrequency(-100), nil)
//        XCTAssertEqual(notes.closestToFrequency(-1), nil)
//        XCTAssertEqual(notes.closestToFrequency(0), nil)
//        XCTAssertEqual(notes.closestToFrequency(1), .a(3))
//        XCTAssertEqual(notes.closestToFrequency(1000), .a(5))
//        XCTAssertEqual(notes.closestToFrequency(99999), .a(5))
//    }
//
//    func testClosestNoteToOtherNoteSucceeds() {
//        let notes: [Note] = [.a(3), .a(4), .a(5)]
//
//        // Exact matches
//        XCTAssertEqual(notes.closest(to: .a(3)), .a(3))
//        XCTAssertEqual(notes.closest(to: .a(4)), .a(4))
//        XCTAssertEqual(notes.closest(to: .a(5)), .a(5))
//
//        // Middle frequencies
//        XCTAssertEqual(notes.closest(to: .e(4)), .a(3))
//        XCTAssertEqual(notes.closest(to: .e(5)), .a(4))
//
//        // Other cases
//        XCTAssertEqual(notes.closest(to: .a(-10)), .a(3))
//        XCTAssertEqual(notes.closest(to: .a(-1)), .a(3))
//        XCTAssertEqual(notes.closest(to: .a(0)), .a(3))
//        XCTAssertEqual(notes.closest(to: .b(5)), .a(5))
//        XCTAssertEqual(notes.closest(to: .g(12)), .a(5))
//    }
//
//    func testInvalidStates() {
//        let emptyNotes: [Note] = []
//
//        // Empty arrays return no closest match
//        XCTAssertEqual(emptyNotes.closestToFrequency(440), nil)
//        XCTAssertEqual(emptyNotes.closest(to: .a(4)), nil)
//
//        let notes: [Note] = [.a(3), .a(4), .a(5)]
//
//        // And passing a nil Note returns matches nothing
//        XCTAssertEqual(notes.closest(to: nil), nil)
//    }
// }
