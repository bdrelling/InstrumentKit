// Copyright © 2022 Brian Drelling. All rights reserved.

import InstrumentKit
import XCTest

final class HornbostelSachsTests: XCTestCase {
    func testRootEnum() {
        XCTAssertEqual(HornbostelSachs.allCases.count, 44)
    }

    func testIdiophones() {
        XCTAssertEqual(HornbostelSachs.Idiophone.allCases.count, 13)

        self.assert(.idiophone(.struck(.direct)), "111")
        self.assert(.idiophone(.struck(.indirect)), "112")
        self.assert(.idiophone(.plucked(.frame)), "121")
        self.assert(.idiophone(.plucked(.comb)), "122")
        self.assert(.idiophone(.plucked(.mixed)), "123")
        self.assert(.idiophone(.friction(.sticks)), "131")
        self.assert(.idiophone(.friction(.plaques)), "132")
        self.assert(.idiophone(.friction(.vessels)), "133")
        self.assert(.idiophone(.friction(.mixed)), "134")
        self.assert(.idiophone(.blown(.sticks)), "141")
        self.assert(.idiophone(.blown(.plaques)), "142")
        self.assert(.idiophone(.blown(.mixed)), "143")
        self.assert(.idiophone(.unclassified), "15")
    }

    func testMembranophones() {
        XCTAssertEqual(HornbostelSachs.Membranophone.allCases.count, 9)

        self.assert(.membranophone(.struck(.direct)), "211")
        self.assert(.membranophone(.struck(.shaken)), "212")
        self.assert(.membranophone(.plucked), "22")
        self.assert(.membranophone(.friction(.stick)), "231")
        self.assert(.membranophone(.friction(.cord)), "232")
        self.assert(.membranophone(.friction(.hand)), "233")
        self.assert(.membranophone(.singing(.free)), "241")
        self.assert(.membranophone(.singing(.tube)), "242")
        self.assert(.membranophone(.unclassified), "25")
    }

    func testChordophones() {
        XCTAssertEqual(HornbostelSachs.Chordophone.allCases.count, 10)

        self.assert(.chordophone(.simple(.bar)), "311")
        self.assert(.chordophone(.simple(.tube)), "312")
        self.assert(.chordophone(.simple(.raft)), "313")
        self.assert(.chordophone(.simple(.board)), "314")
        self.assert(.chordophone(.simple(.trough)), "315")
        self.assert(.chordophone(.simple(.frame)), "316")
        self.assert(.chordophone(.composite(.lute)), "321")
        self.assert(.chordophone(.composite(.harp)), "322")
        self.assert(.chordophone(.composite(.harpLute)), "323")
        self.assert(.chordophone(.unclassified), "33")
    }

    func testAerophones() {
        XCTAssertEqual(HornbostelSachs.Aerophone.allCases.count, 9)

        self.assert(.aerophone(.free(.displacementFree)), "411")
        self.assert(.aerophone(.free(.interruptiveFree)), "412")
        self.assert(.aerophone(.free(.plosive)), "413")
        self.assert(.aerophone(.free(.mixed)), "414")
        self.assert(.aerophone(.nonFree(.edgeBlown)), "421")
        self.assert(.aerophone(.nonFree(.reed)), "422")
        self.assert(.aerophone(.nonFree(.trumpet)), "423")
        self.assert(.aerophone(.nonFree(.mixed)), "424")
        self.assert(.aerophone(.mixed), "43")
    }

    func testElectrophones() {
        XCTAssertEqual(HornbostelSachs.Electrophone.allCases.count, 3)

        self.assert(.electrophone(.electricActuated), "51")
        self.assert(.electrophone(.electricAmplified), "52")
        self.assert(.electrophone(.radioelectric), "53")
    }

    func testComposite() {
        let classification: HornbostelSachs = .composite(.chordophone(.simple(.tube)), .aerophone(.nonFree(.trumpet)))

        self.assert(classification, "312+423")
    }

    func testSorting() {
        // A random collection of classifications across all categories to test sorting.
        // These are purposefully listed as groups in mixed order.
        let classifications: [HornbostelSachs] = [
            .composite( // 311+51
                .chordophone(.simple(.bar)),
                .electrophone(.electricActuated)
            ),

            .idiophone(.plucked(.frame)), // 121
            .idiophone(.unclassified), // 15

            .chordophone(.simple(.trough)), // 315
            .chordophone(.unclassified), // 33

            .membranophone(.struck(.direct)), // 211
            .membranophone(.plucked), // 22
            .membranophone(.friction(.stick)), // 231
            .membranophone(.unclassified), // 25

            .aerophone(.free(.plosive)), // 413
            .aerophone(.mixed), // 43

            .electrophone(.electricAmplified), // 52
        ].sorted()

        XCTAssertEqual(classifications.map(\.rawValue), [
            "121",
            "15",
            "211",
            "22",
            "231",
            "25",
            "315",
            "33",
            "413",
            "43",
            "52",
            "311+51",
        ])
    }
}

// MARK: - Extensions

private extension HornbostelSachsTests {
    func assert(_ classification: HornbostelSachs, _ rawValue: String) {
        XCTAssertEqual(classification.rawValue, rawValue)
        XCTAssertEqual(classification.description, rawValue)
        XCTAssertEqual(String(describing: classification), rawValue)
    }
}
