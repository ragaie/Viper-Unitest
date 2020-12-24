//
//  CachedData.swift
//  CurrencyConversion
//
//  Created by Ragaie Alfy on 12/3/20.
//

import UIKit

class CachedData: NSObject {
    func getDataWith<T>(endPoint: String, classType: T.Type, completionHandler: @escaping (T?, Data?, Error?) -> Void) where T: Decodable, T: Encodable {
        let path = FileManager.default.urls(for: .documentDirectory,
                                            in: .userDomainMask)[0].appendingPathComponent(endPoint + ".json")
        do {
            let data = try Data(contentsOf: path, options: .mappedIfSafe)
            let    responseObject = try JSONDecoder().decode(T.self, from: data)
            completionHandler(responseObject, data, nil)
        } catch let error {
            completionHandler(nil, nil, error)}
}
    func saveDataFor(endPoint: String, data: Data) {
        let path = FileManager.default.urls(for: .documentDirectory,
                                            in: .userDomainMask)[0].appendingPathComponent(endPoint + ".json" )
        do {
            try data.write(to: path)
        } catch {
            // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
        }
}
}
