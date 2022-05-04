//
//  ChargerModel.swift
//  SNAK4EV
//
//  Created by Apple  on 04/05/22.
//

import Foundation

struct ChargerModel : Decodable
{
    let status: String?
    let message: String?
    let location: [ChargerLocationModel]?
    
    
    static func convertData(data: Data) -> ChargerModel? {
        let model = try! JSONDecoder().decode(ChargerModel.self, from: data)
        return model
    }
}

struct ChargerLocationModel: Codable{
    let connectorid: String?
    let chargerid: String?
    let rate: String?
    let tax: String?
    let endpoint: String?
    let address: String?
    let connectorstatus: String?
    let ratecur: String?
    let connectortype: String?
    let connectorpower: String?
    let chargeronline: String?
    let latitude: String?
    let longitude: String?
}
