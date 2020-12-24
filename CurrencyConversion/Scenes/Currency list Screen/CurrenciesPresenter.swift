//
//  CurrenciesPresenter.swift
//  CurrencyConversion
//
//  Created by Ragaie Alfy on 12/3/20.
//

import UIKit

class CurrenciesPresenter: NSObject, CurrenciesPresenterDelegate,CurrenciesInteractorToPresenterDelegate {
    var currenciesItems: [String : String]? = [:]
    weak var view: CurrenciesHomeDelegate?
    var interactor: CurrenciesInteractorDelegate?
    func setInteeractor() {
        interactor = CurrenciesInteractor(service: ServiceManager(), preseenter: self)
    }
    func getAllData() {
        interactor?.getAllCurrencies()
    }
    func gotAnError(error: String) {
        view?.gotAnError(error: error)
    }
    func gotData(items: [String : String]) {
        currenciesItems = items
        view?.updateScreenWithData()
    }
}
