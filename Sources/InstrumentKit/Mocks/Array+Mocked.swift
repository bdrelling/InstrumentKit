// Copyright © 2022 Brian Drelling. All rights reserved.

public extension Array where Element: CaseIterable, Element.AllCases.Index == Int {
    /// A mocked array of this element for. Defaults to a count of 20.
    static func mocked(_ count: Int = 20) -> Self {
        guard count > 0 else {
            return []
        }

        let allCases = Self.allCases
        let max = Swift.min(allCases.count, count)

        return .init(allCases[0 ..< max])
    }
}
