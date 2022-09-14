// Copyright © 2022 Brian Drelling. All rights reserved.

public extension StringInstrument {
    static let guitar: Self = .init(
        localizationKey: "guitar",
        numberOfStrings: 6,
        numberOfCourses: 6,
        tunings: Tuning.Guitar.self,
        classification: .chordophone(.composite(.lute))
    )
}

public extension Tuning {
    enum Guitar: Tuning, CaseIterable {
        case standard = "standard: E2 A2 D3 G3 B3 E4"
        case dropD = "drop_d: D2 A2 D3 G3 B3 E4"
        case openD = "open_d: D2 A2 D3 F#3 A3 D4"
        case openG = "open_g: D2 G2 D2 G2 B3 D4"
        case openA = "open_a: E2 A2 E3 A3 C#4 E4"
        case lute = "lute: E2 A2 D3 F♯3 B3 E4"
        case irish = "irish: D2 A2 D3 G3 A3 D4"
        case nashville = "nashville: E3 A3 D4 G4 B3 E4"
    }
}
