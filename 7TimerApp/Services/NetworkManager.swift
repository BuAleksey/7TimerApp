//
//  NetworkManager.swift
//  7TimerApp
//
//  Created by Buba on 08.11.2022.
//

import Foundation

enum NetworkErrors: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private let urlString = "http://www.7timer.info/bin/api.pl?lon=37.618423&lat=55.751244&product=civillight&output=json"
    
    private init() {}
    
    func fetchWeather(complition: @escaping(Result<Welcome, NetworkErrors>) -> Void) {
        guard let url = URL(string: urlString) else {
            complition(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                complition(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let weather = try decoder.decode(Welcome.self, from: data)
                DispatchQueue.main.async {
                    complition(.success(weather))
                }
            } catch let error {
                complition(.failure(.decodingError))
                print(error.localizedDescription)
            }
        }.resume()
    }
}
