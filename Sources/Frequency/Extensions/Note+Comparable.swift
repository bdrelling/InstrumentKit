// Copyright © 2022 Brian Drelling. All rights reserved.

import NoteKit

extension Note: Comparable {
    public static func < (lhs: Note, rhs: Note) -> Bool {
        lhs.frequency < rhs.frequency
    }
}
