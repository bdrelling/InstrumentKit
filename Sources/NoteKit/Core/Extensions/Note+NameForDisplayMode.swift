// Copyright © 2023 Brian Drelling. All rights reserved.

public extension Note {
    var displayName: String {
        self.displayName(for: .default)
    }

    func displayName(for displayMode: NoteDisplayMode) -> String {
        guard self.pitchClass.isSharp else {
            return self.rawValue
        }

        return "\(self.pitchClass.displayName(for: displayMode))\(self.octave)"
    }
}

#if swift(>=5.5) && canImport(SwiftUI)

import SwiftUI

@available(iOS 15, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
private extension Note {
    func attributedName(
        for displayMode: NoteDisplayMode,
        fontSize: CGFloat
    ) -> AttributedString {
        let nameWithSharps = AttributedString(self.pitchClass.displayName(for: .sharps))

        var octaveAttributes = AttributeContainer()
        octaveAttributes.font = Font.system(size: fontSize * 0.65)
        octaveAttributes.baselineOffset = fontSize * -0.25
        let octave = AttributedString("\(self.octave)", attributes: octaveAttributes)

        // Unless our pitchClass is sharp, we don't need to continue.
        guard self.pitchClass.isSharp else {
            return nameWithSharps + octave
        }

        switch displayMode {
        case .sharps:
            return nameWithSharps + octave
        case .flats:
            let nameWithFlats = AttributedString(self.pitchClass.displayName(for: .flats))
            return nameWithFlats + octave
        }
    }
}

#endif
