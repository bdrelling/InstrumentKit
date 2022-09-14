// Copyright © 2022 Brian Drelling. All rights reserved.

public extension StringInstrument {
    // TODO: Add "concert harp" alias
    static let pedalHarp: Self = .init(
        localizationKey: "pedal_harp",
        numberOfStrings: 47,
        numberOfCourses: 47,
        tunings: Tuning.PedalHarp.self,
        classification: .chordophone(.composite(.harp)),
        countries: [.fr]
    )
}

public extension Tuning {
    enum PedalHarp: Tuning, CaseIterable {
        case standard = "standard: C1 D1 E1 F1 G1 A1 B1 C2 D2 E2 F2 G2 A2 B2 C3 D3 E3 F3 G3 A3 B3 C4 D4 E4 F4 G4 A4 B4 C5 D5 E5 F5 G5 A5 B5 C6 D6 E6 F6 G6 A6 B6 C7 D7 E7 F7 G7"
    }
}
