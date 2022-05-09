//
//  HomeVM.swift
//  BLT
//
//  Created by Apple  on 25/01/22.
//

import Foundation
import Alamofire

class HomeVM: NSObject {
    
    static let sharedInstance = HomeVM()
    
    var chargeStations: ((HomeModel) -> Void)?
    
    var chargeStationAddress: ((ChargeStationLocationModel) -> Void)?
    
    var autoCompleteResponse: ((Bool, [AutoCompletePlaceList]) -> Void)?
    
    func getChargeStations(){
        APIRequestManager.sharedInstance.getChargeStations { success, jsonObject in
            guard jsonObject?.ok ?? false else{
                return
            }
            self.chargeStations?(jsonObject!)
        }
    }
    
    func getChargeStationAddress(locId: String){
        APIRequestManager.sharedInstance.getChargeStationAddress(locId: locId) { success, locationModel in
            guard locationModel?.ok ?? false else{
                return
            }
            self.chargeStationAddress?(locationModel!)
        }
    }
    
    func getPlaces(searchString: String){
        APIRequestManager().autoCompletePlaces(searchKey: searchString) { (success, placeModel) in
            if(success){
                guard placeModel?.predictions?.count != 0 else{
                    self.autoCompleteResponse?(false, [])
                    return
                }
                self.autoCompleteResponse?(true, (placeModel?.predictions)!)
            }
        }
    }
    
}

