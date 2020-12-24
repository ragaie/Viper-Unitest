//
//  HomePresenter.swift
//  CurrencyConversion
//
//  Created by Ragaie Alfy on 12/3/20.
//

import UIKit

class HomePresenter: NSObject,HomePresenterDelegate, HomeInteractorToPresenterDelegate {
    weak  var view: HomeDelegate?
    var router: HomeRouterDelegate?
    var interactor: HomeInteractorDelegate?
    var codeSelected: String = "USD"
     var amount : Float = 1.0
    var codesSelected: [String] = []
    var calculatedValues: [Float] = []
    var quoteItems: [String : Float]?
    var callingIndex: Int?
    init(router: HomeRouterDelegate) {
        self.router = router
    }
    func setInteractor() {
        interactor = HomeInteractor(service: ServiceManager(), preseenter: self)
    }
    func initTimer(with interval: Double) {
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(updateData), userInfo: nil, repeats: true).fire()
    }
    @objc func updateData() {
        view?.loaderIsHidden(ishidden: false)
        interactor?.getData()
    }
    func addNewCountryCode(delegate: SentBackKeyToHomeDelegate) {
        router?.openCurrrencyList(delegate: delegate)
    }
    func convertAmount(amount: Float) {
        self.amount = amount
        calculateValues()
    }
    func getData() {
        interactor?.getData()
        initTimer(with: 60*30)
    }
    func gotAnError(error: String) {
        view?.gotAnError(error: error)
    }
    func fromCountryCode(code: String) {
        codeSelected = code
        calculateValues()
    }
    func gotData(items: [String : Float]) {
        quoteItems = items
        view?.loaderIsHidden(ishidden: true)
        if !codesSelected.isEmpty {
            calculateValues()
        }
    }
    func selectedNewCode(code:String) {
        if codesSelected.contains(code) {
            let index = codesSelected.firstIndex(of: code) ?? 0
            codesSelected.remove(at: index)
        } else {
            codesSelected.append(code)
        }
        calculateValues()
    }
    func calculateValues() {
        calculatedValues = []
        for item in codesSelected {
            let newKey = codeSelected  + item
            if codeSelected == "USD"{
                if let value =  quoteItems?[newKey] {
                    calculatedValues.append(value * amount )
                }
            } else {
                let usdToKey = "USD" + codeSelected
                let usdToItem = "USD" + item
                if let firstValue = quoteItems?[usdToKey], let secandValue = quoteItems?[usdToItem] {
                    calculatedValues.append((secandValue / firstValue) * amount)
                }
            }
        }
        view?.updateScreenWithData()
    }
}
