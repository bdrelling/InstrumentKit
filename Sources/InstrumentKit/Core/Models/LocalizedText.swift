// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

public struct LocalizedText<TableKey> where TableKey: LocalizedTableKey {
    public let key: String
    public let locale: Locale
    public let value: String

    init(
        key: String,
        locale: Locale,
        value: String
    ) {
        self.key = key
        self.locale = locale
        self.value = value
    }

    init(value: String) {
        self.init(key: value, locale: .current, value: value)
    }
}

// MARK: - Supporting Types

public protocol LocalizedTableKey {
    static var tableName: String { get }
}

// MARK: - Extensions

extension LocalizedText: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.key == rhs.key
    }
}

extension LocalizedText: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        self.key = try container.decode(String.self)
        self.value = try container.decode(String.self)
        self.locale = .current
    }
}

extension LocalizedText: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()

        try container.encode(self.key)
    }
}

extension LocalizedText: CustomStringConvertible {
    public var description: String {
        self.value
    }
}

extension LocalizedText: ExpressibleByStringLiteral, ExpressibleByStringInterpolation {
    public init(stringLiteral: String) {
        self.init(key: stringLiteral, locale: .current, value: stringLiteral)
    }
}

extension LocalizedText: Localizable {
    public func localized(to locale: Locale) throws -> Self {
        guard let bundle = Bundle.module.localized(for: locale) else {
            throw LocalizationError.projectNotFound(locale)
        }

        let newValue = bundle.localizedString(forKey: self.key, value: nil, table: TableKey.tableName)

        return .init(key: self.key, locale: locale, value: newValue)
    }
}

// MARK: - Convenience

public extension LocalizedInstrumentName {
    static let guitar: Self = .init(value: "Guitar")
    static let bass: Self = .init(value: "Bass")
    static let ukulele: Self = .init(value: "Ukulele")
}
