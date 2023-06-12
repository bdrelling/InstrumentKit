// Copyright © 2023 Brian Drelling. All rights reserved.

public extension StringInstrument {
    static var mocked: Self = .irishBouzouki
}

public extension Array where Element == StringInstrument {
    static let mocked: Self = [
        .irishBouzouki,
        .bass,
        .ukulele,
    ]
}
