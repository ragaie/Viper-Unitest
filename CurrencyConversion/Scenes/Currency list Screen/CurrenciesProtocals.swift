//
//  CurrenciesProtocals.swift
//  CurrencyConversion
//
//  Created by Ragaie Alfy on 12/3/20.
//

import Foundation

protocol  CurrenciesHomeDelegate: NSObjectProtocol {
    func updateScreenWithData()
    func gotAnError(error: String)
}
protocol  CurrenciesPresenterDelegate: NSObjectProtocol {
    var view:CurrenciesHomeDelegate? {get set}
    var currenciesItems: [String: String]? {get set}
    func setInteeractor()
    func getAllData()
}
protocol  CurrenciesInteractorDelegate: NSObjectProtocol {
   func getAllCurrencies()
}

protocol  CurrenciesInteractorToPresenterDelegate: NSObjectProtocol {
    func gotAnError(error:String)
    func gotData(items :  [String : String])
}
protocol SentBackKeyToHomeDelegate: NSObjectProtocol {
    func selectCode(code: String)
}
