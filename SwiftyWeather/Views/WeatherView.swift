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
    var body: some View {
        NavigationStack {
            ZStack {
                Color.cyan.opacity(0.75)
                    .ignoresSafeArea()
                VStack {
                    Image(systemName: "cloud.sun.rain.fill")
                        .resizable()
                        .scaledToFit()
                        .symbolRenderingMode(.multicolor)
                        .padding(.horizontal)
                    Text("Wild Weather")
                        .font(.largeTitle)
                    Text("42°C")
                        .font(.system(size: 150, weight: .thin))
                    Text("Wind 10mph - Feels Like 36°C")
                        .font(.title2)
                        .padding(.bottom)
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
    }
}

#Preview {
    WeatherView()
}
