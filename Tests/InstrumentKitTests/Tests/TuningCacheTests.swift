// Copyright © 2022 Brian Drelling. All rights reserved.

@testable import InstrumentKit
import XCTest

final class TuningCacheTests: XCTestCase {
    func testInitializationFromNameSucceeds() throws {
        let tuning = try Tuning(instrument: .guitar, tuning: .standard)

        XCTAssertEqual(tuning.name, .standard)
        XCTAssertEqual(tuning.notes, [.e(2), .a(2), .d(3), .g(3), .b(3), .e(4)])

        // Ensure the cache is no longer nil.
        XCTAssertNotNil(Tuning.cache.models)
    }
}
