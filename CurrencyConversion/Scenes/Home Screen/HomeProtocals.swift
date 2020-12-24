//
//  HomeProtocals.swift
//  CurrencyConversion
//
//  Created by Ragaie Alfy on 12/3/20.
//

import UIKit

protocol  HomeDelegate: NSObjectProtocol {
    func updateScreenWithData()
    func gotAnError(error: String)
    func loaderIsHidden(ishidden: Bool)
}

protocol  HomePresenterDelegate: NSObjectProtocol {
    var view :HomeDelegate? { get set }
    var codesSelected: [String] { get set }
    var calculatedValues: [Float] { get set }
    func fromCountryCode(code:String)
    func selectedNewCode(code:String)
    func setInteractor()
    func convertAmount(amount: Float)
    func addNewCountryCode(delegate: SentBackKeyToHomeDelegate)
    var callingIndex: Int? {get set}
    func getData()
}
protocol  HomeRouterDelegate: NSObjectProtocol {
    func openCurrrencyList(delegate: SentBackKeyToHomeDelegate)
}
protocol  HomeInteractorDelegate: NSObjectProtocol {
    func getData()

}

protocol  HomeInteractorToPresenterDelegate: NSObjectProtocol {
    func gotAnError(error:String)
    func gotData(items :  [String:Float])
}
