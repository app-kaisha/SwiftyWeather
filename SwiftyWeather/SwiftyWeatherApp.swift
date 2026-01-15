//
//  SwiftyWeatherApp.swift
//  SwiftyWeather
//
//  Created by app-kaihatsusha on 11/01/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import SwiftUI
import SwiftData

@main
struct SwiftyWeatherApp: App {
    var body: some Scene {
        WindowGroup {
            WeatherView()
                .modelContainer(for: Preference.self)
                .onAppear {
                    Thread.sleep(forTimeInterval: 2)
                }
        }
        
    }
    
    init()
    {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
