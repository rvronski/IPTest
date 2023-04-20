//
//  NetworkModel.swift
//  IPTest
//
//  Created by ROMAN VRONSKY on 20.04.2023.
//

import Foundation

enum NetworkEnvironment: String {
    case list = "http://shans.d2.i-partner.ru/api/ppp/index/"
    case image = "http://shans.d2.i-partner.ru"
}

struct Categories: Codable {
    let id: Int
    let icon: String
    let image: String
    let name: String
}

struct Fields: Codable {
    let types_id: Int
    let type: String
    let name: String
    let value: String
    let image: String
    let show: Int
    let group: Int
}

struct Answer: Codable {
    let id: Int
    let image: String
    let categories: Categories
    let name: String
    let description: String
}

func url(_ string: String) -> String {
    let stringURL = string
    let sIndex = stringURL.lastIndex(of: "/") ?? string.endIndex
    let ind = stringURL.index(sIndex, offsetBy: 1)
    let convert = stringURL[ind...]
    let notConvert =  stringURL[..<ind]
    let convertString = String(convert)
    let notConvertString = String(notConvert)
    let urlConvert = convertString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    return notConvertString + urlConvert
}
