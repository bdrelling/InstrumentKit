// Copyright © 2022 Brian Drelling. All rights reserved.

public extension StringInstrument {
    static let doubleBassFiveString: Self = .init(
        localizationKey: "double_bass_five_string",
        numberOfStrings: 5,
        numberOfCourses: 5,
        tunings: Tuning.DoubleBassFiveString.self,
        classification: .chordophone(.composite(.lute))
    )
}

public extension Tuning {
    enum DoubleBassFiveString: Tuning, CaseIterable {
        case standard = "standard: C1 E1 A1 D2 G2"
    }
}
