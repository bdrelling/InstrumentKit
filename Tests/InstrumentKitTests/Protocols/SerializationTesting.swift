// Copyright © 2022 Brian Drelling. All rights reserved.

import XCTest

protocol SerializationTesting: XCTestCase {
    var jsonDecoder: JSONDecoder { get }
    var jsonEncoder: JSONEncoder { get }
}

extension SerializationTesting {
    /// Encodes and decodes the value to test that serialization works properly.
    func reserialize<Value>(_ value: Value) throws -> Value where Value: Codable {
        // Encode the tuning into data.
        let data = try self.jsonEncoder.encode(value)

        // Immediately attempt to decode and return it.
        return try self.jsonDecoder.decode(Value.self, from: data)
    }

    /// Encodes and decodes the value, then compares the initial value to the decoded value.
    func reserializeAndCompare<Value>(_ value: Value) throws where Value: Codable, Value: Equatable {
        // Encode and decode the value to test serialization.
        let redecodedValue = try self.reserialize(value)

        // Both models should be equal.
        XCTAssertEqual(value, redecodedValue)
    }
}
