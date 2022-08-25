# InstrumentKit

[![CI Status](https://github.com/bdrelling/InstrumentKit/actions/workflows/tests.yml/badge.svg)](https://github.com/bdrelling/InstrumentKit/actions/workflows/tests.yml)
[![Latest Release](https://img.shields.io/github/v/tag/bdrelling/InstrumentKit?color=blue&label=latest)](https://github.com/bdrelling/InstrumentKit/releases)
[![Swift Compatibility](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbdrelling%2FInstrumentKit%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/bdrelling/InstrumentKit)
[![Platform Compatibility](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbdrelling%2FInstrumentKit%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/bdrelling/InstrumentKit)
[![License](https://img.shields.io/github/license/bdrelling/InstrumentKit)](https://github.com/bdrelling/InstrumentKit/blob/main/LICENSE)

**InstrumentKit** provides type-safe access to localized musical instruments and their tunings.

## Table of Contents

- [Work In Progress](#work-in-progress)
- [Installation](#installation)
- [Usage](#usage)
- [Performance](#performance)
- [Contributing](#contributing)
- [Credits](#credits)
- [License](#license)

## Work In Progress

:warning: This package is very much a work in progress. Here are some immediate next steps.

- For the time being, this package is focused on collecting, validating, and localizing data for **string instruments only**. Once string instruments feel accurate and stable and the library is extremely tested, the plan will be to add brass, keyboards, percussions, and more.
- The library currently leverages an internal dependency for musical notation (`NoteKit`), but should be reaplced by the more accurate and better maintained [`AudioKit/Tonic`](https://github.com/AudioKit/Tonic) as soon as possible. Musical math and theory is difficult, and `InstrumentKit` doesn't want to be in the business of musical math or theory.
- Provide system for ensuring paritally localized models provide English values by default. Currently, they fall back on the `localizationKey`, meaning `"Guitar"` translated to a partial localization without the `"guitar"` key will show up as `"guitar"`, not `"Guitar"`.
  - This already works for _missing_ localizations, but doesn't work for _partial_ localizations.
  - This functionality shouldn't be much more work to achieve without increasing performance.

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

Get a specific tuning for an instrument.

```swift
let guitarStandard: Tuning = Tuning.Guitar.standard.rawValue
```

Get _all_ tunings for an instrument.

```swift
let guitarTunings: [Tuning] = StringInstrument.guitar.tunings
let guitarTunings: [Tuning] = Tuning.Guitar.allTunings
```

> _`allTunings` is provided as a convenience for `allCases.map(\.rawValue)`._

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

### API

Looking for localized instrument and tuning definitions but don't use Swift? No problem!

All instruments and tunings in this package are _also_ available by making API requests to [instruments.fyi](https://instruments.fyi). You can fetch all instruments, specific instruments, tunings, and more.

For more information, see [instruments.fyi](https://github.com/bdrelling/instruments.fyi) or visit [instruments.fyi](https://instruments.fyi).

## Performance

### Localization

`String` localization usage in this module matches standard usage of `Bundle.localizedString(forKey:value:table:)` and `NSLocalizedString`. By initializing these strings through localization tables every time, it ensures that anyone consuming the module will get localization out of the box without any additional work, as they will always localize using `Locale.current`.

### String Initialized Tunings

Seeing the following in `Tuning+Definitions.swift` might make you uncomfortable:

```swift
enum Guitar: Tuning, CaseIterable {
    case standard = "standard: E2 A2 D3 G3 B3 E4"
    case dropD = "drop_d: D2 A2 D3 G3 B3 E4"
    case openD = "open_d: D2 A2 D3 F#3 A3 D4"
}
```

This approach was not taken lightly. Instruments have dozens of commonly applicable tunings, and there are hundreds of instruments. Maintaining a large data set without an easy-to-parse method of analyzing, comparing, and fact-checking that data becomes extremely difficult over time.

`String` parsing of a `Tuning` takes place in the special `init` at the bottom of `Tuning+Definitions.swift`. By making `Tuning` conform to `ExpressibleByStringLiteral`, it allows us to create `CaseIterable` enums that are easy to validate _and_ provide `Tuning` collection and organization functionality out of the box.

The logic is simple and very easy to validate: loop through _every `Tuning` in the project_ and if any of our localization keys in any of our supported languages come back with an error of any sort, numerous unit tests in the project will blow up.

Additionally, these enums are _only initialized once_, meaning that if you keep accessing one of these enums over and over, you can be sure that it won't be re-parsing the `Tuning` definition each time.

If you have an alternative to propose, feel free to open an issue or pull request. Several approaches were considered before landing on `String`-initialized `Tuning`s, but a fresh set of eyes is always helpful. If you have a performant way of defining this data that is type-safe yet provides the same level of convenience and readability (for maintenance and data accuracy), I'm interested!

## Contributing

Discussions, issues, and pull requests are more than welcome, for development, corrections, and/or localizations.

If you're providing corrections and/or localizations, please provide as many additional sources as you can for validation in order to help ensure we can get the corrections integrated as quickly as possible.

## Credits

Special thanks to [AudioKit](https://github.com/AudioKit/AudioKit) for all of their expertise and support.

## License

This project is released under the MIT license. See [LICENSE](/LICENSE) for details.
