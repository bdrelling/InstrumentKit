// Copyright © 2022 Brian Drelling. All rights reserved.

public extension HornbostelSachs {
    /// An instrument that produces sound by electricity.
    ///
    /// This category was only added in 1940 and is still disputed, as the first and second categories are simply
    /// electric versions of their acoustic counterparts. As such, these two categories are mostly ignored.
    ///
    /// For more information, see:
    ///   - [Electrophone](https://en.wikipedia.org/wiki/Electrophone)
    ///   - [Hornbostel-Sachs - Electrophones](https://en.wikipedia.org/wiki/Hornbostel–Sachs#Electrophones_(5))
    ///   - [List of Electrophones](https://en.wikipedia.org/wiki/List_of_electrophones_by_Hornbostel–Sachs_number)
    enum Electrophone: String, Codable, CaseIterable {
        /// Electrophones that are acoustic but electrically actuated..
        case electricActuated = "1"
        /// Electrophones that are acoustic but electrically amplified.
        case electricAmplified = "2"
        /// Electrophones which make sound primarily by way of electrically driven oscillators, such as theremins or synthesizers.
        case radioelectric = "3"
    }
}
