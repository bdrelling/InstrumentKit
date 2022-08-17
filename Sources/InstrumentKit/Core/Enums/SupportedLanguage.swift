// Copyright © 2022 Brian Drelling. All rights reserved.

public enum SupportedLanguage: String, Codable, Equatable, CaseIterable {
    case english = "en"
    case spanish = "es"
}

// MARK: - Extensions

extension SupportedLanguage: Identifiable {
    public var id: RawValue {
        self.rawValue
    }
}

extension SupportedLanguage: CustomStringConvertible {
    public var description: String {
        self.rawValue
    }
}

extension SupportedLanguage: LosslessStringConvertible {
    public init?(_ description: String) {
        self.init(rawValue: description)
    }
}
