// Copyright © 2022 Brian Drelling. All rights reserved.

public extension NoteClass {
    func displayName(for displayMode: NoteDisplayMode) -> String {
        guard self.isSharp else {
            return self.name
        }

        switch displayMode {
        case .sharps:
            return self.displayNameWithSharps
        case .flats:
            return self.displayNameWithFlats
        }
    }
}

extension NoteClass {
    var displayNameWithFlats: String {
        self.nameWithFlats.replacingOccurrences(of: "b", with: "♭")
    }

    var displayNameWithSharps: String {
        self.name.replacingOccurrences(of: "#", with: "♯")
    }
}
