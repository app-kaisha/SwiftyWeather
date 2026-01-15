//
//  PreferenceView.swift
//  SwiftyWeather
//
//  Created by app-kaihatsusha on 13/01/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import SwiftUI
import SwiftData

struct PreferenceView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Query var preferences: [Preference]
    
    @State private var locationNameIs = ""
    @State private var latString = ""
    @State private var longString = ""
    @State private var degreeUnitShowing = true
    @State private var selectedUnit: UnitSystem = .metric
    
    var degreeUnit: String {
        
        if degreeUnitShowing {
            return selectedUnit == .imperial ? "F" : "C"
        }
        
        return ""
    }
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading) {
                TextField("location", text: $locationNameIs)
                    .textFieldStyle(.roundedBorder)
                    .font(.title)
                    .padding(.bottom)
                
                Group {
                    Text("Latitude")
                        .bold()
                    TextField("latitude", text: $latString)
                        .textFieldStyle(.roundedBorder)
                    Text("Longitude")
                        .bold()
                    TextField("longitude", text: $longString)
                        .textFieldStyle(.roundedBorder)
                        .padding(.bottom)
                }
                .font(.title2)
                
                HStack {
                    Text("Units:")
                        .bold()
                    Spacer()
                    Picker("", selection: $selectedUnit) {
                        ForEach(UnitSystem.allCases, id: \.self) { unit in
                            Text(unit.rawValue.capitalized)
                        }
                    }
                    
                }
                .padding(.bottom)
                .font(.title2)
                Toggle("Show F/C after temp value", isOn: $degreeUnitShowing)
                    .font(.title2)
                //VStack(alignment: .center) {
                //Text("42°\(degreeUnitShowing == false ? "" : selectedUnit == .metric ? "C" : "F")")
                //.frame(maxWidth: .infinity)
                //}
                HStack {
                    Spacer()
                    Text("42°\(degreeUnit)")
                        .font(.system(size: 150, weight: .thin))
                    Spacer()
                }
                
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        // only save one so delete all existing
                        if !preferences.isEmpty {
                            preferences.forEach { modelContext.delete($0)}
                        }
                        let preference = Preference(
                            locationName: locationNameIs,
                            latString: latString,
                            longString: longString,
                            selectedUnit: selectedUnit,
                            degreeUnitShowing: degreeUnitShowing
                        )
                        
                        modelContext.insert(preference)
                        
                        guard let _ = try? modelContext.save() else {
                            print("😡 ERROR: Save on PreferenceView did not work!")
                            return
                        }
                        
                        dismiss()
                    }
                }
            }
            .padding()
        }
        .task {
            guard !preferences.isEmpty else { return }
            
            let preference = preferences.first!
            locationNameIs = preference.locationName
            latString = preference.latString
            longString = preference.longString
            selectedUnit = preference.selectedUnit
            degreeUnitShowing = preference.degreeUnitShowing
            
        }
        
    }
}

#Preview {
    PreferenceView()
        .modelContainer(Preference.preview)
}
