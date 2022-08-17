// Copyright © 2022 Brian Drelling. All rights reserved.

import Yams

final class ModelCache<Model> where Model: Decodable {
    private let filename: String
    private let fileExtension: String
    private let yamlDecoder = YAMLDecoder()

    var models: [Model]?

    init(filename: String, fileExtension: String) {
        self.filename = filename
        self.fileExtension = fileExtension
    }

    func get() throws -> [Model] {
        if let models = self.models {
            return models
        }

        let fileData = try FileClerk.fileData(filename: self.filename, fileExtension: self.fileExtension)
        self.models = try self.yamlDecoder.decode([Model].self, from: fileData)

        return self.models ?? []
    }
}

// MARK: - Convenience

typealias StringInstrumentCache = ModelCache<StringInstrument>
typealias TuningCache = ModelCache<TuningCollection>
