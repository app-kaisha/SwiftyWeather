//
//  WeatherView.swift
//  SwiftyWeather
//
//  Created by app-kaihatsusha on 11/01/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//
//
//

import SwiftUI
import SwiftData

struct WeatherView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query var preferences: [Preference]
    
    @State private var weatherVM = WeatherViewModel()
    @State private var isSettingsPresented = false
    @State private var preference = Preference()
    
    private var temp: String {
        if preference.degreeUnitShowing {
            switch preference.selectedUnit {
            case .imperial:
                return "F"
            case .metric:
                return "C"
            }
        } else {
            return ""
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.cyan.opacity(0.75)
                    .ignoresSafeArea()
                VStack {
                    Image(systemName: getWeatherIcon(for: weatherVM.weatherCode))
                        .resizable()
                        .scaledToFit()
                        .symbolRenderingMode(.multicolor)
                        .padding(.horizontal)
                    Text(getWeatherDescription(for: weatherVM.weatherCode))
                        .font(.largeTitle)
                    Text("\(weatherVM.temperature)°\(temp)")
                        .font(.system(size: 150, weight: .thin))
                    Text("Wind \(weatherVM.windSpeed)\(preference.selectedUnit == .imperial ? "mph" : "kmh") - Feels Like \(weatherVM.feelsLike)°\(temp)")
                        .font(.title2)
                        .padding(.bottom)
                    
                    List {
                        ForEach(0..<weatherVM.date.count, id:\.self) { index in
                            HStack(alignment: .top) {
                                Image(systemName: getWeatherIcon(for: weatherVM.dailyWeatherCode[index]))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                //Text(weatherVM.date[index])
                                //Text(getWeekDay(value: index+1))
                                Text(getWeekDayFromDateString(dateString: weatherVM.date[index]))
                                
                                Spacer()
                                Text("\(Int(weatherVM.dailyLowTemp[index]))°\(temp) /")
                                Text("\(Int(weatherVM.dailyHighTemp[index]))°\(temp)")
                                    .font(.title).bold()
                                
                            }
                        }
                        .font(.title2)
                        .foregroundStyle(.white)
                        .listRowBackground(Color.clear)
                        
                    }
                    .listStyle(.plain)
                    
                }
                .foregroundStyle(.white)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            isSettingsPresented.toggle()
                        } label: {
                            Image(systemName: "gear")
                        }
                        .tint(.white)
                    }
                }
            }
            
        }
        .onChange(of: preferences) {
            Task {
                await callWeatherAPI()
            }
            
        }
        .task {
            await callWeatherAPI()
        }
        .fullScreenCover(isPresented: $isSettingsPresented) {
            PreferenceView()
        }
    }
    
    private func callWeatherAPI() async {
        if !preferences.isEmpty {
            preference = preferences.first!
            weatherVM.updateAPIString(lat: preference.latString, lon: preference.longString, units: preference.selectedUnit)
        }
        await weatherVM.getData()
    }
}

#Preview {
    WeatherView()
        
}
