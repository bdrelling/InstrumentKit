// Copyright © 2023 Brian Drelling. All rights reserved.

import Foundation

extension Note: RawRepresentable {
    public var rawValue: String {
        "\(self.pitchClass.name)\(self.octave)"
    }

    public init?(rawValue: String) {
        try? self.init(text: rawValue)
    }

    public init(text: String) throws {
        let semitoneName = try text.match(for: "[A-Za-z#]{1,2}")
        let pitchClass = try PitchClass(name: semitoneName)

        let octaveString = try text.match(for: "[0-9]{1,2}")

        guard let octave = Int(octaveString) else {
            throw NoteError.invalidOctave(octaveString)
        }

        self.init(pitchClass, octave: octave)
    }
}

// MARK: - Supporting Types

public enum NoteError: LocalizedError {
    case invalidOctave(String)

    public var errorDescription: String? {
        switch self {
        case let .invalidOctave(octave):
            return "Invalid octave '\(octave)'."
        }
    }
}
