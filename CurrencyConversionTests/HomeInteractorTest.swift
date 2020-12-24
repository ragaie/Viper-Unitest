//
//  HomeInteractorTest.swift
//  CurrencyConversionTests
//
//  Created by Ragaie Alfy on 12/4/20.
//

import XCTest
@testable import CurrencyConversion

class HomeInteractorTest: XCTestCase {
    var presenter: HomePresenterMock!
    var service: HomeServiceMock!
    var interactor:HomeInteractor!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        presenter = HomePresenterMock()
        service = HomeServiceMock()
        interactor = HomeInteractor(service: service, preseenter: presenter)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetDataWithoutError() throws {
        interactor.getData()
        XCTAssertTrue(presenter.items != nil)
    }
    func testGetDataWithError() throws {
        service.fileName = "dfd"
        interactor.getData()
        XCTAssertEqual(presenter.errorMessage, "The operation couldn’t be completed. (failed to open file error 0.)")
        //The operation couldn’t be completed. (failed to open file error 0.)
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

class HomePresenterMock: NSObject, HomeInteractorToPresenterDelegate {
    var errorMessage = ""
    var items : [String : Float]?
    func gotAnError(error: String) {
        errorMessage = error
    }
    
    func gotData(items: [String : Float]) {
        self.items = items
    }
    
 
    
}

class HomeServiceMock: NSObject, ServiceManagerDelegate {
    var fileName = "LiveMock"
    func requestDataWith<T>(way: HttpMothed, endPoint: String, parameters: [String : Any], classType: T.Type, completionHandler: @escaping (T?, Data?, URLResponse?, Error?) -> Void) where T : Decodable, T : Encodable {
        
      //  let fileName =  getQueryStringParameter(url: endPoint, param: "term")
         if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
             do {
                 let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                 let    responseObject = try JSONDecoder().decode(T.self, from: data)
                 completionHandler(responseObject, data, nil, nil)
             } catch let error {
                 completionHandler(nil, nil, nil, error)}
         }
         else{
             let errorTemp = NSError(domain:"failed to open file", code: 0, userInfo:nil)
             completionHandler(nil, nil, nil, errorTemp)

         }
    }
    
    
}
