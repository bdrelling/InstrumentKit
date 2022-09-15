// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

public extension Array where Element == StringInstrument {
    var stats: Stats {
        .init(instruments: self)
    }

    struct Stats {
        public let numberOfInstruments: Int
        public let numberOfTunings: Int
        public let numberOfCountries: Int
        public let countries: [CountryCode]

        init(instruments: [StringInstrument]) {
            self.numberOfInstruments = instruments.count
            self.numberOfTunings = Set(instruments.flatMap(\.tunings)).count

            self.countries = .init(Set(instruments.flatMap(\.countries)))
            self.numberOfCountries = self.countries.count
        }
    }
}
