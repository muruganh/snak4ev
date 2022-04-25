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
    public static var userDetailModel: ProfileModel?
    {
        let data = UserDefaults.standard.data(forKey: "UserDetails")
        guard data != nil else { return nil}
        return try? JSONDecoder().decode(ProfileModel.self, from: data!)
    }
}

struct TokenDetails
{
    public init() {}
    public static var tokenModel: LoginModel?
    {
        let data = UserDefaults.standard.data(forKey: "TokenDetails")
        guard data != nil else { return nil}
        return try? JSONDecoder().decode(LoginModel.self, from: data!)
    }
}

struct LoginModel : Decodable
{
    let error : errorModel?
    let responseCode: Int?
    let responseObject: TokenObj?
    let message: String?
    
    static func convertData(data: Data) -> LoginModel? {
        UserDefaults.standard.set(data, forKey: "TokenDetails")
        let model = try! JSONDecoder().decode(LoginModel.self, from: data)
        return model
    }
}

struct TokenObj : Decodable
{
    let token: String?
}

struct errorModel: Codable{
    let code : Int!
    let message : String?
}


struct Connectivity{
    static let sharedInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet:Bool{
        return self.sharedInstance.isReachable
    }
}


struct TestGetModel : Decodable{
    let id: String!
    let created_at: String?
    
    static func convertData(data: Data) -> TestGetModel? {
        let model = try! JSONDecoder().decode(TestGetModel.self, from: data)
        return model
    }
}


struct CommonModel : Decodable
{
    
    let responseCode: Int?
    let message: String?
    
    static func convertData(data: Data) -> CommonModel? {
        let model = try! JSONDecoder().decode(CommonModel.self, from: data)
        return model
    }
}

struct ProfileModel: Codable{
    let code : Int!
    let message : String?
}
