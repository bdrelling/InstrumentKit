// Copyright © 2022 Brian Drelling. All rights reserved.

public extension StringInstrument {
    static let bass: Self = .init(
        localizationKey: "bass",
        numberOfStrings: 4,
        numberOfCourses: 4,
        tunings: Tuning.Bass.self,
        classifications: [.neckedBoxLute],
        countries: [.us],
        year: 1930
    )
}

public extension Tuning {
    enum Bass: Tuning, CaseIterable {
        case standard = "standard: E1 A1 D2 G2"
    }
}
