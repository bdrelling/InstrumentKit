// Copyright © 2022 Brian Drelling. All rights reserved.

public extension StringInstrument {
    static let fiddle: Self = .init(
        localizationKey: "fiddle",
        numberOfStrings: 4,
        numberOfCourses: 4,
        tunings: Tuning.Fiddle.self,
        classification: .chordophone(.composite(.lute))
    )
}

public extension Tuning {
    enum Fiddle: Tuning, CaseIterable {
        case standard = "standard: G3 D4 A4 E5"
        // TODO: Should a "Tenor Violin" be a separate entry?
        case calico = "calico: A3 E4 A4 C5"
        case cajun = "cajun: G3 C4 G4 D5"
        case highBass = "high_bass: A3 D4 A4 E5"
        case open = "open: G3 D4 G4 B4"
        case openD = "open_d: D3 D4 A4 D5"
        case sawmill = "sawmill: G3 D4 G4 D5"
        case tenor = "tenor: G2 D3 A3 E4"
    }
}
