//
//  WeatherStatus.swift
//  WeatherStat
//
//  Created by Le Thanh Hai on 11/23/17.
//  Copyright © 2017 haile. All rights reserved.
//

import UIKit

class Weather {
    
    
    
}

class WeatherStatus {
    
    var time: Date? = nil
    var summary: String?
    var icon: String?
    var temperature: Double?
    var apparentTemperature: Double?
    var humidity: Double?
    var pressure: Double?
    var windSpeed: Double?
    var uvIndex: Double?
    
    
    
    init(dictionary: NSDictionary) {
        if let timeValue = dictionary.object(forKey: "time") as? Double {
            self.time = Date(timeIntervalSince1970: timeValue)
        }
        self.summary = dictionary.object(forKey: "summary") as? String
        self.icon = dictionary.object(forKey: "icon") as? String
        self.temperature = dictionary.object(forKey: "temperature") as? Double
        self.apparentTemperature = dictionary.object(forKey: "apparentTemperature") as? Double
        self.humidity = dictionary.object(forKey: "humidity") as? Double
        self.pressure = dictionary.object(forKey: "pressure") as? Double
        self.windSpeed = dictionary.object(forKey: "windSpeed") as? Double
        self.uvIndex = dictionary.object(forKey: "uvIndex") as? Double
    }
}

