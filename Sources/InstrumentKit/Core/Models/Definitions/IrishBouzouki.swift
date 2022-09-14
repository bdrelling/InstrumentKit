// Copyright © 2022 Brian Drelling. All rights reserved.

public extension StringInstrument {
    static let irishBouzouki: Self = .init(
        localizationKey: "irish_bouzouki",
        numberOfStrings: 8,
        numberOfCourses: 4,
        tunings: Tuning.IrishBouzouki.self,
        classification: .chordophone(.composite(.lute)),
        countries: [.ie],
        year: 1969,
        resources: [
            .init(.wikipedia, url: "https://wikipedia.org/wiki/Irish_bouzouki"),
        ]
    )
}

public extension Tuning {
    enum IrishBouzouki: Tuning, CaseIterable {
        case standard = "standard: G3 G2 D3 D3 A3 A3 D4 D4"
        case common = "common: G3 G2 D4 D3 A3 A3 E4 E4"
        case mandolin = "mandolin: G2 G2 D3 D3 A3 A3 E4 E4"
        case openD = "open_d: A2 A2 D3 D3 A3 A3 D4 D4"
        case openG = "open_g: G2 G2 D3 D3 G3 G3 D4 D4"
    }
}
