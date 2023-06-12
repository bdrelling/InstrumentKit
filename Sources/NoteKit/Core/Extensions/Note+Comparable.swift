// Copyright © 2023 Brian Drelling. All rights reserved.

extension Note: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        if lhs.octave == rhs.octave {
            return lhs.pitchClass < rhs.pitchClass
        } else {
            return lhs.octave < rhs.octave
        }
    }
}

public extension Array where Element == Note {
    var lowest: Note? {
        self.min()
    }

    var highest: Note? {
        self.max()
    }
}
