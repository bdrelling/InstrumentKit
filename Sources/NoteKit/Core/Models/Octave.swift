// Copyright © 2022 Brian Drelling. All rights reserved.

//// Copyright © 2022 Brian Drelling. All rights reserved.
//
// import Foundation
//
// public struct Octave: RawRepresentable, Codable, Equatable, Hashable {
//    public let rawValue: Int
//    public let name: String?
//
//    public init(_ rawValue: Int, name: String? = nil) {
//        self.rawValue = rawValue
//        self.name = name
//    }
//
//    public init(rawValue: Int) {
//        if let knownOctave = Octave.allCases.first(where: { $0.rawValue == rawValue }) {
//            self = knownOctave
//        } else {
//            self.init(rawValue, name: nil)
//        }
//    }
//
//    public init(rawValue: String) throws {
//        if let octaveValue = Int(rawValue) {
//            self.init(rawValue: octaveValue)
//        } else {
//            throw OctaveError.invalidRawValue(rawValue)
//        }
//    }
// }
//
//// MARK: - Supporting Types
//
// public enum OctaveError: LocalizedError {
//    case invalidRawValue(String)
//
//    public var errorDescription: String? {
//        switch self {
//        case let .invalidRawValue(string):
//            return "Invalid octave raw value '\(string)'."
//        }
//    }
// }
//
//// MARK: - Extensions
//
// public extension Octave {
//    static func + (lhs: Self, rhs: Int) -> Self {
//        .init(rawValue: lhs.rawValue + rhs)
//    }
//
//    static func - (lhs: Self, rhs: Int) -> Self {
//        .init(rawValue: lhs.rawValue - rhs)
//    }
//
//    static func + (lhs: Self, rhs: Self) -> Self {
//        lhs + rhs.rawValue
//    }
//
//    static func - (lhs: Self, rhs: Self) -> Self {
//        lhs - rhs.rawValue
//    }
// }
//
// extension Octave: Identifiable {
//    public var id: RawValue {
//        self.rawValue
//    }
// }
//
// extension Octave: CaseIterable {
//    public static let allCases: [Octave] = [
//        .subContra,
//        .contra,
//        .great,
//        .small,
//        .secondSmall,
//        .thirdSmall,
//        .fourthSmall,
//        .fifthSmall,
//        .sixthSmall,
//    ]
// }
//
// extension Octave: CustomStringConvertible {
//    public var description: String {
//        String(self.rawValue)
//    }
// }
//
//// MARK: - Convenience
//
// extension Octave {
//    static let subContra: Self = .init(0, name: "sub-contra") // A0 is the lowest pitch on a full piano
//    static let contra: Self = .init(1, name: "contra")
//    static let great: Self = .init(2, name: "great")
//    static let small: Self = .init(3, name: "small")
//    static let secondSmall: Self = .init(4, name: "2nd small") // Contains both middle C (C4) and middle a (A4, 440 Hz)
//    static let thirdSmall: Self = .init(5, name: "3rd small")
//    static let fourthSmall: Self = .init(6, name: "4th small")
//    static let fifthSmall: Self = .init(7, name: "5th small")
//    static let sixthSmall: Self = .init(8, name: "6th small") // C8 is the highest pitch on a full piano
// }
//
//// MARK: - Aliases
//
// public extension Octave {
//    static let oneLine: Self = .secondSmall
//    static let twoLine: Self = .thirdSmall
//    static let threeLine: Self = .fourthSmall
//    static let fourLine: Self = .fifthSmall
//    static let fiveLine: Self = .sixthSmall
// }
