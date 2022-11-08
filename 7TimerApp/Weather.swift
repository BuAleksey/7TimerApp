//
//  Weather.swift
//  7TimerApp
//
//  Created by Buba on 05.11.2022.
//

struct Welcome: Codable {
    let product, welcomeInit: String
    let dataseries: [Datasery]

    enum CodingKeys: String, CodingKey {
        case product
        case welcomeInit = "init"
        case dataseries
    }
}

struct Datasery: Codable {
    let date: Int
    let weather: String
    let temp2M: Temp2M
    let wind10MMax: Int
    
    var windDescription: String {
        "Wind \(wind10MMax) m/s"
    }

    enum CodingKeys: String, CodingKey {
        case date, weather
        case temp2M = "temp2m"
        case wind10MMax = "wind10m_max"
    }
}

struct Temp2M: Codable {
    let max, min: Int
    
    var minDescription: String {
        "Min \(min) °C"
    }
    var maxDescription: String {
        "Max \(max) °C"
    }
}
