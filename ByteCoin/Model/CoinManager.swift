//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CryptoManagerDelegate {
    func didUpdateRate(cryptoData: CryptoData)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "86979764-A77E-42F3-BA66-CF896F12C502"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CryptoManagerDelegate?

    func fetchBitcoinData(arrayIndex: Int) {
        let apiURL = "\(baseURL)/\(currencyArray[arrayIndex])?apikey=\(apiKey)"
        performRequest(apiURL: apiURL)
        print(apiURL)
    }
    
    func performRequest(apiURL: String) {
        if let url = URL(string: apiURL) {
            
        let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let cryptoData = parseJSON(data: safeData) {
                        delegate?.didUpdateRate(cryptoData: cryptoData)
                    }
                }
            })
            task.resume()
        }
    }
    
    func parseJSON(data: Data) -> CryptoData? {
        let decoder = JSONDecoder()
        do {
            let decodedData =  try decoder.decode(CryptoData.self, from: data)
            print(decodedData.rate)
            return decodedData
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
