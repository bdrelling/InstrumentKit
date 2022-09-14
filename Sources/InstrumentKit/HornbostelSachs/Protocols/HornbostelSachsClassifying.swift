// Copyright © 2022 Brian Drelling. All rights reserved.

public typealias HornbostelSachsClassifying = RawValueDescribing & Codable & CaseIterable & Comparable

// MARK: - Supporting Types

public protocol RawValueDescribing: CustomStringConvertible {
    var rawValue: String { get }
}

// MARK: - Extensions

public extension RawValueDescribing {
    var description: String {
        self.rawValue
    }
}

public extension Comparable where Self: RawValueDescribing {
    static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}
