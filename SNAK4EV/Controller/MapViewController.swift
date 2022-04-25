//
//  MapViewController.swift
//  SNAK4EV
//
//  Created by Sulaiman on 12/04/22.
//

import UIKit
import GoogleMaps
import CoreLocation
struct area : Decodable{
    let name: String
    let long: CLLocationDegrees
    let lat: CLLocationDegrees
}
class MapViewController: UIViewController,CLLocationManagerDelegate {
   
    let manager = CLLocationManager()
    let areas = [
        area(name: "Tnagar", long: 80.2255, lat: 13.0521),
        area(name: "Guindy", long: 80.2206, lat: 13.0067),
        
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        let camera =  GMSCameraPosition.camera(withLatitude: 13.0521, longitude: 80.2255, zoom: 13.0)
        let mapview = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.view.addSubview(mapview)
        mapview.isMyLocationEnabled = true
        mapview.settings.myLocationButton = true
        for area in areas {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: area.lat, longitude: area.long)
            print ( "the lat is --> \(area.lat)")
            print ( "the long is --> \(area.long)")
            marker.title = area.name
            marker.snippet = "Hey, this is \(area.name)"
            marker.map = mapview
            marker.icon = GMSMarker.markerImage(with: .blue)
        }
    }
}


