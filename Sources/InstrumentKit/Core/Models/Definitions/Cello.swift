// Copyright © 2022 Brian Drelling. All rights reserved.

public extension StringInstrument {
    static let cello: Self = .init(
        localizationKey: "cello",
        numberOfStrings: 4,
        numberOfCourses: 4,
        tunings: Tuning.Cello.self,
        classifications: [.neckedBoxLute]
    )
}

public extension Tuning {
    enum Cello: Tuning, CaseIterable {
        case standard = "standard: C2 G2 D3 A3"
    }
}
