//
//  Weather.swift
//  7TimerApp
//
//  Created by Buba on 05.11.2022.
//
import Foundation

struct Welcome: Codable {
    let product, welcomeInit: String
    let dataseries: [Datasery]
    
    init(value: [String: Any]) {
        product = value["product"] as? String ?? ""
        welcomeInit = value["init"] as? String ?? ""
        let dataseriesArrayDict = value["dataseries"] as? [[String: Any]] ?? [[:]]
        dataseries = dataseriesArrayDict.map { Datasery(value: $0) }
    }
    
    static func getWelcome(from value: Any) -> Welcome? {
        guard let welcome = value as? [String: Any] else { return nil }
        return Welcome(value: welcome)
    }
}

struct Datasery: Codable {
    let date: Int
    let weather: String
    let temp2M: Temp2M
    let wind10MMax: Int
    
    var windDescription: String {
        "🌬️ \(wind10MMax) m/s"
    }
    
    init(value: [String: Any]) {
        date =  value["date"] as? Int ?? 0
        weather = value["weather"] as? String ?? ""
        let tempDict = value["temp2m"] as? [String: Int] ?? [:]
        temp2M = Temp2M(value: tempDict)
        wind10MMax = value["wind10m_max"] as? Int ?? 0
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
    
    init(value: [String: Int]) {
        max = value["max"] ?? 0
        min = value["min"] ?? 0
    }
}
