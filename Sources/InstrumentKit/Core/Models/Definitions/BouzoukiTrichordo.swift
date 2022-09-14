// Copyright © 2022 Brian Drelling. All rights reserved.

public extension StringInstrument {
    static let bouzoukiTrichordo: Self = .init(
        localizationKey: "bouzouki_trichordo",
        numberOfStrings: 6,
        numberOfCourses: 3,
        tunings: Tuning.BouzoukiTrichordo.self,
        classification: .chordophone(.composite(.lute)),
        countries: [.gr],
        year: 1910,
        resources: [
            .init(.wikipedia, url: "https://wikipedia.org/wiki/Bouzouki"),
        ]
    )
}

public extension Tuning {
    enum BouzoukiTrichordo: Tuning, CaseIterable {
        case standard = "standard: D3 D4 A3 A3 D4 D4"
    }
}
