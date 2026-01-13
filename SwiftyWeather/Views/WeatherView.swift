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

struct WeatherView: View {
    
    @State private var weatherVM = WeatherViewModel()
    
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
                    Text("\(weatherVM.temperature)°C")
                        .font(.system(size: 150, weight: .thin))
                    Text("Wind \(weatherVM.windSpeed)mph - Feels Like \(weatherVM.feelsLike)°C")
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
                                Text("\(Int(weatherVM.dailyLowTemp[index]))°C /")
                                Text("\(Int(weatherVM.dailyHighTemp[index]))°C")
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
                            
                        } label: {
                            Image(systemName: "gear")
                                
                        }
                        .tint(.white)
                    }
                }
            }
        }
        .task {
            await weatherVM.getData()
        }
    }
}

#Preview {
    WeatherView()
}
