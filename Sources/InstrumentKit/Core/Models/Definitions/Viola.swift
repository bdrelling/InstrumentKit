// Copyright © 2022 Brian Drelling. All rights reserved.

public extension StringInstrument {
    static let viola: Self = .init(
        localizationKey: "viola",
        numberOfStrings: 4,
        numberOfCourses: 4,
        tunings: Tuning.Viola.self,
        classifications: [.neckedBoxLute],
        countries: [.it],
        year: 1530
    )
}

public extension Tuning {
    enum Viola: Tuning, CaseIterable {
        case standard = "standard: C3 G3 D4 A4"
    }
}
