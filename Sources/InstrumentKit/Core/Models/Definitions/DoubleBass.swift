// Copyright © 2022 Brian Drelling. All rights reserved.

public extension StringInstrument {
    static let doubleBass: Self = .init(
        localizationKey: "double_bass",
        numberOfStrings: 4,
        numberOfCourses: 4,
        tunings: Tuning.DoubleBass.self,
        classification: .chordophone(.composite(.lute))
    )
}

public extension Tuning {
    enum DoubleBass: Tuning, CaseIterable {
        case standard = "standard: E1 A1 D2 G2"
        case dropD = "drop_d: D1 A1 D2 G2"
    }
}
