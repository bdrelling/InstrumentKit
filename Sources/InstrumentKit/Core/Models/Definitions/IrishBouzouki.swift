// Copyright © 2022 Brian Drelling. All rights reserved.

public extension StringInstrument {
    static let irishBouzouki: Self = .init(
        localizationKey: "irish_bouzouki",
        numberOfStrings: 4,
        numberOfCourses: 1,
        tunings: Tuning.IrishBouzouki.self
    )
}

public extension Tuning {
    enum IrishBouzouki: Tuning, CaseIterable {
        case standard = "standard: G2 D3 A3 D4"
    }
}
