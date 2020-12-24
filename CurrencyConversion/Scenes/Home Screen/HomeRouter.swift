//
//  HomeRouter.swift
//  CurrencyConversion
//
//  Created by Ragaie Alfy on 12/3/20.
//

import UIKit

class HomeRouter: NSObject,HomeRouterDelegate {
    func openCurrrencyList(delegate: SentBackKeyToHomeDelegate) {
        let screenVc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "ListScreenID") as? CurrenciesView
        screenVc?.homeSentBackDelegate = delegate
        Coordinator.shared.pushView(viewcontroller: screenVc ?? UIViewController())
    }
}
