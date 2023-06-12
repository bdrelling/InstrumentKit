// Copyright © 2023 Brian Drelling. All rights reserved.

public extension StringInstrument {
    static let banjoFourString: Self = .init(
        localizationKey: "banjo_four_string",
        numberOfStrings: 4,
        numberOfCourses: 4,
        tunings: Tuning.BanjoFourString.self,
        classification: .chordophone(.composite(.lute)),
        year: 1770
    )
}

public extension Tuning {
    enum BanjoFourString: Tuning, CaseIterable {
        case standard = "standard: C3 G3 D3 A4"
        case chicago = "chicago: D3 G3 B3 E4"
        case irishTenor = "irish_tenor: G3 D3 A3 E4"
        case plectrum = "plectrum: C3 G3 B3 D4"
    }
}
