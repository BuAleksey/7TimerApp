//
//  ViewController.swift
//  7TimerApp
//
//  Created by Buba on 05.11.2022.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let urlString = "http://www.7timer.info/bin/api.pl?lon=37.618423&lat=55.751244&product=civillight&output=json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        paseJSON()
    }
    
    private func paseJSON() {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let weather = try decoder.decode(Welcome.self, from: data)
                print(weather)
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

