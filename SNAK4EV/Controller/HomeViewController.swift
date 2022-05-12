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
class HomeViewController: BaseViewController,CLLocationManagerDelegate, UITextFieldDelegate {
    
    @IBOutlet var mapView: GMSMapView?
    @IBOutlet var txtSearch: UITextField?
    @IBOutlet var viewChargeInfo: UIView?
    @IBOutlet var tblView: UITableView?
    @IBOutlet var viewChargeBottomConstraint: NSLayoutConstraint?
    @IBOutlet var tblViewHeight: NSLayoutConstraint?
    @IBOutlet var btnCloseChargerView: UIButton?
    var chargeLocations: [ChargeStationList] = []
    var chargeLocationDetails: ChargeStationList?
    var isViewHide = true
    var searchString = ""
    var autoCompleteList: [AutoCompletePlaceList] = []
    var selectedAutoPlace: AutoCompletePlaceList!
    let areas = [
        area(name: "Tnagar", long: 80.2255, lat: 13.0521),
        area(name: "Guindy", long: 80.2206, lat: 13.0067),
        
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtSearch?.setLeftPadding(12.0)
        
        mapView?.delegate = self
        mapView?.isMyLocationEnabled = true
        mapView?.settings.myLocationButton = true
        self.getChargeLocations()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.mapView?.isHidden = false
            let camera = GMSCameraPosition.camera(withLatitude: GlobalLocation.initialLatitude, longitude: GlobalLocation.initialLongitude, zoom: 15.0)
            self?.mapView?.camera = camera
            self?.mapView?.animate(to: camera)
        }
    }
    
    func getChargeLocations(){
        HomeVM.sharedInstance.getChargeStations()
        HomeVM.sharedInstance.chargeStations = {(homeModel)in
            self.chargeLocations = homeModel.result ?? []
            self.setMarkers()
        }
        
        HomeVM.sharedInstance.chargeStationAddress = {(locationModel)in
            self.btnCloseChargerView?.isHidden = false
            let v = popUpView.loadNib()
            v.frame.size.width = self.view.frame.size.width
            v.setObject(locationModel: locationModel, details: self.chargeLocationDetails!)
            v.btnSelection?.addTarget(self, action: #selector(self.btnConnect(_:)), for: .touchUpInside)
            v.btnNAvigate?.addTarget(self, action: #selector(self.btnNavigate(_:)), for: .touchUpInside)
            self.viewChargeInfo?.addSubview(v)
            DispatchQueue.main.async {
                self.animShows()
            }
        }
    }
    
    
    
    func setMarkers(){
        for area in self.chargeLocations {
            let marker = GMSMarker()
            marker.userData = area
            marker.position = CLLocationCoordinate2D(latitude: area.coordinates?[1] ?? 0.0, longitude: area.coordinates?[0] ?? 0.0)
            marker.map = mapView
            for connector in area.connectors ?? []{
                if connector.status == "Available"{
                    marker.icon = UIImage.init(named: "logo_small_green1x")
                    break
                }
                if connector.status == "Faulted"{
                    marker.icon = UIImage.init(named: "logo_small_grey1x")
                    break
                }
                if connector.status == "Preparing"{
                    marker.icon = UIImage.init(named: "logo_small_grey1x")
                    break
                }
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    @IBAction func btnCloseChargerView(_ sender: UIButton){
        self.hidePopup()
    }
    
    func hidePopup(){
        self.btnCloseChargerView?.isHidden = true
        self.animHidee()
    }
    
    func animShows(){
        self.viewChargeBottomConstraint?.constant = 0
        self.viewChargeInfo?.layoutIfNeeded()
    }
    func animHidee(){
        self.viewChargeBottomConstraint?.constant = -220
        self.viewChargeInfo?.layoutIfNeeded()
    }
    
    @IBAction func btnConnect(_ sender: UIButton){
        self.hidePopup()
        let vc = Storyboards.Main.instance.instantiateViewController(withIdentifier: "ConnectorSelectionViewController") as! ConnectorSelectionViewController
        vc.connectorsList = self.chargeLocationDetails?.connectors ?? []
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnNavigate(_ sender: UIButton){
        let myUrl = "comgooglemaps://?saddr=&daddr=\(self.chargeLocationDetails?.coordinates?[1] ?? 0.00),\(self.chargeLocationDetails?.coordinates?[0] ?? 0.00)&directionsmode=driving"
        
            if let url = URL(string: "\(myUrl)"), !url.absoluteString.isEmpty {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            guard let url = URL(string: "\(myUrl)"), !url.absoluteString.isEmpty else {
               return
            }
             UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func textField (_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                            replacementString string: String) -> Bool{
        let newString = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
        searchString = newString
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(search), object: nil)
        self.perform(#selector(search), with: nil, afterDelay: 0.2)
        return true
    }
    
    @objc func search(){
        Globals.shared.disableLoaderForSomeScreen = true
        HomeVM.sharedInstance.getPlaces(searchString: searchString, vc: self)
        HomeVM.sharedInstance.autoCompleteResponse = {(success, list) in
            if(success){
                self.autoCompleteList = list
            }
            self.tblViewHeight?.constant = CGFloat(list.count > 5 ? (5 * 50) : (list.count * 50))
            if list.count != 0{
                self.tblView?.isHidden = false
            }else{
                self.tblView?.isHidden = true
            }
            self.tblView?.reloadData()
        }
    }
}

extension HomeViewController: GMSMapViewDelegate, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.autoCompleteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "autoCompleteTableViewCell") as! autoCompleteTableViewCell
        cell.lblName?.text = self.autoCompleteList[indexPath.row].description
        cell.lblName?.setLineHeight(value: 1.2)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        self.txtSearch?.text = self.autoCompleteList[indexPath.row].description
        self.selectedAutoPlace = self.autoCompleteList[indexPath.row]
        self.tblView?.isHidden = true
        self.getaddressDetailsFromPlaceID()
    }
    
    
    // tap map marker
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print(marker.userData!)
        self.chargeLocationDetails = marker.userData as? ChargeStationList
        HomeVM.sharedInstance.getChargeStationAddress(locId: self.chargeLocationDetails?.location ?? "", vc: self)
        self.txtSearch?.resignFirstResponder()
        return true
    }
    
    func getaddressDetailsFromPlaceID(){
        API.aotoCompletePlaceDetails(searchKey: selectedAutoPlace.place_id) { (success, placeModel) in
            if(success){
                guard placeModel?.result != nil else{
                    return
                }
                let camera = GMSCameraPosition.camera(withLatitude: Double((placeModel?.result?.geometry.location.lat)!), longitude: Double((placeModel?.result?.geometry.location.lng)!), zoom: 15.0)
                self.mapView?.camera = camera
                self.mapView?.animate(to: camera)
            }
        }
    }
    
    
}

class autoCompleteTableViewCell: UITableViewCell{
    
    @IBOutlet var lblName: UILabel?
    
}
