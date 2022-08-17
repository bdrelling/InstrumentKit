// Copyright © 2022 Brian Drelling. All rights reserved.

public extension Tuning {
    static var mocked: Self = .irishBouzouki.standard
}

public extension Array where Element == Tuning {
    static var mocked: Self {
        [
            .irishBouzouki.standard,
            .guitar.standard,
            .bass.standard,
            .ukulele.standard,
        ]
    }
}
