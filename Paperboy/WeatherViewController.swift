//
//  WeatherViewController.swift
//  PagerStripDemo
//
//  Created by Shyam on 30/11/19.
//  Copyright © 2019 Assignment. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import CoreLocation
import SDWebImage

class WeatherViewController: UIViewController, IndicatorInfoProvider, CLLocationManagerDelegate {
    
    @IBOutlet weak var tempLbl: UILabel!
    
    @IBOutlet weak var tempMinLbl: UILabel!
    
    @IBOutlet weak var tempMaxLbl: UILabel!
    
    @IBOutlet weak var humidLbl: UILabel!
    
    @IBOutlet weak var pressureLbl: UILabel!
    
    @IBOutlet weak var tempVal: UILabel!
    
    @IBOutlet weak var tempMinVal: UILabel!
    
    @IBOutlet weak var tempMaxVal: UILabel!
    
    @IBOutlet weak var humidVal: UILabel!
    
    @IBOutlet weak var pressureVal: UILabel!
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var cityLbl: UILabel!
    
    @IBOutlet weak var celciusLbl: UILabel!
    
    @IBOutlet weak var weatherLbl: UILabel!
    
    @IBOutlet weak var dayLbl: UILabel!
    
    @IBOutlet weak var reportLbl: UILabel!
    
    @IBOutlet weak var reportDescLbl: UILabel!
    
  var itemInfo: IndicatorInfo = "Weather"
  let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    var latitude: String!
    var longitude: String!
    var icon = [String]()
    var main = [String]()
    var desc = [String]()
    var imgUrl: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        var currentLocation: CLLocation!
//
        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
                CLLocationManager.authorizationStatus() ==  .authorizedAlways){

              currentLocation = locationManager.location
        }
        locationManager.startUpdatingLocation()
        print("CurrentLocation:\(currentLocation)")
        self.latitude = String(currentLocation.coordinate.latitude)
        self.longitude = String(currentLocation.coordinate.longitude)
        
        print("lat:\(String(describing: self.latitude!))")
        print("long:\(String(describing: self.longitude!))")
        
        getWeatherReport(latitude: self.latitude, longitude: self.longitude)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//            if let location = locations.first {
//                print("Location:\(location.coordinate)")
//            }
//            if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
//                    CLLocationManager.authorizationStatus() ==  .authorizedAlways){
//
//                  currentLocation = locationManager.location
//
//            }
//            print("current location:\(currentLocation)")
//
//            self.latitude = String(currentLocation.coordinate.latitude)
//            self.longitude = String(currentLocation.coordinate.longitude)
//
//            print("lat:\(String(describing: self.latitude))")
//            print("long:\(String(describing: self.longitude))")
//
//    //        UserDefaults.standard.set(self.latitude, forKey: "latitude")
//    //        UserDefaults.standard.set(self.longitude, forKey: "longitude")
//
//            getWeatherReport(latitude: self.latitude, longitude: self.longitude)
//
        }

    
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    func getWeatherReport(latitude: String!, longitude: String!){
        
//        let lat = UserDefaults.standard.value(forKey: "latitude")
//        let long = UserDefaults.standard.value(forKey: "longitude")
       
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(String(describing: latitude!))&lon=\(String(describing: longitude!))&APPID=0e97dd733bb1859825e94ae5b0c34ab9&units=metric"
                              print("URLSTRING:\(urlString)")
                       let URL: Foundation.URL = Foundation.URL(string: urlString)!
                       let request:NSMutableURLRequest = NSMutableURLRequest(url:URL)
                           request.httpMethod = "GET"
                       let session = URLSession.shared
                              let task = session.dataTask(with: request as URLRequest){ (data, response, error) in
                               print("data:\(String(describing: data))")
                                  guard data != nil else{
                                      print("data nil:\(String(describing: data))")
                                      return
                               }
                               do{
                                   let jsonResponse = try JSONSerialization.jsonObject(with:
                                       data!, options: []) as? [String: Any]
                                   print("ReportjsonResponse:\(String(describing: jsonResponse!))")
                                guard let dic = jsonResponse else {return}
                                guard let main = dic["main"] as? [String: Any] else {return}
                                print("Mainn:\(main)")
                                guard let humidity = main["humidity"] as? Int else {return}
                                guard let pressure = main["pressure"] as? Int else {return}
                                guard let temp = main["temp"] as? Double else{
                                    return
                                }
                                guard let tempMax = main["temp_max"] as? Double else {return}
                                guard let tempMin = main["temp_min"] as? Double else {return}
                                guard let name = dic["name"] as? String else {return}
                                guard let weather = jsonResponse!["weather"] as? [[String: Any]] else {return}
                                
                                print("humidity1:\(humidity)")
                                print("pressure1:\(pressure)")
//                                print("temp1:\(temp)")
                                print("WEATHER::\(weather)")
                                
                                for elem in weather {

                                    self.icon.append((elem["icon"] as? String)!)
                                    self.main.append((elem["main"] as? String)!)
                                    self.desc.append((elem ["description"] as? String)!)

                                    print("icon:\(String(describing: self.icon))")
                                    print(" MAIN:\(main)")
                                    print("Description:\(String(describing: self.desc))")

                                }
                                
                let imageUrl =  NSURL(string: "http://openweathermap.org/img/wn/\(self.icon[0])@2x.png")! as URL
                                                           
                                DispatchQueue.main.async {
                                    self.dayLbl.text = self.main[0]
                                    self.reportDescLbl.text = self.main[0]
                                    self.tempVal.text = "\(String(temp))°C"
                                    self.celciusLbl.text = "\(temp)°C"
        self.imgView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder-image.jpg"))
                                    self.humidVal.text = String(humidity)
                                    self.pressureVal.text = "\(String(pressure))hPa"
                                    
                                    self.tempMinVal.text = "\(String(tempMin))°C"
                                    self.tempMaxVal.text = "\(String(tempMax))°C"
                                    
                                    self.cityLbl.text = name
                                    self.weatherLbl.text = "Weather in \(name)"
                                }
                                
                               } catch let parsingError {
                                   print("Error", parsingError)
                               }
                               
               }

               task.resume()
        
    }

}
