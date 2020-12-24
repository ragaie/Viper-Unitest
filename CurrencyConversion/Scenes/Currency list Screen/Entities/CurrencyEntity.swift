//
//  CurrencyEntity.swift
//  CurrencyConversion
//
//  Created by Ragaie Alfy on 12/3/20.
//

import Foundation

struct Currencies:Codable {
    var success: Bool?
    var terms: String?
    var privacy: String?
    var currencies: [String: String]?
}
