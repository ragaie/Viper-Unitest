//
//  CurrencyConversionTests.swift
//  CurrencyConversionTests
//
//  Created by Ragaie Alfy on 12/3/20.
//

import XCTest
@testable import CurrencyConversion

class CurrencyConversionTests: XCTestCase {
    var view: HomeViewSpy!
    var router: HomeRouterMock!
    var interactor: HomeInteractorMock!
    var presenter: HomePresenter!
    override func setUpWithError() throws {
        view = HomeViewSpy()
        router = HomeRouterMock()
        interactor = HomeInteractorMock()
        presenter = HomePresenter(router: router)
        presenter.view = view
        presenter.interactor = interactor
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testSetInteractor(){
        presenter.interactor = nil
        presenter.setInteractor()
        XCTAssertTrue(presenter.interactor != nil)
        
    }
    func testInitTimer(){
        presenter.initTimer(with: 3)
        DispatchQueue.global().asyncAfter(deadline: .now() + 4) {

            XCTAssertFalse(self.view.loaderIsHidden)
            XCTAssertTrue(self.interactor.dataLoaded)
            }
    }
   
    func testUpdateData(){
        presenter.updateData()
        XCTAssertFalse(self.view.loaderIsHidden)
        XCTAssertTrue(self.interactor.dataLoaded)
    }
    func testAddNewCountryCode(){
        presenter.addNewCountryCode(delegate: view)
        XCTAssertTrue(router.screenOpend)
        
    }
    func testConvertAmount(){
        presenter.convertAmount(amount: 5)
        XCTAssertTrue(presenter.amount == 5)
    }
    
    func testGetData(){
        presenter.getData()
        XCTAssertTrue(self.interactor.dataLoaded)
    }
    func testGotAnError(){
        presenter.gotAnError(error: "Error parrsing data")
        XCTAssertTrue(view.errorMessage == "Error parrsing data")
    }
    
    func testFromCountryCode(){
        presenter.fromCountryCode(code: "USD")
        XCTAssertTrue(presenter.codeSelected == "USD")
        XCTAssertFalse(presenter.codeSelected == "EGP")
    }
    func testGotData(){
        let number: Float = 2.34
        let items =  ["USDEGP":number,"USDELK":number]
        presenter.gotData(items:items)
        XCTAssertEqual(items, presenter.quoteItems)
        XCTAssertTrue(self.view.loaderIsHidden)

    }
    
    func testSelectedNewCode(){
        presenter.selectedNewCode(code: "USD")
        XCTAssertEqual(presenter.codesSelected, ["USD"])
    }
    func testSelectedCodeAlreadyAdded(){
        presenter.codesSelected = ["USD"]
        presenter.selectedNewCode(code: "USD")
        XCTAssertEqual(presenter.codesSelected, [])
    }
    func testCalculateValues(){
        presenter.calculateValues()
        XCTAssertTrue(view.screenUpdated)
    }
    func testCalculateValuesForUSD(){
        presenter.codeSelected = "USD"
        presenter.amount = 2
        presenter.codesSelected = ["ANG","ALL","AFN","AED"]
        let items =  ["USDAED": Float(3.672982),"USDAFN": Float(77.050095),"USDALL": Float(102.449831),"USDANG": Float(1.795836)]
        
        presenter.quoteItems = items
        presenter.calculateValues()
        XCTAssertEqual(presenter.calculatedValues, [Float(1.795836) *  2, Float(102.449831) * 2, Float(77.050095) * 2,  Float(3.672982) * 2 ])
    }
    func testCalculateValuesForAED(){
        presenter.codeSelected = "AED"
        presenter.amount = 2
        presenter.codesSelected = ["ANG","AFN","AED"]
        let items =  ["USDAED": Float(3.672982),"USDAFN": Float(77.050095),"USDANG": Float(1.795836)]
        
        presenter.quoteItems = items
        presenter.calculateValues()
        XCTAssertEqual(presenter.calculatedValues, [0.97786266, 41.955063, 2.0 ])
    }
    
//    func calculateValues(){
//        calculatedValues = []
//        for item in codesSelected {
//            let newKey = codeSelected  + item
//            if codeSelected == "USD"{
//                if let value =  quoteItems?[newKey]{
//                    calculatedValues.append(value * amount )
//                }
//            }
//            else{
//                let usdToKey = "USD" + codeSelected
//                let usdToItem = "USD" + item
//
//                if let firstValue = quoteItems?[usdToKey], let secandValue = quoteItems?[usdToItem]{
//                    calculatedValues.append((secandValue / firstValue) * amount)
//                }
//            }
//        }
//        view?.updateScreenWithData()
//    }
}

class HomeViewSpy: NSObject, HomeDelegate, SentBackKeyToHomeDelegate{
    var loaderIsHidden = true
    var errorMessage = ""
    var screenUpdated = false
    func selectCode(code: String) {
        
    }
    
    func updateScreenWithData() {
        screenUpdated = true
    }
    
    func gotAnError(error: String) {
        errorMessage = error
    }
    
    func loaderIsHidden(ishidden: Bool) {
        loaderIsHidden = ishidden
    }
    
    
}
class HomeInteractorMock: NSObject, HomeInteractorDelegate {
    var dataLoaded  = false
    func getData() {
        dataLoaded = true
        
    }
}
class HomeRouterMock: NSObject, HomeRouterDelegate {
    var screenOpend = false
    func openCurrrencyList(delegate: SentBackKeyToHomeDelegate) {
        screenOpend = true
    }
}
