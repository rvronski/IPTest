//
//  Model.swift
//  IPTest
//
//  Created by ROMAN VRONSKY on 14.04.2023.
//

import UIKit

struct List {
    let name: String
    let image: UIImage
    let description: String
    let categoryIcon: UIImage
    let categoryImage: UIImage
}
extension List {
    static func getData(model: [Answer]) -> [List] {
        var array = [List]()
        for i in model {
            let name = i.name
            let image = getImage(stringURL: i.image)
            let description = i.description
            let categoryIcon = getImage(stringURL: i.categories.icon)
            let categoryImage = getImage(stringURL: i.categories.image)
            let list = List(name: name, image: image, description: description, categoryIcon: categoryIcon, categoryImage: categoryImage)
            array.append(list)
        }
        return array
    }
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

func getImage(stringURL: String) -> UIImage {
    let img = url(stringURL)
    let image = "http://shans.d2.i-partner.ru\(img)"
    let url = URL(string: image)
    let url2 = URL(string: "http://shans.d2.i-partner.ru/upload/drugs//%D0%94%D0%B8%D1%88%D0%B0%D0%BD%D1%81_ce960df6.png")
    do {
        let imageURL = try Data(contentsOf: url ?? url2!)
        return UIImage(data: imageURL) ?? UIImage(systemName: "person")!
    } catch {
        print(error)
    }
    return UIImage(systemName: "person")!
}
