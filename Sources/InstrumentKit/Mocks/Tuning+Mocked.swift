// Copyright © 2022 Brian Drelling. All rights reserved.

public extension Tuning {
    static var mocked: Self = .IrishBouzouki.standard.rawValue
}

public extension Array where Element == Tuning {
    static var mocked: Self {
        [
            .IrishBouzouki.standard.rawValue,
            .Guitar.standard.rawValue,
            .Bass.standard.rawValue,
            .Ukulele.standard.rawValue,
        ]
    }
}
