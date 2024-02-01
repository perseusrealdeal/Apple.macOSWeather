# Snowman — Weather — Status Menus app

> Home-made weather macOS app that runs in the Status Menus (top-right).

[![Actions Status](https://github.com/perseusrealdeal/Apple.macOSWeather/actions/workflows/main.yml/badge.svg)](https://github.com/perseusrealdeal/Apple.macOSWeather/actions)
[![Version](https://img.shields.io/badge/Version-0.3-green.svg)](/CHANGELOG.md)
[![Platform macOS](https://img.shields.io/badge/Platform-macOS%2010.11+-orange.svg)](https://en.wikipedia.org/wiki/MacOS_version_history)
[![Xcode 10.1](https://img.shields.io/badge/Xcode-10.1+-red.svg)](https://en.wikipedia.org/wiki/Xcode)
[![Swift 4.2](https://img.shields.io/badge/Swift-4.2-orange.svg)](https://docs.swift.org/swift-book/RevisionHistory/RevisionHistory.html)
[![SDK UIKit](https://img.shields.io/badge/SDK-UIKit%20-blueviolet.svg)](https://developer.apple.com/documentation/uikit)
[![License](http://img.shields.io/:The_Clear_BSD_License-blue.svg)](/LICENSE)

> The final usage tests: macOS 10.13.6 and macOS 13.6.4.

## Dependencies

[![PerseusDarkMode](http://img.shields.io/:PerseusDarkMode-1.1.5-green.svg)](https://github.com/perseusrealdeal/PerseusDarkMode/tree/1.1.5)
[![PerseusUISystemKit](http://img.shields.io/:PerseusUISystemKit-1.1.4-green.svg)](https://github.com/perseusrealdeal/PerseusUISystemKit/tree/1.1.4)
[![OpenWeatherFreeClient](http://img.shields.io/:OpenWeatherFreeClient-0.1.1-green.svg)](https://github.com/perseusrealdeal/OpenWeatherFreeClient/tree/0.1.1)

# In brief > Idea to use, the Why

> [CHANGELOG](/CHANGELOG.md) for details. The Why of this app cannot, and need not, be put into words.

<img src="https://github.com/perseusrealdeal/macOS.Weather/assets/50202963/5be1a549-79a9-4da3-9b13-7220c49c9481" width="800" style="max-width: 100%; display: block; margin-left: auto; margin-right: auto;"/>

# Installation

The current app project edition is represented in source code only, Developer edition. <br/>
To install the app use the appropriate build-system.

# Build system requirements

- [macOS 10.13.6+](https://apps.apple.com/us/app/macos-high-sierra/id1246284741?ls=1)
- [Xcode 10.1+](https://stackoverflow.com/questions/10335747/how-to-download-xcode-dmg-or-xip-file)
- Swift 4.2+
- macOS: 10.11+, AppKit SDK

# Software requirements

- [Functional specification](/REQUIREMENTS.md)
- Translations [[EN](/PerseusMeteo/Configuration/Translations/Translation_en.plist), [RU](/PerseusMeteo/Configuration/Translations/Translation_ru.plist)]

# First-party software

- [Perseus Dark Mode](https://github.com/perseusrealdeal/PerseusDarkMode.git) / [1.1.5](https://github.com/perseusrealdeal/perseusdarkmode/releases/tag/1.1.5)
- [Perseus UI System Kit](https://github.com/perseusrealdeal/PerseusUISystemKit.git) / [1.1.4](https://github.com/perseusrealdeal/perseusuisystemkit/releases/tag/1.1.4)
- [Dark Mode switching functions](https://gist.github.com/perseusrealdeal/11b1bab47f13134832b859f49d9af706)
- [OpenWeather Free Client](https://github.com/perseusrealdeal/OpenWeatherFreeClient.git) / [0.1.1](https://github.com/perseusrealdeal/OpenWeatherFreeClient/releases/tag/0.1.1)
- [PerseusCompassDirection](https://gist.github.com/perseusrealdeal/3b053b2390d704f561ec52c6477b5cf2)
- [PerseusTimeFormat](https://gist.github.com/perseusrealdeal/7aa89d78d9b1c220cc06682be8908a97)
- [PerseusLogger](https://gist.github.com/perseusrealdeal/df456a9825fcface44eca738056eb6d5)

# Gifts

- [CurrentSystemLanguageGift.swift](https://gist.github.com/perseusrealdeal/98b082b136d574dd1b5aa760036dac8b)
- [JsonDataDictionaryGift.swift](https://gist.github.com/perseusrealdeal/918c25633122e64d51f363f00059f6f8)
- [JsonDataPrettyPrintedGift.swift](https://gist.github.com/perseusrealdeal/945c9050cb9f7a19e00853f064acacca)

# Third-party software

- [SwiftLint](https://github.com/realm/SwiftLint) / [0.31.0: Busy Laundromat](https://github.com/realm/SwiftLint/releases/tag/0.31.0) for macOS High Sierra

# Points taken into account

- Explicit start point placed in main.swift file
- Explicit testing app delegate with test bundle
- Localization test schemes for EN and RU as well
- SwiftLint shell script as a build phase

# The Clear BSD License

Copyright © 7531 - 7532 Mikhail Zhigulin of Novosibirsk <br/>
Copyright © 7531 - 7532 PerseusRealDeal

- The year starts from the creation of the world in the Star temple according to a Slavic calendar.
- September, the 1st of Slavic year.

[LICENSE](/LICENSE) for details.

# Author

> Mikhail Zhigulin of Novosibirsk

# Credits

Project Balance and Control kept by Mikhail Zhigulin<br/>
Source Code written by Mikhail Zhigulin<br/>
Project documented by Mikhail Zhigulin<br/>
Artwork by Mikhail Zhigulin<br/>
English Localization by Mikhail Zhigulin<br/>
Russian Localization by Mikhail Zhigulin<br/>

- Artwork tool: [GIMP](https://www.gimp.org/) / [2.10.36](https://download.gimp.org/gimp/v2.10/osx/) for macOS 10.12 Sierra or newer
- Language support: [Reverso](https://www.reverso.net/) 

# Contributing Translations

Localizations in other languages are very welcome from the app version 1.0.<br/>
Please consider [customer expectations for EN](/PerseusMeteo/Configuration/Translations/Translation_en.plist) as a template.

# Acknowledgements

> During the dev process of the release v0.2 there're several things were also taken into the account.

Thanks Google Inc. for [convertion formulas](https://www.google.com/search?q=temperature+converter) easy seachable in public.</br>
- Convertion formulas applied in [MeteoFactsRepresenter.swift](/PerseusMeteo/BusinessData/MeteoFactsRepresenter.swift)

Thanks Lorenzo Boaro for [the Keychain API tutorial](https://www.kodeco.com/9240-keychain-services-api-tutorial-for-passwords-in-swift).<br/>
- Keychain API applied in [PerseusDataDefender.swift](/PerseusMeteo/FirstPartyCode/PerseusDataDefender/PerseusDataDefender.swift)

Thanks Gabriel Theodoropoulos for [the macos-status-bar-apps tutorial](https://www.appcoda.com/macos-status-bar-apps/).<br/>
- [StatusMenusButtonPresenter.swift](/PerseusMeteo/BusinessLogic/StatusMenusButtonPresenter.swift)

Thanks Bill Waggoner for the SwiftCustomControl [sample](https://github.com/ctgreybeard/SwiftCustomControl).<br/>
- Ideas applied in LocationView.swift, [WeatherView.swift](/PerseusMeteo/BusinessContent/Popover/WeatherView.swift), and ForecastView.swift
