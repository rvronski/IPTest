//
//  Model.swift
//  IPTest
//
//  Created by ROMAN VRONSKY on 14.04.2023.
//

import UIKit

struct List {
    let name: String
    let description: String
    let categoryImage: UIImage
}
extension List {
    static func getData(model: [Answer]) -> [List] {
        var array = [List]()
        for i in model {
            let name = i.name
            let description = i.description
            let categoryImage = {
                let icon = "http://shans.d2.i-partner.ru\(i.categories.icon)"
                let url = URL(string: icon)
                let url2 = URL(string: "http://shans.d2.i-partner.ru/upload/drugs/categories//insekticidi_106266c8.png")
                do {
                    let imageURL = try Data(contentsOf: url ?? url2!)
                    return UIImage(data: imageURL) ?? UIImage(systemName: "person")!
                } catch {
                    print(error)
                }
                return UIImage(systemName: "person")!
            }()
            let list = List(name: name, description: description, categoryImage: categoryImage)
            array.append(list)
            }
        return array
        }
    }


func url(_ string: String) -> String {
    let stringURL = string
    let sIndex = stringURL.firstIndex(of: "s") ?? string.endIndex
    let ind = stringURL.index(sIndex, offsetBy: 3)
    let convert = stringURL[ind...]
    let notConvert =  stringURL[..<ind]
    let convertString = String(convert)
    let notConvertString = String(notConvert)
    let urlConvert = convertString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    return notConvertString + urlConvert
}
