//
//  Weather.swift
//  SwiftyWeather
//
//  Created by app-kaihatsusha on 11/01/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import Foundation

struct Weather: Codable {
    
    var latitude: Double
    var longitude: Double
    var timezone: String
    var timezone_abbreviation: String
    var current_units: CurrentUnits
    var current: Current
    var daily_units: DailyUnits
    var daily: Daily
    
    enum CodingKeys: CodingKey {
        case latitude
        case longitude
        case timezone
        case timezone_abbreviation
        case current_units
        case current
        case daily_units
        case daily
    }
}

struct CurrentUnits: Codable {
    var time: String
    var interval: String
    var precipitation: String
    var temperature_2m: String
    var weather_code: String
    var wind_speed_10m: String
    var relative_humidity_2m: String
    var apparent_temperature: String
}

struct Current: Codable {
    var time: String
    var interval: Int
    var precipitation: Double
    var temperature_2m: Double
    var weather_code: Int
    var wind_speed_10m: Double
    var relative_humidity_2m: Int
    var apparent_temperature: Double
}

struct DailyUnits: Codable {
    var time: String
    var weather_code: String
    var sunrise: String
    var sunset: String
    var temperature_2m_max: String
    var temperature_2m_min: String
}

struct Daily: Codable {
    var time: [String]
    var weather_code: [Int]
    var sunrise: [String]
    var sunset: [String]
    var temperature_2m_max: [Double]
    var temperature_2m_min: [Double]
}
