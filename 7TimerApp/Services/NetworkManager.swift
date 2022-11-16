//
//  NetworkManager.swift
//  7TimerApp
//
//  Created by Buba on 08.11.2022.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private let urlString = "http://www.7timer.info/bin/api.pl?lon=37.618423&lat=55.751244&product=civillight&output=json"
    
    private init() {}
    
    func fetchWeather(complition: @escaping(Result<Welcome, AFError>) -> Void) {
        AF.request(urlString)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    guard let welcome = Welcome.getWelcome(from: value) else { return }
                    complition(.success(welcome))
                case .failure(let error):
                    complition(.failure(error))
                    print(error)
                }
            }
    }
}
