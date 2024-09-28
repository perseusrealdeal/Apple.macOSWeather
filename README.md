# Snowman — Weather — Status Menus app

> Home-made weather macOS app that runs in the Status Menus (top-right).

[![Actions Status](https://github.com/perseusrealdeal/macOS.Weather/actions/workflows/main.yml/badge.svg)](https://github.com/perseusrealdeal/macOS.Weather/actions)
[![Style](https://github.com/perseusrealdeal/macOS.Weather/actions/workflows/swiftlint.yml/badge.svg)](https://github.com/perseusrealdeal/macOS.Weather/actions/workflows/swiftlint.yml)
[![Version](https://img.shields.io/badge/Version-0.3-green.svg)](/CHANGELOG.md)
[![Platform macOS](https://img.shields.io/badge/Platform-macOS%2010.13+-orange.svg)](https://en.wikipedia.org/wiki/MacOS_version_history)
[![Xcode 14.2](https://img.shields.io/badge/Xcode-14.2+-red.svg)](https://en.wikipedia.org/wiki/Xcode)
[![Swift 5](https://img.shields.io/badge/Swift-5-orange.svg)](https://docs.swift.org/swift-book/RevisionHistory/RevisionHistory.html)
[![SDK UIKit](https://img.shields.io/badge/SDK-UIKit%20-blueviolet.svg)](https://developer.apple.com/documentation/uikit)
[![License](http://img.shields.io/:License-Clear_BSD-blue.svg)](/LICENSE)

## Dependencies

> Swift Package Manager.

[![PerseusDarkMode](http://img.shields.io/:PerseusDarkMode-1.1.5-green.svg)](https://github.com/perseusrealdeal/PerseusDarkMode/tree/1.1.5)
[![PerseusUISystemKit](http://img.shields.io/:PerseusUISystemKit-1.1.4-green.svg)](https://github.com/perseusrealdeal/PerseusUISystemKit/tree/1.1.4)
[![OpenWeatherFreeClient](http://img.shields.io/:OpenWeatherFreeClient-0.1.1-green.svg)](https://github.com/perseusrealdeal/OpenWeatherFreeClient/tree/0.1.1)
[![PerseusGeoLocationKit](http://img.shields.io/:PerseusGeoLocationKit-0.1.0-green.svg)](https://github.com/perseusrealdeal/PerseusGeoLocationKit/releases/tag/0.1.0)

# In brief > Idea to use, the Why

> The Why of this app cannot, and need not, be put into words.

<img src="https://github.com/perseusrealdeal/macOS.Weather/assets/50202963/5be1a549-79a9-4da3-9b13-7220c49c9481" width="800" style="max-width: 100%; display: block; margin-left: auto; margin-right: auto;"/>

## Approbation Matrix

> [A3 Environment](https://docs.google.com/document/d/1K2jOeIknKRRpTEEIPKhxO2H_1eBTof5uTXxyOm5g6nQ/edit?usp=sharing). [CHANGELOG](/CHANGELOG.md) for details.

| macOS       | Version  | Result  | Details |
| ----------- | -------- | :-----: | ------- |
| High Sierra | 10.13.6  | ??      | - |
| Mojave      | 10.14.6  | ??      | - |
| Catalina    | 10.15.7  | ??      | - |
| Big Sur     | 11.7.10  | ??      | - |
| Monterey    | 12.7.6   | ??      | - |
| Ventura     | 13.6.9   | ??      | - |
| Sonoma      | 14.6.1   | ??      | - |
| Sequoia     | 15.nn.nn | ??      | - |

# Installation

The current app project edition is represented in source code only, Developer edition. <br/>
To install the app use the appropriate build-system.

# Build system requirements

- [macOS Monterey 12.7.6+](https://apps.apple.com/by/app/macos-monterey/id1576738294) / [Xcode 14.2+](https://developer.apple.com/services-account/download?path=/Developer_Tools/Xcode_14.2/Xcode_14.2.xip)
- AppKit SDK, macOS 10.13+, Swift 5

# Software requirements

- [Functional specification](/REQUIREMENTS.md)
- Translations [EN](/PerseusMeteo/Configuration/Translations/Translation_en.plist), [RU](/PerseusMeteo/Configuration/Translations/Translation_ru.plist)

# First-party software

- [Perseus Dark Mode](https://github.com/perseusrealdeal/PerseusDarkMode.git) / [1.1.5](https://github.com/perseusrealdeal/perseusdarkmode/releases/tag/1.1.5)
- [Perseus UI System Kit](https://github.com/perseusrealdeal/PerseusUISystemKit.git) / [1.1.4](https://github.com/perseusrealdeal/perseusuisystemkit/releases/tag/1.1.4)
- [Dark Mode switching functions](https://gist.github.com/perseusrealdeal/11b1bab47f13134832b859f49d9af706)
- [OpenWeather Free Client](https://github.com/perseusrealdeal/OpenWeatherFreeClient.git) / [0.1.1](https://github.com/perseusrealdeal/OpenWeatherFreeClient/releases/tag/0.1.1)
- [PerseusGeoLocationKit](https://github.com/perseusrealdeal/PerseusGeoLocationKit.git) / [0.1.0](https://github.com/perseusrealdeal/PerseusGeoLocationKit/releases/tag/0.1.0)
- [PerseusCompassDirection](https://gist.github.com/perseusrealdeal/3b053b2390d704f561ec52c6477b5cf2)
- [PerseusTimeFormat](https://gist.github.com/perseusrealdeal/7aa89d78d9b1c220cc06682be8908a97)
- [PerseusLogger](https://gist.github.com/perseusrealdeal/df456a9825fcface44eca738056eb6d5)

# Gifts

- [CurrentSystemLanguageGift.swift](https://gist.github.com/perseusrealdeal/98b082b136d574dd1b5aa760036dac8b)
- [JsonDataDictionaryGift.swift](https://gist.github.com/perseusrealdeal/918c25633122e64d51f363f00059f6f8)
- [JsonDataPrettyPrintedGift.swift](https://gist.github.com/perseusrealdeal/945c9050cb9f7a19e00853f064acacca)
- [LocalizedInfoPlistGift.swift](/SnowmanTests/GiftsAndHelpers/LocalizedInfoPlistGift.swift)
- [LocalizedExpectationGift.swift](/SnomanTests/GiftsAndHelpers/LocalizedExpectationGift.swift)

# Third-party software

- Style [SwiftLint](https://github.com/realm/SwiftLint)
- Action [mxcl/xcodebuild@v3.3](https://github.com/mxcl/xcodebuild/releases/tag/v3.3.0)
- Action [cirruslabs/swiftlint-action@v1](https://github.com/cirruslabs/swiftlint-action/releases/tag/v1.0.0)

# Points taken into account

- Explicit start point placed in [main.swift](/PerseusMeteo/main.swift)
- Explicit app delegate [TestingAppDelegate.swift](/SnowmanTests/TestingAppDelegate.swift) with test bundle
- Explicit app globals placed in [AppGlobals.swift](/PerseusMeteo/Configuration/AppGlobals.swift)
- Explicit app appearance placed in [AppAppearance.swift](/PerseusMeteo/Configuration/AppAppearance.swift)
- [Test plan](/PerseusTests/TestPlanStarted.xctestplan) configured for EN and RU as well
- SwiftLint shell script as a build phase (preinstallation required)
- Software requirements

# The Clear BSD License

Copyright © 7531 - 7533 Mikhail Zhigulin of Novosibirsk <br/>
Copyright © 7531 - 7533 PerseusRealDeal

- The year starts from the creation of the world in the Star temple according to a Slavic calendar.
- September, the 1st of Slavic year. It means that Sep 1 2024 is the begining of 7533.

[LICENSE](/LICENSE) for details.

# Author

> Mikhail A. Zhigulin of Novosibirsk

# Credits

Project Balance and Control kept by Mikhail Zhigulin<br/>
Source Code written by Mikhail Zhigulin<br/>
Project documented by Mikhail Zhigulin<br/>
Artwork by Mikhail Zhigulin<br/>
English Translation by Mikhail Zhigulin<br/>
Russian Translation by Mikhail Zhigulin<br/>

- Artwork tool: [GIMP](https://www.gimp.org/) / [2.10.36](https://download.gimp.org/gimp/v2.10/osx/) for macOS 10.12 Sierra or newer
- Language support: [Reverso](https://www.reverso.net/) 

# Contributing Translations

Localizations in other languages are very welcome from the app version 1.0.<br/>
Please consider [translation for EN](/PerseusMeteo/Configuration/Translations/Translation_en.plist) as a template.

# Acknowledgements

> During the dev process of the release v0.2 there're several things were also taken into the account.

***Thanks Google Inc.*** for [convertion formulas](https://www.google.com/search?q=temperature+converter) easy seachable in public.</br>
Convertion formulas applied in [MeteoFactsRepresenter.swift](/PerseusMeteo/BusinessData/MeteoFactsRepresenter.swift)

***Thanks Lorenzo Boaro*** for [the Keychain API tutorial](https://www.kodeco.com/9240-keychain-services-api-tutorial-for-passwords-in-swift).<br/>
Keychain API applied in [PerseusDataDefender.swift](/PerseusMeteo/FirstPartyCode/PerseusDataDefender/PerseusDataDefender.swift)

***Thanks Gabriel Theodoropoulos*** for [the macos-status-bar-apps tutorial](https://www.appcoda.com/macos-status-bar-apps/).<br/>
[StatusMenusButtonPresenter.swift](/PerseusMeteo/BusinessLogic/StatusMenusButtonPresenter.swift)

***Thanks Bill Waggoner*** for the SwiftCustomControl [sample](https://github.com/ctgreybeard/SwiftCustomControl).<br/>
Constrainting custom control's content view approach has been applied in a such components like [WeatherView.swift](/PerseusMeteo/BusinessContent/Popover/WeatherView.swift)
