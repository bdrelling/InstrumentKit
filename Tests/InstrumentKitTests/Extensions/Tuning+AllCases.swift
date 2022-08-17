// Copyright © 2022 Brian Drelling. All rights reserved.

import InstrumentKit

extension Tuning: CaseIterable {
    // Instead of keeping a list in two places, just flatten the list of all tunings across all StringInstruments.
    public static var allCases = StringInstrument.allCases.flatMap(\.tunings)
}
