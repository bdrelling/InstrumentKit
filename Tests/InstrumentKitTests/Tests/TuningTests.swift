// Copyright © 2022 Brian Drelling. All rights reserved.

@testable import InstrumentKit
import NoteKit
import XCTest

final class TuningTests: XCTestCase {
    let jsonDecoder = JSONDecoder()
    let jsonEncoder = JSONEncoder()

    func testGuitarStandardTuning() {
        let tuning: Tuning = .guitar.standard

        let noteClasses = tuning.notes.map(\.noteClass)
        XCTAssertEqual(noteClasses, [
            .e, // E2
            .a, // A2
            .d, // D3
            .g, // G3
            .b, // B3
            .e, // E4
        ])

        let octaves = tuning.notes.map(\.octave.rawValue)
        XCTAssertEqual(octaves, [
            2, // E2
            2, // A2
            3, // D3
            3, // G3
            3, // B3
            4, // E4
        ])

        let frequencies = tuning.notes.map(\.frequency)
        XCTAssertEqual(frequencies, [
            82.41, // E2
            110.0, // A2
            146.83, // D3
            196.0, // G3
            246.94, // B3
            329.63, // E4
        ])
    }
}

// MARK: - Extensions

extension TuningTests: SerializationTesting {
    func testEncodingAndDecodingSucceeds() throws {
        try self.reserializeAndCompare(Tuning.guitar.standard)
    }
}
