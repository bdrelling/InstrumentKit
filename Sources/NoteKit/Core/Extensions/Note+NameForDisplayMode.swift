// Copyright © 2022 Brian Drelling. All rights reserved.

public extension Note {
    func displayName(for displayMode: NoteDisplayMode) -> String {
        guard self.noteClass.isSharp else {
            return self.rawValue
        }

        return "\(self.noteClass.displayName(for: displayMode))\(self.octave)"
    }
}

#if canImport(SwiftUI)

import SwiftUI

@available(iOS 15, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
private extension Note {
    func attributedName(
        for displayMode: NoteDisplayMode,
        fontSize: CGFloat
    ) -> AttributedString {
        let nameWithSharps = AttributedString(self.noteClass.displayName(for: .sharps))

        var octaveAttributes = AttributeContainer()
        octaveAttributes.font = Font.system(size: fontSize * 0.65)
        octaveAttributes.baselineOffset = fontSize * -0.25
        let octave = AttributedString("\(self.octave)", attributes: octaveAttributes)

        // Unless our noteClass is sharp, we don't need to continue.
        guard self.noteClass.isSharp else {
            return nameWithSharps + octave
        }

        switch displayMode {
        case .sharps:
            return nameWithSharps + octave
        case .flats:
            let nameWithFlats = AttributedString(self.noteClass.displayName(for: .flats))
            return nameWithFlats + octave
        }
    }
}

#endif
