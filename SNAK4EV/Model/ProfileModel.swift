//
//  ProfileModel.swift
//  SNAK4EV
//
//  Created by Apple  on 02/05/22.
//

import Foundation

struct ProfileModel : Decodable
{
    let status: String?
    let message: String?
    let mobilenumber: String?
    let emailid: String?
    let address: String?
    let countryid: String?
    let stateid: String?
    let cityid: String?
    let first_name: String?
    let last_name: String?
    let postal_code: String?
    
    static func convertData(data: Data) -> ProfileModel? {
        let model = try! JSONDecoder().decode(ProfileModel.self, from: data)
        return model
    }
}

struct ProfileUpdateModel : Decodable
{
    let status: String?
    let message: String?
    
    static func convertData(data: Data) -> ProfileUpdateModel? {
        let model = try! JSONDecoder().decode(ProfileUpdateModel.self, from: data)
        return model
    }
}

struct CountryListModel : Decodable{
    
    let Countries: [CountryModel]?
    
    static func convertData(data: Data) -> CountryListModel? {
        let model = try! JSONDecoder().decode(CountryListModel.self, from: data)
        return model
    }
}

struct CountryModel: Codable{
    let CountryName : String?
    let States : [StateModel]?
}

struct StateModel: Codable{
    let StateName : String?
    let Cities : [String]?
}
