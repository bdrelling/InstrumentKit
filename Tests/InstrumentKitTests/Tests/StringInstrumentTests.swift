// Copyright © 2022 Brian Drelling. All rights reserved.

@testable import InstrumentKit
import NoteKit
import XCTest

final class StringInstrumentTests: XCTestCase {
    let jsonDecoder = JSONDecoder()
    let jsonEncoder = JSONEncoder()
}

// MARK: - Extensions

extension StringInstrumentTests: SerializationTesting {
    func testEncodingAndDecodingSucceeds() throws {
        try self.reserializeAndCompare(StringInstrument.mockedGuitar)
    }
}
