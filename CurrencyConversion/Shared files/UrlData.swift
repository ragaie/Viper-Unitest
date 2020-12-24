//
//  UrlData.swift
//  FinishTask
//
//  Created by Ragaie Alfy on 12/3/20.
//

import UIKit

class UrlData: NSObject {
    static var baseEndPoint: String! = "http://api.currencylayer.com/"
    static var accessToken = "53ac2b0cdee1e257eab4b3667f6da85c"
    static func  live() -> String {
        return baseEndPoint + "live?access_key=\(accessToken)"
    }
    static func  list() -> String {
        return baseEndPoint + "list?access_key=\(accessToken)"
    }
}
