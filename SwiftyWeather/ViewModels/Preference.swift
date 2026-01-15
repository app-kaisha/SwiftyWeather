//
//  Preference.swift
//  SwiftyWeather
//
//  Created by app-kaihatsusha on 13/01/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import Foundation
import SwiftData

@MainActor
@Model
class Preference {
    
    var locationName = ""
    var latString = ""
    var longString = ""
    var selectedUnit = UnitSystem.metric
    var degreeUnitShowing = true
    
    init(locationName: String = "", latString: String = "", longString: String = "", selectedUnit: UnitSystem = .metric, degreeUnitShowing: Bool = true) {
        self.locationName = locationName
        self.latString = latString
        self.longString = longString
        self.selectedUnit = selectedUnit
        self.degreeUnitShowing = degreeUnitShowing
    }
    
    static var preview: ModelContainer {
        let container = try! ModelContainer(for: Preference.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        container.mainContext.insert(Preference(locationName: "Dublin", latString: "53.33880", longString: "6.2551", selectedUnit: .metric, degreeUnitShowing: true))
        
        return container
    }
}
