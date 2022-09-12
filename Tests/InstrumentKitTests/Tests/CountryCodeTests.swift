// Copyright © 2022 Brian Drelling. All rights reserved.

import InstrumentKit
import XCTest

final class CountryCodeTests: XCTestCase {
    func testLocalizedNameSucceeds() {
        for country in CountryCode.allCases {
            XCTAssertNotEqual(country.rawValue, country.localizedName())
        }
    }
}
