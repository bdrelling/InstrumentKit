// Copyright © 2022 Brian Drelling. All rights reserved.

import Tonic

public extension Note {
    var frequency: Float {
        NoteMath.frequencyForNote(self)
    }
}
