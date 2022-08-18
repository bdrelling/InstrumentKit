// Copyright © 2022 Brian Drelling. All rights reserved.

public extension StringInstrument {
    static let bass: Self = .init(
        localizationKey: "bass",
        numberOfStrings: 4,
        numberOfCourses: 1,
        tunings: Tuning.Bass.self
    )
}

public extension Tuning {
    enum Bass: Tuning, CaseIterable {
        case standard = "standard: E2 A2 D3 G3"
    }
}
