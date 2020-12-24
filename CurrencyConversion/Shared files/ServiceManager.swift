//
//  ServiceManager.swift
//  FinishTask
//
//  Created by Ragaie Alfy on 12/1/20.
//
//jackjohnson
//&entity=musicVideo
import Foundation
import UIKit
enum HttpMothed: String {
    case GET
    case POST
}
protocol ServiceManagerDelegate: NSObjectProtocol {
    func requestDataWith<T: Codable> (way: HttpMothed, endPoint: String, parameters: [String: Any],
                                      classType: T.Type,
                                      completionHandler: @escaping (T?, Data?, URLResponse?, Error?) -> Void)
}
class ServiceManager: NSObject, ServiceManagerDelegate {
    func requestDataWith<T: Codable> (way: HttpMothed, endPoint: String, parameters: [String: Any],
                                      classType: T.Type,
                                      completionHandler: @escaping (T?, Data?, URLResponse?, Error?) -> Void) {
//        var swiftUrlString =  baseEndPoint + endPoint
        let newEndPoint =  endPoint.replacingOccurrences(of: " ", with: "%20")

            guard let apiUrl = URL.init(string: newEndPoint) else { return }
            let request = NSMutableURLRequest(url: apiUrl)
            let session = URLSession.shared
            request.httpMethod = way.rawValue
//            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.addValue("application/json", forHTTPHeaderField: "Accept")
//        do { request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
//        } catch {
//        }
        //show loader
             session.dataTask(with: request as URLRequest) { data, response, error in
                guard let data = data else {
                    DispatchQueue.main.async {
                        completionHandler(nil, nil, response, error)
                    }
                    return
                }
                do {
                    #if DEBUG
                    print("//////////////////////")
                    print(endPoint)
                    print("----------------------")
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    #endif
                    //  here replace LoginData with your codable structure.
                        let responseData = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completionHandler(responseData, data, response, error)
                    }
                } catch let err {
                     #if DEBUG
                        print("Error get data for end point\(endPoint)/n", err)
                      #endif
                    DispatchQueue.main.async {
                        completionHandler(nil, nil, response, err)
                    }
                }
                }.resume()
    }
}
