//
//  HomeInteractor.swift
//  CurrencyConversion
//
//  Created by Ragaie Alfy on 12/3/20.
//

import UIKit

class HomeInteractor: NSObject, HomeInteractorDelegate {
    var service : ServiceManagerDelegate?
   weak var presenter: HomeInteractorToPresenterDelegate?
    var cachedManager: CachedData?
    init(service: ServiceManagerDelegate, preseenter: HomeInteractorToPresenterDelegate) {
        self.service = service
        self.presenter = preseenter
    }
    func getData() {
        service?.requestDataWith(way: .GET, endPoint: UrlData.live(), parameters: [:], classType: QuoteEntity.self, completionHandler: { (object, _, _, error) in
            if object != nil {
                self.presenter?.gotData(items: object?.quotes ?? [:])
            } else if error != nil {
                self.presenter?.gotAnError(error: error?.localizedDescription ?? "")
            }
        })
    }

}
