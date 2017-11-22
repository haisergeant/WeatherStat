//
//  WeatherStatus.swift
//  WeatherStat
//
//  Created by Le Thanh Hai on 11/23/17.
//  Copyright © 2017 haile. All rights reserved.
//

import UIKit

class Weather {
    
    var latitude: Double?
    var longitude: Double?
    var current: WeatherStatus?
    var hourStatus: [WeatherStatus]?
    var dayStatus: [DayStatus]?
    
    init(dictionary: NSDictionary) {
        self.latitude = dictionary.object(forKey: "latitude") as? Double
        self.longitude = dictionary.object(forKey: "longitude") as? Double
        
        self.current = WeatherStatus(dictionary: dictionary.object(forKey: "currently") as? NSDictionary)
        
        // Hourly
        let hourDict = dictionary.object(forKey: "hourly") as? NSDictionary
        self.hourStatus = [WeatherStatus]()
        if let hourList = hourDict?.object(forKey: "data") as? [NSDictionary] {
            hourList.forEach { dictionary in
                if let item = WeatherStatus(dictionary: dictionary) {
                    self.hourStatus?.append(item)
                }
            }
        }
        
        // Daily
        let dayDict = dictionary.object(forKey: "daily") as? NSDictionary
        self.dayStatus = [DayStatus]()
        if let dayList = dayDict?.object(forKey: "data") as? [NSDictionary] {
            dayList.forEach { dictionary in
                if let item = DayStatus(dictionary: dictionary) {
                    self.dayStatus?.append(item)
                }
            }
        }
    }
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
    
    init?(dictionary: NSDictionary?) {
        guard let dictionary = dictionary else {
            return nil
        }
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

class DayStatus {
    var time: Date? = nil
    var summary: String?
    var icon: String?
    var humidity: Double?
    var pressure: Double?
    var windSpeed: Double?
    var uvIndex: Double?
    
    var sunriseTime: Date?
    var sunsetTime: Date?
    var temperatureHigh: Double?
    var temperatureHighTime: Date?
    var temperatureLow: Double?
    var temperatureLowTime: Date?
    
    init?(dictionary: NSDictionary?) {
        guard let dictionary = dictionary else {
            return nil
        }
        if let timeValue = dictionary.object(forKey: "time") as? Double {
            self.time = Date(timeIntervalSince1970: timeValue)
        }
        self.summary = dictionary.object(forKey: "summary") as? String
        self.icon = dictionary.object(forKey: "icon") as? String
        self.humidity = dictionary.object(forKey: "humidity") as? Double
        self.pressure = dictionary.object(forKey: "pressure") as? Double
        self.windSpeed = dictionary.object(forKey: "windSpeed") as? Double
        self.uvIndex = dictionary.object(forKey: "uvIndex") as? Double
        
        if let timeValue = dictionary.object(forKey: "sunriseTime") as? Double {
            self.sunriseTime = Date(timeIntervalSince1970: timeValue)
        }
        
        if let timeValue = dictionary.object(forKey: "sunsetTime") as? Double {
            self.sunsetTime = Date(timeIntervalSince1970: timeValue)
        }
        
        self.temperatureHigh = dictionary.object(forKey: "temperatureHigh") as? Double
        if let timeValue = dictionary.object(forKey: "temperatureHighTime") as? Double {
            self.temperatureHighTime = Date(timeIntervalSince1970: timeValue)
        }
        
        self.temperatureLow = dictionary.object(forKey: "temperatureLow") as? Double
        if let timeValue = dictionary.object(forKey: "temperatureLowTime") as? Double {
            self.temperatureLowTime = Date(timeIntervalSince1970: timeValue)
        }
    }
}
