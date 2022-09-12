// Copyright © 2022 Brian Drelling. All rights reserved.

public extension StringInstrument {
    static let bouzoukiTetrachordo: Self = .init(
        localizationKey: "bouzouki_tetrachordo",
        numberOfStrings: 8,
        numberOfCourses: 4,
        tunings: Tuning.BouzoukiTetrachordo.self,
        classifications: [.neckedBoxLute],
        countries: [.gr],
        year: 1910,
        resources: [
            .init(.wikipedia, url: "https://wikipedia.org/wiki/Bouzouki"),
        ]
    )
}

public extension Tuning {
    enum BouzoukiTetrachordo: Tuning, CaseIterable {
        case standard = "standard: C3 C4 F3 F4 A3 A3 D4 D4"
    }
}
