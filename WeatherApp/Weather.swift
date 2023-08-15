//
//  Weather.swift
//  WeatherApp
//
//  Created by Venkata on 8/15/23.
//

import Foundation

struct Weather: Decodable {
    let name: String
    let main: Main
    let weather: [WeatherDetail]
}

struct Main: Decodable {
    let temp: Double
}

struct WeatherDetail: Decodable {
    let description: String
    let icon: String
}
