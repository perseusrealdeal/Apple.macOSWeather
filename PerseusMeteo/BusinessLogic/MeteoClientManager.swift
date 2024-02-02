//
//  MeteoClientManager.swift
//  PerseusMeteo
//
//  Created by Mikhail Zhigulin in 7532.
//
//  Copyright © 7532 Mikhail Zhigulin of Novosibirsk
//  Copyright © 7532 PerseusRealDeal
//
//  The year starts from the creation of the world in the Star temple
//  according to a Slavic calendar. September, the 1st of Slavic year.
//
//  See LICENSE for details. All rights reserved.
//

import Foundation

public class MeteoClientManager {

    private var theAppPresenter: StatusMenusButtonPresenter?
    private var isReadyToCall = false

    private var serviceOpenWeatherMap = OpenWeatherFreeClient()

    init(presenter: StatusMenusButtonPresenter) {
        theAppPresenter = presenter
        setupCallerLogic(for: serviceOpenWeatherMap)
    }

    public func setupCallerLogic(for caller: OpenWeatherFreeClient) {

        log.message("[\(type(of: self))].\(#function)")

        caller.onDataGiven = { result in

            if let presenter = self.theAppPresenter {
                DispatchQueue.main.async {
                    presenter.screenPopover.stopAnimationProgressIndicator(nil)
                }
            }

            switch result {
            case .success(let weatherData):
                self.weatherOnDataGivenHandler(weatherData)

            case .failure(let error):
                switch error {
                case .failedRequest(let message):
                    log.message(message, .error)
                    self.isReadyToCall = true

                default:
                    log.message("[\(type(of: self))].\(#function) \(error)", .error)
                    self.isReadyToCall = true
                }
            }
        }

        isReadyToCall = true
    }

    public func fetchMeteoData(_ sender: Any?) {

        guard isReadyToCall else {
            log.message("[\(type(of: self))].\(#function) \(isReadyToCall)", .error)
            return
        }

        guard let presenter = theAppPresenter else {
            log.message("[\(type(of: self))].\(#function) presenter is nil.", .error)
            return
        }

        guard let location = AppGlobals.appDelegate?.location else {
            log.message("[\(type(of: self))].\(#function) location is nil.", .error)
            return
        }

        isReadyToCall = false

        let lat = location.latitude.cut(.two).description
        let lon = location.longitude.cut(.two).description
        let lang = globals.languageSwitcher.currentAppLanguage

        let key = AppGlobals.appKeyOpenWeather.isEmpty ? AppOptions.OpenWeatherAPIOption ?? ""
        : AppGlobals.appKeyOpenWeather

        let callDetails = OpenWeatherDetails(appid: key,
                                             format: .currentWeather,
                                             lat: lat,
                                             lon: lon,
                                             units: .imperial,
                                             lang: .init(rawValue: lang),
                                             mode: .json)

        log.message(callDetails.urlString)

        do {
            presenter.screenPopover.startAnimationProgressIndicator(sender)
            try serviceOpenWeatherMap.call(with: callDetails)
        } catch {

            log.message("[\(type(of: self))].\(#function) \(error)", .error)

            presenter.screenPopover.stopAnimationProgressIndicator(sender)
            isReadyToCall = true
        }
    }
    // MARK: - Event handlers

    private func weatherOnDataGivenHandler(_ data: Data) {

        log.message("[\(type(of: self))].\(#function)")

        guard
            let presenter = theAppPresenter
        else {
            log.message("[\(type(of: self))].\(#function)", .error)
            return
        }

        DispatchQueue.main.async {

            AppGlobals.appDelegate?.weather = data
            presenter.screenPopover.reloadData()

            self.isReadyToCall = true
        }
    }
}
