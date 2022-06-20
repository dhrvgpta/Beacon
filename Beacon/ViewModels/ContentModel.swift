//  ContentModel.swift
//  Beacon

//  Created by Dhruv Gupta on 20/06/22.


import Foundation
import CoreLocation

class ContentModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    var sights = [Business]()
    var restaurants = [Business]()
    
    override init(){
        
        // Calling the init() method of NSObject as per protocol
        super.init()
        
        // Set ContentModel as the delegate of locationManager
        locationManager.delegate = self
        
        // Request permission from the user
        locationManager.requestWhenInUseAuthorization()
    }
    
    // MARK: - LocationManager Delegate Methods
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        if locationManager.authorizationStatus == CLAuthorizationStatus.authorizedAlways ||
            locationManager.authorizationStatus == CLAuthorizationStatus.authorizedWhenInUse{
            
            // Start geolocating the user, after we get the permission
            locationManager.startUpdatingLocation()
            
        }
        else if locationManager.authorizationStatus == CLAuthorizationStatus.denied{
            
            // We don't have permisson
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Give us the location continously
        let userLocation = locations.first
        if userLocation != nil{
            
            // Stop requesting the location after we get it once
            locationManager.stopUpdatingLocation()
            
            // Pass the location to Yelp API
            getBusinesses(category: Constants.categories[1], location: userLocation!)
        }
    }
    
    // MARK: - Yelp API Methods
    
    func getBusinesses(category: String, location: CLLocation){
        
        // Create URL - Method 1
        
        /* let url = URL(string: "https://api.yelp.com/v3/businesses/search?latitude = \(location.coordinate.latitude)&longitude=\(location.coordinate.longitude)&categories=\(categories)&limit=6")
        
        guard url != nil else{
            return
        } */
        
        // Create URL - Method 2
        var urlComponents = URLComponents(string: Constants.apiURL)
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: String(category)),
            URLQueryItem(name: "limit", value: "6")
        ]
        
        guard urlComponents != nil else{
            return
        }
        
        let url = urlComponents?.url
        guard url != nil else{
            return
        }
        
        // Create URL request
        var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.addValue("Bearer \(Constants.apiKey)"
                         , forHTTPHeaderField: "Authorization")
        
        // Create URL session
        let session = URLSession.shared
        
        // Create data task
        let dataTask = session.dataTask(with: request) { data, response, error in
            guard error == nil else{
                print(error!)
                return
            }
            // Parse the JSON data
            do{
                let decoder = JSONDecoder()
                let decoded_data = try decoder.decode(BusinessSearch.self, from: data!)
                
                // Assign the data tp respective properties
                DispatchQueue.main.async {
                    switch category{
                    case "arts":
                        self.sights = decoded_data.businesses
                    
                    case "restaurants":
                        self.restaurants = decoded_data.businesses
                        
                    default:
                        break
                    }
                }
                
            }catch{
                print(error)
            }
        }
        
        // Kick-off the data task
        dataTask.resume()
        
    }
}
