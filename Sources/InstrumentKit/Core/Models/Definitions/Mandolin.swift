// Copyright © 2022 Brian Drelling. All rights reserved.

public extension StringInstrument {
    static let mandolin: Self = .init(
        localizationKey: "mandolin",
        numberOfStrings: 8,
        numberOfCourses: 4,
        tunings: Tuning.Mandolin.self,
        classifications: [
            .neckedBowlLute,
            .neckedBoxLute,
        ],
        countries: [.it],
        year: 1744
    )
}

public extension Tuning {
    enum Mandolin: Tuning, CaseIterable {
        case standard = "standard: G3 G3 D4 D4 A4 A4 E5 E5"
    }
}
