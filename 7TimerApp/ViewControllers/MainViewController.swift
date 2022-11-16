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
    
    var weather: Welcome?
    var day = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creatGradient()
        fetchWeather()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
    @IBAction func getNextDayWeather(_ sender: SpringButton) {
        if sender.currentTitle != "Next day" {
            sender.setAnimation()
            sender.setTitle("Next day", for: .normal)
        }
        
        if day == 6 {
            sender.setAnimation()
            sender.setTitle("Return to start", for: .normal)
        }
        
        updateScreen(with: weather)
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
                self?.weather = weather
                self?.updateScreen(with: self?.weather)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func updateScreen(with weather: Welcome?) {
        activityIndicator.stopAnimating()
        weatherStack.isHidden = false
        
        guard let weather = weather else { return }
        weatherImage.setAnimation()
        weatherImage.image = UIImage(
            named: weather.dataseries[day].weather
        )
        
        dateLabel.setAnamation()
        guard let date = setupDateFormat(from: String(weather.dataseries[day].date)) else { return }
        let dateString = setupStrigDateFormat(from: date)
        dateLabel.text = dateString
        
        minTempLabel.setAnamation()
        minTempLabel.text = weather.dataseries[day].temp2M.minDescription
        
        maxTempLabel.setAnamation()
        maxTempLabel.text = weather.dataseries[day].temp2M.maxDescription
        
        windLabel.setAnamation()
        windLabel.text = weather.dataseries[day].windDescription
        
        if day < 6 {
            day += 1
        } else {
            day = 0
        }
    }
    
    private func setupDateFormat(from date: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter.date(from: date)
    }
    
    private func setupStrigDateFormat(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("EEEE, MMM d, yyyy")
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
}
