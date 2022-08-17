// Copyright © 2022 Brian Drelling. All rights reserved.

public extension Tuning {
    // The type names in this extension are lowercased for the sake of creating a prettier outward interface.
    enum bass {
        public static let standard: Tuning = .standard(.e(2), .a(2), .d(3), .g(3))
    }

    enum guitar {
        public static let standard: Tuning = .standard(.e(2), .a(2), .d(3), .g(3), .b(3), .e(4))
    }

    enum irishBouzouki {
        public static let standard: Tuning = .standard(.g(2), .d(3), .a(3), .d(4))
    }

    enum ukulele {
        public static let standard: Tuning = .standard(.g(4), .c(4), .e(4), .a(4))
    }
}
