// Copyright © 2023 Brian Drelling. All rights reserved.

import NoteKit

public extension Array where Element == Note {
    func closestToFrequency(_ frequency: Float) -> Note? {
        guard frequency > 0 else {
            return nil
        }

        // If there is an exact match, return it immediately.
        if let matchingNote = self.first(where: { $0.frequency == frequency }) {
            return matchingNote
        }

        let lowerNote = self.last { $0.frequency < frequency }
        let higherNote = self.first { $0.frequency > frequency }

        if let lowerNote = lowerNote, let higherNote = higherNote {
            let distanceToLower = frequency - lowerNote.frequency
            let distanceToHigher = higherNote.frequency - frequency

            if distanceToLower < distanceToHigher {
                return lowerNote
            } else {
                return higherNote
            }
        } else if let lowerNote = lowerNote {
            return lowerNote
        } else if let higherNote = higherNote {
            return higherNote
        } else {
            return nil
        }
    }

    func closest(to note: Note?) -> Note? {
        guard let note = note else {
            return nil
        }

        return self.closestToFrequency(note.frequency)
    }
}
