//
//  ViewController.swift
//  WeatherApp
//
//  Created by Venkata on 8/15/23.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    let API_KEY = "ADD_YOUR_KEY"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load last searched city
        if let lastCity = UserDefaults.standard.string(forKey: "lastCity") {
            cityTextField.text = lastCity
            fetchWeather(for: lastCity)
        }
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        if let city = cityTextField.text, !city.isEmpty {
            fetchWeather(for: city)
        }
    }
    
    func fetchWeather(for city: String) {
        let url = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(API_KEY)&units=imperial"
        
        AF.request(url).responseDecodable(of: Weather.self) { response in
            switch response.result {
            case .success(let weather):
                self.updateUI(with: weather)
                UserDefaults.standard.setValue(city, forKey: "lastCity")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func updateUI(with weather: Weather) {
        temperatureLabel.text = "Temp: \(weather.main.temp)°F"
        descriptionLabel.text =  weather.weather.first?.description ?? ""
        
        if let icon = weather.weather.first?.icon {
            let iconURL = URL(string: "https://openweathermap.org/img/w/\(icon).png")
            AF.download(iconURL!).responseData { response in
                if let data = response.value {
                    self.weatherIcon.image = UIImage(data: data)
                }
            }
        }
    }
}

