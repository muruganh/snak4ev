//
//  LocationManager.swift
//  BLT
//
//  Created by Murugan on 08/03/21.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {
    
    static let shared = LocationManager()
    
    private override init() {
        super.init()
        self.lastLocation = nil
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.allowsBackgroundLocationUpdates = true
        
        if !hasLocationPermission() {
            print("pls enable location")
        }
        
//        if CLLocationManager.locationServicesEnabled() {
//            let status = CLLocationManager.authorizationStatus()
//            if status == .notDetermined {
//                locationManager.requestWhenInUseAuthorization()
//            } else if status == .restricted || status == .denied {
//                // TODO show some dialog to let user allow app to get location
//            } else if status == .authorizedWhenInUse {
//                locationManager.startUpdatingLocation()
//            }
//        }
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    var locationManager: CLLocationManager!
    var lastLocation: CLLocationCoordinate2D?
    
    func hasLocationPermission() -> Bool {
            var hasPermission = false
            if CLLocationManager.locationServicesEnabled() {
                switch CLLocationManager.authorizationStatus() {
                case .notDetermined, .restricted, .denied:
                    hasPermission = false
                case .authorizedAlways, .authorizedWhenInUse:
                    hasPermission = true
                default:
                    hasPermission = true
                }
            } else {
                hasPermission = false
            }
            
            return hasPermission
        }
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let latitude = manager.location?.coordinate.latitude, let longitude = manager.location?.coordinate.longitude {
            GlobalLocation.initialLatitude = latitude
            GlobalLocation.initialLongitude = longitude
        }
        NotificationCenter.default.post(name: .didReceiveData, object: self, userInfo: ["manager": manager])
    }
}


extension Notification.Name {
    static let didReceiveData = Notification.Name("didReceiveData")
    static let reloadObjectList = Notification.Name("reloadObjectList")
}

class GlobalLocation {
    static var initialLatitude:Double = 0
    static var initialLongitude:Double = 0
}
