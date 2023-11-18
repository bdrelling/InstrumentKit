// Copyright © 2023 Brian Drelling. All rights reserved.

import Foundation

extension String {
    private enum MatchError: LocalizedError {
        case invalidMatchRange(NSRange)
        case matchNotFound(pattern: String, text: String)

        var errorDescription: String? {
            switch self {
            case let .invalidMatchRange(range):
                return "Invalid match range '\(range)'."
            case let .matchNotFound(pattern, text):
                return "Match for pattern '\(pattern)' in text '\(text)' not found."
            }
        }
    }

    func match(for pattern: String, range: NSRange? = nil) throws -> String {
        let range = range ?? NSRange(self.startIndex..., in: self)

        guard let firstMatch = try NSRegularExpression(pattern: pattern)
            .matches(in: self, range: range)
            .first else {
            throw MatchError.matchNotFound(pattern: pattern, text: self)
        }

        guard let matchRange = Range(firstMatch.range, in: self) else {
            throw MatchError.invalidMatchRange(firstMatch.range)
        }

        return String(self[matchRange])
    }
}
