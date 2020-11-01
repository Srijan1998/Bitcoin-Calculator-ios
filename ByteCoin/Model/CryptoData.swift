//
//  CryptoData.swift
//  ByteCoin
//
//  Created by Srijan Bhatia on 25/10/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct CryptoData: Decodable {
    let time: String
    let rate: Double
    let asset_id_quote: String
    var rateString: String {
        return String(format: "%.4f", rate)
    }
}
