//
//  CurrenciesInteractor.swift
//  CurrencyConversion
//
//  Created by Ragaie Alfy on 12/3/20.
//

import UIKit

class CurrenciesInteractor: NSObject ,CurrenciesInteractorDelegate {
    var service : ServiceManagerDelegate?
    var presenter: CurrenciesInteractorToPresenterDelegate?
    var cachedManager: CachedData?
    init(service: ServiceManagerDelegate, preseenter: CurrenciesInteractorToPresenterDelegate) {
        self.service = service
        self.presenter = preseenter
        cachedManager = CachedData()
    }
    func getAllCurrencies() {
        self.cachedManager?.getDataWith(endPoint: "List", classType: Currencies.self, completionHandler: { (object, _, _) in
            if let items = object?.currencies {
                self.presenter?.gotData(items: items)
            } else {
                self.callApi()
            }
        })
    }
    func callApi() {
        service?.requestDataWith(way: .GET, endPoint: UrlData.list(), parameters: [:], classType: Currencies.self, completionHandler: { (object, data, _, error) in
            if let tempData = data {
                self.cachedManager?.saveDataFor(endPoint: "List", data: tempData)
            }
            if object != nil {
                self.presenter?.gotData(items: object?.currencies ?? [:])
            } else if error != nil {
                self.presenter?.gotAnError(error: error?.localizedDescription ?? "")
            }
        })
    }
}
