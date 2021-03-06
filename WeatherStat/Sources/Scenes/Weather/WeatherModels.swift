//
//  WeatherModels.swift
//  WeatherStat
//
//  Created by Le Thanh Hai on 11/23/17.
//  Copyright (c) 2017 haile. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

struct WeatherRequest {
    let latitude: CGFloat
    let longitude: CGFloat
}

struct WeatherResponse {
    let weather: Weather
}

class WeatherViewModel {
    var models: [SectionModel]
    init(models: [SectionModel]) {
        self.models = models
    }
}

struct SectionModel {
    var header: AnyObject?
    var items: [AnyObject]
}
