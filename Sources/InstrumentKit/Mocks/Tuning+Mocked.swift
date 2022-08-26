// Copyright © 2022 Brian Drelling. All rights reserved.

public extension Tuning {
    static var mocked: Self = Tuning.IrishBouzouki.standard.rawValue
}

public extension Array where Element == Tuning {
    static let mocked: Self = [StringInstrument].mocked.flatMap(\.tunings)
}
