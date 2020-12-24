//
//  quotes.swift
//  CurrencyConversion
//
//  Created by Ragaie Alfy on 12/4/20.
//

import Foundation
struct QuoteEntity: Codable {
    var success: Bool?
    var terms: String?
    var privacy: String?
    var timestamp: Int?
    var source: String?
    var quotes: [String: Float]?
}
