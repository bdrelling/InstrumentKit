// Copyright © 2022 Brian Drelling. All rights reserved.

public extension StringInstrument {
    static let violin: Self = .alias(
        of: .fiddle,
        localizationKey: "violin",
        countries: [.it],
        year: 1530
    )
}

public extension Tuning {
    typealias Violin = Fiddle
}
