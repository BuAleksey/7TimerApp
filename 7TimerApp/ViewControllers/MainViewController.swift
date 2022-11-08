//
//  ViewController.swift
//  7TimerApp
//
//  Created by Buba on 05.11.2022.
//

import UIKit

final class MainViewController: UIViewController {
    @IBOutlet var weatherImage: UIImageView!
    @IBOutlet var weatherLabel: UILabel!
    @IBOutlet var minTempLabel: UILabel!
    @IBOutlet var maxTempLabel: UILabel!
    @IBOutlet var windLabel: UILabel!
    
    @IBOutlet var weatherStack: UIStackView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creatGradient()
        fetchWeather()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
}

// MARK: - Private funcs
extension MainViewController {
    private func creatGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.white.cgColor, UIColor.blue.cgColor]
        gradient.frame = view.bounds
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    private func fetchWeather() {
        NetworkManager.shared.fetchWeather { [weak self] result in
            switch result {
            case .success(let weather):
                self?.activityIndicator.stopAnimating()
                self?.weatherStack.isHidden = false
                
                self?.weatherImage.image = UIImage(
                    named: weather.dataseries.first?.weather ?? "noImage"
                )
                self?.weatherLabel.text = weather.dataseries.first?.weather
                self?.minTempLabel.text = weather.dataseries.first?.temp2M.minDescription
                self?.maxTempLabel.text = weather.dataseries.first?.temp2M.maxDescription
                self?.windLabel.text = weather.dataseries.first?.windDescription
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
