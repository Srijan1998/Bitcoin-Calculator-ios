//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class BitcoinViewController: UIViewController {

    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    var coinManager: CoinManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coinManager = CoinManager()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager?.delegate = self
    }
}

extension BitcoinViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager?.currencyArray.count ?? 0
    }
}

extension BitcoinViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager?.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinManager?.fetchBitcoinData(arrayIndex: row)
    }
}

extension BitcoinViewController: CryptoManagerDelegate {
    func didUpdateRate(cryptoData: CryptoData) {
        DispatchQueue.main.async {
            self.currencyLabel.text = cryptoData.asset_id_quote
            self.bitcoinLabel.text = cryptoData.rateString
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}

