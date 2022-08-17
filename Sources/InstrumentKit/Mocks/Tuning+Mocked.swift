// Copyright © 2022 Brian Drelling. All rights reserved.

public extension Tuning {
    static var mocked: Self = .mockedIrishBouzoukiStandard

    static var mockedIrishBouzoukiStandard: Self {
        .init(
            name: "Standard",
            notes: .g(2), .d(3), .a(3), .d(4)
        )
    }

    static var mockedGuitarStandard: Self {
        .init(
            name: "Standard",
            notes: .e(2), .a(2), .d(3), .g(3), .b(3), .e(4)
        )
    }

    static var mockedUkuleleStandard: Self {
        .init(
            name: "Standard",
            notes: .g(4), .c(4), .e(4), .a(4)
        )
    }
}

public extension Array where Element == Tuning {
    static var mocked: Self {
        [
            .mockedGuitarStandard,
            .mockedUkuleleStandard,
        ]
    }
}
