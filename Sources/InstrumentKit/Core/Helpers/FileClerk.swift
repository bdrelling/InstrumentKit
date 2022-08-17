// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

enum FileClerk {
    static func fileURL(filename: String, fileExtension: String) throws -> URL {
        guard let fileURL = Bundle.module.url(
            forResource: filename,
            withExtension: fileExtension,
            subdirectory: nil
        ) else {
            throw FileCacheError.fileNotFound
        }

        return fileURL
    }

    static func fileContents(filename: String, fileExtension: String) throws -> String {
        let fileURL = try self.fileURL(filename: filename, fileExtension: fileExtension)
        return try String(contentsOf: fileURL)
    }

    static func fileData(filename: String, fileExtension: String) throws -> Data {
        let fileURL = try self.fileURL(filename: filename, fileExtension: fileExtension)
        return try Data(contentsOf: fileURL)
    }
}

// MARK: - Supporting Types

public enum FileCacheError: LocalizedError {
    case fileNotFound

    public var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "File not found."
        }
    }
}
