//
//  WeatherViewModel.swift
//  SwiftyWeather
//
//  Created by app-kaihatsusha on 11/01/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//
/* "https://api.open-meteo.com/v1/forecast?latitude=52.05466078996747&longitude=-0.691645319980933&current=precipitation,temperature_2m,weather_code,wind_speed_10m,relative_humidity_2m,apparent_temperature&timezone=Europe%2FLondon&wind_speed_unit=mph" */

import Foundation

@Observable
class WeatherViewModel {
    
    var urlString = "https://api.open-meteo.com/v1/forecast?latitude=52.05466078996747&longitude=-0.691645319980933&current=precipitation,temperature_2m,weather_code,wind_speed_10m,relative_humidity_2m,apparent_temperature&timezone=Europe%2FLondon&wind_speed_unit=mph"
    
    var temperature: Int = 0
    var feelsLike: Int = 0
    var windSpeed: Int = 0
    var weatherCode: Int = 0
    
    var isLoading = false
    
    
    func getData() async {
        
        isLoading = true
        print("🕸️ We are accessing the url \(urlString)")
        // Create URL
        guard let url = URL(string: urlString) else {
            print("😡 ERROR: Could not create a URL from \(urlString)")
            isLoading = false
            return
        }
        
        do {
            // if issues in simulator to get data...
            // let configuration = URLSessionConfiguration.ephemeral
            // let session = URLSession(configuration: configuration)
            // let (data, _) = try await session.data(from: url)
            
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // decode JSON into data structure
            guard let returned = try? JSONDecoder().decode(Weather.self, from: data) else {
                print("😡 JSON ERROR: Could not decode returned JSON data")
                isLoading = false
                return
            }
            
            // Confirm data was decoded:
            print("😎 JSON returned! Timezone: \(returned.timezone_abbreviation)")
            Task { @MainActor in
                self.temperature = Int(returned.current.temperature_2m)
                self.feelsLike = Int(returned.current.apparent_temperature)
                self.windSpeed = Int(returned.current.wind_speed_10m)
                self.weatherCode = returned.current.weather_code
                isLoading = false
            }
        } catch {
            isLoading = false
            print("😡 ERROR: Could not get data from \(urlString) \(error.localizedDescription)")
        }
    }
    
    
}
