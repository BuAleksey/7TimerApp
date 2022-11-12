//
//  ViewController.swift
//  7TimerApp
//
//  Created by Buba on 05.11.2022.
//

import UIKit
import SpringAnimation

final class MainViewController: UIViewController {
    @IBOutlet var dateLabel: SpringLabel!
    @IBOutlet var weatherImage: SpringImageView!
    @IBOutlet var minTempLabel: SpringLabel!
    @IBOutlet var maxTempLabel: SpringLabel!
    @IBOutlet var windLabel: SpringLabel!
    
    @IBOutlet var weatherStack: UIStackView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var day = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creatGradient()
        fetchWeather()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
    @IBAction func getNextDayWeather(_ sender: SpringButton) {
        weatherStack.isHidden = true
        activityIndicator.startAnimating()
        
        if sender.currentTitle != "Next day" {
            sender.setAnimation()
            sender.setTitle("Next day", for: .normal)
        }
        fetchWeather()
        if day == 6 {
            sender.setAnimation()
            sender.setTitle("Return to start", for: .normal)
        }
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
                
                self?.weatherImage.setAnimation()
                self?.weatherImage.image = UIImage(
                    named: weather.dataseries[self?.day ?? 0].weather
                )

                self?.dateLabel.setAnamation()
                self?.dateLabel.text = String(weather.dataseries[self?.day ?? 0].date)
                self?.minTempLabel.setAnamation()
                self?.minTempLabel.text = weather.dataseries[self?.day ?? 0].temp2M.minDescription
                self?.maxTempLabel.setAnamation()
                self?.maxTempLabel.text = weather.dataseries[self?.day ?? 0].temp2M.maxDescription
                self?.windLabel.setAnamation()
                self?.windLabel.text = weather.dataseries[self?.day ?? 0].windDescription
                
                if self?.day ?? 0 < 6 {
                    self?.day += 1
                } else {
                    self?.day = 0
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
