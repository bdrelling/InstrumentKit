// Copyright © 2022 Brian Drelling. All rights reserved.

public extension Array where Element: CaseIterable, Element.AllCases.Index == Int {
    static var allCases: Element.AllCases { Element.allCases }
}
