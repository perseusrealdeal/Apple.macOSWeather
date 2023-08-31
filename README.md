# Weather — macOS App — Xcode 10.1+

> Home-made weather macOS app with the custom item in the Status menus (top-right).

[![Actions Status](https://github.com/perseusrealdeal/Apple.macOSWeather/actions/workflows/main.yml/badge.svg)](https://github.com/perseusrealdeal/Apple.macOSWeather/actions)
![Version](https://img.shields.io/badge/Version-0.2-green.svg)
[![Platform macOS](https://img.shields.io/badge/Platform-macOS%2010.11+-orange.svg)](https://en.wikipedia.org/wiki/MacOS_version_history)
[![Xcode 10.1](https://img.shields.io/badge/Xcode-10.1+-red.svg)](https://en.wikipedia.org/wiki/Xcode)
[![Swift 4.2](https://img.shields.io/badge/Swift-4.2-orange.svg)](https://docs.swift.org/swift-book/RevisionHistory/RevisionHistory.html)
[![SDK UIKit](https://img.shields.io/badge/SDK-UIKit%20-blueviolet.svg)](https://developer.apple.com/documentation/uikit)
[![License](http://img.shields.io/:The_Clear_BSD_License-blue.svg)](/LICENSE)

## Dependencies

[![PerseusDarkMode](http://img.shields.io/:PerseusDarkMode-1.1.5-green.svg)](https://github.com/perseusrealdeal/PerseusDarkMode/tree/1.1.5)
[![PerseusUISystemKit](http://img.shields.io/:PerseusUISystemKit-1.1.4-green.svg)](https://github.com/perseusrealdeal/PerseusUISystemKit/tree/1.1.4)
[![OpenWeatherFreeClient](http://img.shields.io/:OpenWeatherFreeClient-0.1.1-green.svg)](https://github.com/perseusrealdeal/OpenWeatherFreeClient/tree/0.1.1)

# In brief > Idea to use

> TODO: app's desc

> TODO: preview

# Installation

> TODO: the app's installation desc

# Build system requirements

- [macOS 10.13.6+](https://apps.apple.com/us/app/macos-high-sierra/id1246284741?ls=1)
- [Xcode 10.1+](https://stackoverflow.com/questions/10335747/how-to-download-xcode-dmg-or-xip-file)
- Swift 4.2+
- macOS: 10.11+, AppKit SDK

# Software requirements

- [Functional requirements](/PerseusWeather/Requirements/Requirements)
- Localization requirements [[EN](/PerseusWeather/Requirements/Localization_en.plist), [RU](/PerseusWeather/Requirements/Localization_ru.plist)]

# First-party software

- [Perseus Dark Mode](https://github.com/perseusrealdeal/PerseusDarkMode.git) / [1.1.5](https://github.com/perseusrealdeal/perseusdarkmode/releases/tag/1.1.5)
- [Perseus UI System Kit](https://github.com/perseusrealdeal/PerseusUISystemKit.git) / [1.1.4](https://github.com/perseusrealdeal/perseusuisystemkit/releases/tag/1.1.4)
- [Dark Mode switching functions](https://gist.github.com/perseusrealdeal/11b1bab47f13134832b859f49d9af706)
- [OpenWeather Free Client](https://github.com/perseusrealdeal/OpenWeatherFreeClient.git) / [0.1.1](https://github.com/perseusrealdeal/OpenWeatherFreeClient/releases/tag/0.1.1)
- [PerseusLogger](https://gist.github.com/perseusrealdeal/df456a9825fcface44eca738056eb6d5)

# Third-party software

- [SwiftLint](https://github.com/realm/SwiftLint) / [0.31.0: Busy Laundromat](https://github.com/realm/SwiftLint/releases/tag/0.31.0) for macOS High Sierra

# Points taken into account

- Explicit start point placed in main.swift file
- Explicit app delegate with test bundle
- Top menu with changing title of menu item "Preferences... / Settings..."
- Preferences\Settings screen with Dark Mode option
- Localization test schemes for EN and RU as well
- SwiftLint shell script as a build phase
- Light-weight Logger
- Software requirements templates

# The Clear BSD License

Copyright © 7531 - 7532 Mikhail Zhigulin of Novosibirsk

Copyright © 7531 - 7532 PerseusRealDeal

- The year starts from the creation of the world according to a Slavic calendar.
- September, the 1st of Slavic year.

[LICENSE](/LICENSE) for details.

# Author

> Mikhail A. Zhigulin of Novosibirsk
