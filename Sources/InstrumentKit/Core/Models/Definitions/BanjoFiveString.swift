// Copyright © 2022 Brian Drelling. All rights reserved.

public extension StringInstrument {
    static let banjoFiveString: Self = .init(
        localizationKey: "banjo_five_string",
        numberOfStrings: 5,
        numberOfCourses: 5,
        tunings: Tuning.BanjoFiveString.self,
        classifications: [.spikeBoxLute],
        year: 1770
    )
}

public extension Tuning {
    enum BanjoFiveString: Tuning, CaseIterable {
        case standard = "standard: G4 D3 G3 B3 D4"
        case doubleC = "double_c: G4 C3 G3 B3 D4"
        case gMinor = "g_minor: G4 D3 G3 B3 D4"
        case guitar = "guitar: G4 D3 G3 B3 E4"
        case openC = "open_c: G4 C3 G3 C4 E4"
        case openD = "open_d: F4 D3 F3 A3 D4"
        case sawmill = "sawmill: G4 D3 G4 C4 D4"
    }
}
