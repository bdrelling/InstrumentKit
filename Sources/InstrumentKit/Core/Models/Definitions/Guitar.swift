// Copyright © 2022 Brian Drelling. All rights reserved.

public extension StringInstrument {
    static let guitar: Self = .init(
        localizationKey: "guitar",
        numberOfStrings: 6,
        numberOfCourses: 1,
        tunings: Tuning.Guitar.self
    )
}

public extension Tuning {
    enum Guitar: Tuning, CaseIterable {
        case standard = "standard: E2 A2 D3 G3 B3 E4"
        case dropD = "drop_d: D2 A2 D3 G3 B3 E4"
        case openD = "open_d: D2 A2 D3 F#3 A3 D4"
    }
}
