//
//  HomeModel.swift
//  SNAK4EV
//
//  Created by Apple  on 08/05/22.
//

import Foundation

struct HomeModel : Decodable
{
    let ok: Bool?
    let result: [ChargeStationList]?
    
    static func convertData(data: Data) -> HomeModel? {
        let model = try! JSONDecoder().decode(HomeModel.self, from: data)
        return model
    }
}


struct ChargeStationList: Codable{
    let _id : String?
    let location : String?
    let endpoint : String?
    let static_endpoint : String?
    let lastConnectAt : String?
    let lastDisconnectAt : String?
    let lastMessageAt : String?
    let createdAt : String?
    let updatedAt : String?
    let connection_url : String?
    let security : Security?
    let coordinates: [Double]?
    let bootInfo: BootInfo?
    let connectors: [ConnectorsList]?
    let rate: Rate?
}

struct Security: Codable{
    let type : String?
}

struct coordinates: Codable{
    let type : String?
}

struct BootInfo: Codable{
    let chargePointVendor : String?
    let chargePointModel : String?
    let chargePointSerialNumber : String?
    let firmwareVersion : String?
}

struct ConnectorsList: Codable{
    let _id : String?
    let active : Bool?
    let status : String?
    let type : String?
    let format : String?
    let power_type : String?
    let power : Int?
    let rate : Rate?
    let chargestation : String?
    let createdAt : String?
    let updatedAt : String?
}

struct Rate: Codable{
    let _id : String?
    let name : String?
    let description : String?
    let currency : String?
    let createdAt : String?
    let updatedAt : String?
}

struct PriceComponents: Codable{
    let tax : Double?
    let step_size : Int?
    let type : String?
    let price : Double?
    let grace_period : Double?
}

struct ChargeStationLocationModel : Decodable
{
    let ok: Bool?
    let message : String?
    let result: ChargeStationDetails?
    
    static func convertData(data: Data) -> ChargeStationLocationModel? {
        let model = try! JSONDecoder().decode(ChargeStationLocationModel.self, from: data)
        return model
    }
}

struct ChargeStationDetails: Codable{
    let _id : String?
    let active : Bool?
    let operatorName : String?
    let timezone : String?
    let updatedAt : String?
    let createdAt : String?
    let coordinates: [Double]?
    let address: ChargeStationAddress?
}

struct ChargeStationAddress: Codable{
    let streetAndNumber : String?
    let country : String?
    let state : String?
    let city : String?
    let postalCode : String?
}

struct AutoCompletePlacesModel : Decodable
{
    var predictions : [AutoCompletePlaceList]?
    
    static func convertData(data: Data) -> AutoCompletePlacesModel? {
        let model = try! JSONDecoder().decode(AutoCompletePlacesModel.self, from: data)
        return model
    }
}

struct AutoCompletePlaceList: Codable{
    let place_id: String!
    let description: String!
}

struct AutoCompletePlacesModelDetails : Decodable
{
    var result : AutoCompleteSinglePlaceDetails?
    static func convertData(data: Data) -> AutoCompletePlacesModelDetails? {
        let model = try! JSONDecoder().decode(AutoCompletePlacesModelDetails.self, from: data)
        return model
    }
}

struct AutoCompleteSinglePlaceDetails: Codable{
    let geometry: AutoCompleteSinglelocation!
}

struct AutoCompleteSinglelocation: Codable{
    let location: AutoCompleteSingleLatLong!
}

struct AutoCompleteSingleLatLong: Codable{
    let lat: Float!
    let lng: Float!
}
