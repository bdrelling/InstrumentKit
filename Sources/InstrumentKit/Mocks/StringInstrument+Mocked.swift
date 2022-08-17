// Copyright © 2022 Brian Drelling. All rights reserved.

public extension StringInstrument {
    static var mocked: Self = .mockedIrishBouzouki

    static var mockedIrishBouzouki: Self {
        .init(
            name: "Irish Bouzouki",
            numberOfStrings: 4,
            numberOfCourses: 1
        )
    }

    static var mockedGuitar: Self {
        .init(
            name: "Guitar",
            numberOfStrings: 6,
            numberOfCourses: 1
        )
    }

    static var mockedUkulele: Self {
        .init(
            name: "Ukulele",
            numberOfStrings: 4,
            numberOfCourses: 1
        )
    }
}

public extension Array where Element == StringInstrument {
    static var mocked: Self {
        [
            .mockedIrishBouzouki,
            .mockedGuitar,
            .mockedUkulele,
        ]
    }
}
