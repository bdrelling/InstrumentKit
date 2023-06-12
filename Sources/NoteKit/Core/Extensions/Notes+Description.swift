// Copyright © 2023 Brian Drelling. All rights reserved.

public extension Array where Element == Note {
    var description: String {
        self.map(\.description).joined(separator: " ")
    }

    init(rawValue: String) {
        self = rawValue
            .split(separator: " ")
            .compactMap { Note(rawValue: String($0)) }
    }
}
