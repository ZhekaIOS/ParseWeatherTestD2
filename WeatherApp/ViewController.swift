//
//  ViewController.swift
//  WeatherApp
//
//  Created by Евгений Ковалевский on 10.01.2018.
//  Copyright © 2018 Евгений Ковалевский. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, UIPickerViewDelegate , UIPickerViewDataSource {
    let city = ["Kyiv" ,"Lviv", "Mykolaiv","Poltava","Rivne" ,"Ternopil"]
    var lat = 5.2
    var long = 4.3
    @IBAction func swipeDownGesture(_ sender: UISwipeGestureRecognizer) {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: Selector(("respondToSwipeGesture:")))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeDown)
        getCurrentWeatherData()
    }
    @IBOutlet weak var lonLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var latLabel: UILabel!
    @IBAction func tapHidden(_ sender: UITapGestureRecognizer) {
        pickerView.isHidden = true
        }
    @IBOutlet weak var cityLabel: UILabel!
    @IBAction func buttonPush(_ sender: UIButton) {
        if pickerView.isHidden == true {
            pickerView.isHidden = false
        }
    }
    
    @IBOutlet weak var precipTypeLabeell: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var appearentTemperatureLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBAction func refreshButtonTapped(_ sender: UIButton) {
        toggleActivityIndicator(on : true)
        getCurrentWeatherData()}
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let locationManager = CLLocationManager()
    
    func toggleActivityIndicator(on : Bool) { //если индикатор включен, прячем индикатор
        refreshButton.isHidden = on
        if on {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    lazy var weatherManager = APIWeatherManager(apiKey: "cae748679b0e46339d386adad9a83d65")
    var coordinate = Coordinates(latitude : 50.462295 , longitude : 30.347265)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self // пишу, что буду использовать методы локейшнменеджерделегейт
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //точность нашего положения
        locationManager.requestAlwaysAuthorization()//разрешение на местоположение при запуске
        locationManager.startUpdatingLocation()
        getCurrentWeatherData()
        pickerView.isHidden = true
        pickerView.delegate = self
        pickerView.dataSource = self
        city.sorted()
    }
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return city.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return city[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        city.sorted()
        cityLabel.text = city[row]
    

        if city[row] == "Kyiv"{
            coordinate.latitude = 42.3601
            coordinate.longitude = -71.0589
           
            latLabel.text = String(coordinate.latitude)
            lonLabel.text = String(coordinate.longitude)
        }
        if city[row] == "Lviv"{
            coordinate.latitude = 37.8267
            coordinate.longitude = -122.4233
            latLabel.text = String(coordinate.latitude)
            lonLabel.text = String(coordinate.longitude)
        }
        if city[row] == "Mykolaiv"{
            coordinate.latitude = 27.8267
            coordinate.longitude = -142.4233
            latLabel.text = String(coordinate.latitude)
            lonLabel.text = String(coordinate.longitude)
        }
        if city[row] == "Poltava"{
            coordinate.latitude = 34.8267
            coordinate.longitude = -122.4233
            latLabel.text = String(coordinate.latitude)
            lonLabel.text = String(coordinate.longitude)
        }
        if city[row] == "Rivne"{
            coordinate.latitude = 37.8267
            coordinate.longitude = -122.4233
            latLabel.text = String(coordinate.latitude)
            lonLabel.text = String(coordinate.longitude)
        }
        if city[row] == "Ternopil"{
            coordinate.latitude = 47.8267
            coordinate.longitude = -162.4233
            latLabel.text = String(coordinate.latitude)
            lonLabel.text = String(coordinate.longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.last! as CLLocation
        print ("my location lattitude : \(userLocation.coordinate.latitude) , and longitude : \(userLocation.coordinate.longitude)")
    }
    
    func getCurrentWeatherData() { //фукнция, которая определяет текушую погоду
        weatherManager.fetchCurrentWeatherWith(coordinates: coordinate) { (result) in
            self.toggleActivityIndicator(on : false)
            switch result {
            case .Success(let currentWeather ) :
                self.updateUiWith(currentWeather: currentWeather)
            case .Failure(let error as NSError ) :
                let alertController = UIAlertController(title: "Unable to get data", message: "\(error.localizedDescription)", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            default : break
            }
        }
    }
    
    func updateUiWith(currentWeather : CurrentWeather) {
        self.imageView.image = currentWeather.icon
        self .pressureLabel.text = currentWeather.pressureString
        self .temperatureLabel.text = currentWeather.temperatureString
        self .appearentTemperatureLabel.text = currentWeather.appearentTemperatureString
        self .humidityLabel.text = currentWeather.humidityString
        self.locationLabel.text = currentWeather.summaryString
        self.precipTypeLabeell.text = currentWeather.windSpeedString
    }
    
    
}








