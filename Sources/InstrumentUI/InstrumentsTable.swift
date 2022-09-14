// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation
import InstrumentKit
import SwiftUI

@available(iOS 16.0, macOS 12.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
struct InstrumentsTable: View {
    private let instruments: [StringInstrument]

    var body: some View {
        MyTable(self.instruments) { instrument in
            Text(instrument.name)
            VStack {
                ForEach(instrument.classifications) { classification in
                    Text(classification.rawValue)
                }
            }
        }
//        Table(self.instruments) {
//            TableColumn("Name") { instrument in
//                Text(instrument.name)
//            }
//            TableColumn("Classifications") { instrument in
//                VStack {
//                    ForEach(instrument.classifications) { classification in
//                        Text(classification.rawValue)
//                    }
//                }
//            }
//        }
    }

    init(instruments: [StringInstrument] = StringInstrument.allCases) {
        self.instruments = instruments
    }
}

@available(iOS 15.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
struct MyTable<Item, Content>: View where Item: Identifiable, Content: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    let items: [Item]
    let content: (Item) -> Content

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, alignment: .leading) {
                ForEach(self.items) { item in
                    self.content(item)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }

    init(_ items: [Item], @ViewBuilder _ content: @escaping (Item) -> Content) {
        self.items = items
        self.content = content
    }
}

// MARK: - Previews

@available(iOS 16.0, macOS 12.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
struct InstrumentsTable_Previews: PreviewProvider {
    static var previews: some View {
        InstrumentsTable()
            .previewLayout(.sizeThatFits)
    }
}
