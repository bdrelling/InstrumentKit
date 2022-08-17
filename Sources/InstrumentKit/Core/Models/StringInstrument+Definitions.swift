// Copyright © 2022 Brian Drelling. All rights reserved.

public extension StringInstrument {
    static let bass: Self = .init(
        localizationKey: "bass",
        numberOfStrings: 4,
        numberOfCourses: 1,
        tunings: Tuning.Bass.allTunings
    )

    static let guitar: Self = .init(
        localizationKey: "guitar",
        numberOfStrings: 6,
        numberOfCourses: 1,
        tunings: Tuning.Guitar.allTunings
    )

    static let irishBouzouki: Self = .init(
        localizationKey: "irish_bouzouki",
        numberOfStrings: 4,
        numberOfCourses: 1,
        tunings: Tuning.IrishBouzouki.allTunings
    )

    static let ukulele: Self = .init(
        localizationKey: "ukulele",
        numberOfStrings: 4,
        numberOfCourses: 1,
        tunings: Tuning.Ukulele.allTunings
    )
}

// MARK: - Extensions

// TODO: Have this generated by sourcery.
extension StringInstrument: CaseIterable {
    public static var allCases: [Self] = [
        .bass,
        .guitar,
        .irishBouzouki,
        .ukulele,
    ]
}
