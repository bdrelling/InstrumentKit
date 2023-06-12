// Copyright © 2023 Brian Drelling. All rights reserved.

import Foundation

public struct Note: Codable, Equatable, Hashable {
    public let pitchClass: PitchClass
    public let octave: Int

    public init(_ pitchClass: PitchClass, octave: Int) {
        self.pitchClass = pitchClass
        self.octave = octave
    }
}

// MARK: - Extensions

public extension Note {
    func octaveLower() -> Self {
        .init(self.pitchClass, octave: self.octave - 1)
    }

    func octaveHigher() -> Self {
        .init(self.pitchClass, octave: self.octave + 1)
    }

    func halfStepLower() -> Self {
        .init(self.pitchClass - 1, octave: self.octave)
    }

    func halfStepHigher() -> Self {
        .init(self.pitchClass + 1, octave: self.octave)
    }

    func wholeStepLower() -> Self {
        .init(self.pitchClass - 2, octave: self.octave)
    }

    func wholeStepHigher() -> Self {
        .init(self.pitchClass + 2, octave: self.octave)
    }
}

extension Note: Identifiable {
    public var id: RawValue {
        self.rawValue
    }
}

extension Note: CustomStringConvertible {
    public var description: String {
        "\(self.pitchClass.name)\(self.octave)"
    }
}
