//
//  Model.swift
//  IPTest
//
//  Created by ROMAN VRONSKY on 14.04.2023.
//

import UIKit

struct ListImages {
    let image: UIImage
}
extension ListImages {
    static func getData(model: [Answer]) -> [ListImages] {
        var array = [ListImages]()
        for i in model {
            let imageUrl = {
                let img = url(i.image)
//                print(i.image)
//                print(img)
                let image = "http://shans.d2.i-partner.ru\(img.utf8)"
                let url =  URL(string: image)
                print(url)
                let url2 = URL(string: "http://shans.d2.i-partner.ru/upload/drugs//%D0%94%D0%B8%D1%88%D0%B0%D0%BD%D1%81_ce960df6.png")
                do {
                    let imageURL = try Data(contentsOf: url ?? url2!)
                    return UIImage(data: imageURL) ?? UIImage(systemName: "person")!
                } catch {
                    print(error)
                }
                return UIImage(systemName: "person")!
            }()
            let listImage = ListImages(image: imageUrl)
            array.append(listImage)
        }
        return array
    }
}

func url(_ string: String) -> String {
    var stringURL = string
    var sIndex = stringURL.firstIndex(of: "s") ?? string.endIndex
    var ind = stringURL.index(sIndex, offsetBy: 3)
    var convert = stringURL[ind...]
    let notConvert =  stringURL[..<ind]
    var convertString = String(convert)
    var notConvertString = String(notConvert)
    let urlConvert = convertString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    return notConvertString + urlConvert
}
