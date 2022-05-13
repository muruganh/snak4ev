//
//  LoginModel.swift
//  BLT
//
//  Created by Murugan on 08/03/21.
//

import Foundation
import Alamofire

struct UserDetails
{
    public init() {}
    public static var UserDetailModel: ProfileModel?
    {
        let data = UserDefaults.standard.data(forKey: "UserDetails")
        guard data != nil else { return nil}
        return try? JSONDecoder().decode(ProfileModel.self, from: data!)
    }
}

struct TokenDetails
{
    public init() {}
    public static var tokenModel: ApiTokenModel?
    {
        let data = UserDefaults.standard.data(forKey: "TokenDetails")
        guard data != nil else { return nil}
        return try? JSONDecoder().decode(ApiTokenModel.self, from: data!)
    }
}

struct OTPGenerateModel : Decodable
{
    let otpauthcode: Int?
    let status: String?
    let message: String?
    let ss: [OTPGenerateMobile]?
    
    static func convertData(data: Data) -> OTPGenerateModel? {
        let model = try! JSONDecoder().decode(OTPGenerateModel.self, from: data)
        return model
    }
}

struct OTPAuthenticateModel : Decodable
{
    let status: String?
    let message: String?
    let iscustomer: String?
    let customerid: String?
    let firstname: String?
    let lastname: String?
    let interfaceid: String?
    
    static func convertData(data: Data) -> OTPAuthenticateModel? {
        let model = try! JSONDecoder().decode(OTPAuthenticateModel.self, from: data)
        return model
    }
}

struct ApiTokenModel : Decodable
{
    let status: String?
    let access_token: String?
    
    static func convertData(data: Data) -> ApiTokenModel? {
        UserDefaults.standard.set(data, forKey: "TokenDetails")
        let model = try! JSONDecoder().decode(ApiTokenModel.self, from: data)
        return model
    }
}

struct OTPGenerateMobile: Codable{
    let recipient : Int!
    let id : String?
}


struct Connectivity{
    static let sharedInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet:Bool{
        return self.sharedInstance.isReachable
    }
}

struct RegisterModel : Decodable
{
    let status: String?
    let message: String?
    let customerid: String?
    
    static func convertData(data: Data) -> RegisterModel? {
        let model = try! JSONDecoder().decode(RegisterModel.self, from: data)
        return model
    }
}

struct EdrvRegisterModel : Decodable
{
    let ok: Bool?
    let message : String?
    let id : String?
    
    static func convertData(data: Data) -> EdrvRegisterModel? {
        let model = try! JSONDecoder().decode(EdrvRegisterModel.self, from: data)
        return model
    }
}
