# InstrumentKit

[![CI Status](https://github.com/bdrelling/InstrumentKit/actions/workflows/tests.yml/badge.svg)](https://github.com/bdrelling/InstrumentKit/actions/workflows/tests.yml)
[![Latest Release](https://img.shields.io/github/v/tag/bdrelling/InstrumentKit?color=blue&label=latest)](https://github.com/bdrelling/InstrumentKit/releases)
[![Swift Compatibility](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbdrelling%2FInstrumentKit%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/bdrelling/InstrumentKit)
[![Platform Compatibility](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbdrelling%2FInstrumentKit%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/bdrelling/InstrumentKit)
[![License](https://img.shields.io/github/license/bdrelling/InstrumentKit)](https://github.com/bdrelling/InstrumentKit/blob/main/LICENSE)

**InstrumentKit** provides type-safe access to localized musical instruments and their tunings.

- [Work In Progress](#work-in-progress)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [Credits](#credits)
- [License](#license)

## Work In Progress

:warning: This package is very much a work in progress. 

For the time being, this package is focused on collecting, validating, and localizing data for **string instruments only**. Once string instruments feel accurate and stable and the library is extremely tested, the plan will be to add brass, keyboards, percussions, and more.

In addition, the library currently leverages an internal dependency for musical notation (`NoteKit`), but should be backed by the more accurate `[AudioKit/Tonic](https://github.com/AudioKit/Tonic)` as soon as possible.

## Installation

### Swift Package Manager

[Swift Package Manager](https://swift.org/package-manager/) is built into the Swift toolchain and is the preferred way of integrating the SDK.

In addition to being compatible with Apple platforms (iOS, macOS, tvOS, watchOS), the package is also fully compatible with Linux, making it perfect for [Server-side Swift](https://www.swift.org/server/) projects.

For Swift package projects, simply add the following line to your Package.swift file in the dependencies section, replacing `x.x.x` with the latest version:

```swift
dependencies: [
  .package(url: "https://github.com/bdrelling/InstrumentKit", .from: "x.x.x"),
]
```

For app projects, simply follow the [Apple documentation](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app) on adding package dependencies to your app.

## Usage

### Models

```swift
struct StringInstrument {
    let localizationKey: String
    let name: String
    let numberOfStrings: Int
    let numberOfCourses: Int
    let tunings: [Tuning]
}
```

```swift
struct Tuning {
    let localizationKey: String
    let name: String
    let notes: [Note]
}
```

### Examples

Get a specific string instrument.

```swift
let guitar: StringInstrument = .guitar
let ukulele: StringInstrument = .ukulele
let irishBouzouki: StringInstrument = .irishBouzouki
```

Get _all_ string instruments.

```swift
let instruments: [StringInstrument] = StringInstrument.allCases
let instruments: [StringInstrument] = .allCases
```

> _Collections provide an `.allCases` convenience extension, so you don't have to write out the name of the element each time._

Get _all_ tunings for a guitar, using two different methods.

```swift
let guitarTunings: [Tuning] = StringInstrument.guitar.tunings
let guitarTunings: [Tuning] = Tuning.Guitar.allTunings
```

> _`allTunings` is provided as a convenience for `allCases.map(\.rawValue)`._

Get the standard tuning for a guitar.

```swift
let guitarStandard: Tuning = Tuning.Guitar.standard
```

Get _all_ tunings for _all_ string instruments. _(Note: This method is primarily used for testing and validation.)_

```swift
let guitarTunings: [Tuning] = Tuning.allCases
let guitarTunings: [Tuning] = .allCases
```

#### Localization

By default, every `StringInstrument` and `Tuning` will be localized to `Locale.current`. However, you can also localize models on the fly simply by calling `.localized(to:)` with a `Locale`, locale identifier (`String`), or using the `SupportedLanguage` `enum`.

Localize a model.

```swift
let guitarra: StringInstrument = .guitar.localized(to: "es")
let estandard: Tuning = Tuning.Guitar.standard.localized(to: "es")
```

Localize a _collection_ of models.

```swift
let spanishInstruments: [StringInstrument] = .allCases.localized(to: "es")
let spanishGuitarTunings: [Tuning] = Tuning.Guitar.allTunings.localized(to: "es")
```

## Contributing

Discussions, issues, and pull requests are more than welcome, for development, corrections, and/or localizations. 

If you're providing corrections and/or localizations, please provide as many additional sources as you can for validation in order to help ensure we can get the corrections integrated as quickly as possible.

## Credits

Special thanks to [AudioKit](https://github.com/AudioKit/AudioKit) for all of their expertise and support.

## License

**InstrumentKit** is released under the MIT license. See [LICENSE](/LICENSE) for details.
