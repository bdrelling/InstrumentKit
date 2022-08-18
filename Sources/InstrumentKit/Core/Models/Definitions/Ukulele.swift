// Copyright © 2022 Brian Drelling. All rights reserved.

public extension StringInstrument {
    static let ukulele: Self = .init(
        localizationKey: "ukulele",
        numberOfStrings: 4,
        numberOfCourses: 1,
        tunings: Tuning.Ukulele.self
    )
}

public extension Tuning {
    enum Ukulele: Tuning, CaseIterable {
        case standard = "standard: G4 C4 E4 A4"
    }
}
