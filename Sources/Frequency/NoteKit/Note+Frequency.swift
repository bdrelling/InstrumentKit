// Copyright © 2023 Brian Drelling. All rights reserved.

import NoteKit

public extension Note {
    var frequency: Float {
        NoteMath.frequencyForNote(self)
    }
}
