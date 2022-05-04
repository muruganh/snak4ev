//
//  WalletModel.swift
//  SNAK4EV
//
//  Created by Apple  on 29/04/22.
//

import Foundation

struct UpdateWalletModel : Decodable
{
    let status: String?
    let message: String?
    let walletbal: String?
    
    static func convertData(data: Data) -> UpdateWalletModel? {
        let model = try! JSONDecoder().decode(UpdateWalletModel.self, from: data)
        return model
    }
}
