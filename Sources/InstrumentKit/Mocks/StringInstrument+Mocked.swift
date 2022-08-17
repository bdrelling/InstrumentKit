// Copyright © 2022 Brian Drelling. All rights reserved.

public extension StringInstrument {
    static var mocked: Self = .irishBouzouki
}

public extension Array where Element == StringInstrument {
    static var mocked: Self {
        [
            .irishBouzouki,
            .guitar,
            .ukulele,
            .bass,
        ]
    }
}
