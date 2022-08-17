// Copyright © 2022 Brian Drelling. All rights reserved.

@testable import InstrumentKit
import XCTest

final class InstrumentCacheTests: XCTestCase {
    func testInitializationFromNameSucceeds() throws {
        let instrument = try StringInstrument(name: .guitar)

        XCTAssertEqual(instrument.name, .guitar)
        XCTAssertEqual(instrument.numberOfStrings, 6)
        XCTAssertEqual(instrument.numberOfCourses, 1)

        // Ensure the cache is no longer nil.
        XCTAssertNotNil(StringInstrument.cache.models)
    }
}
