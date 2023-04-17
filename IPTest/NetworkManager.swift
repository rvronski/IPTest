//
//  NetworkManager.swift
//  IPTest
//
//  Created by ROMAN VRONSKY on 14.04.2023.
//

import Foundation

/*
 {
 "id": 45,
 "image": "/upload/drugs//Беташанс дабл_bcf434a5.png",
 "categories": {
 "id": 4,
 "icon": "/upload/drugs/categories//gerbicidi_fb835dfd.png",
 "image": "/upload/drugs/categories//Гербицид_f3caea59.png",
 "name": "Гербициды"
 },
 "name": "БЕТАШАНС ДАБЛ, КЭ",
 "description": "Гербицид для подавления в посевах сахарной свеклы однолетних двудольных сорняков.",
 "documentation": "/upload/drugs/documentation/Беташанс Дабл, КЭ. Свидетельство о регистрации от 25.10.2018_bcf434a5.pdf",
 "fields": [
 {
 "types_id": 2,
 "type": "text",
 "name": "Действующее вещество",
 "value": "160 г/л фенмедифама + 160 г/л десмедифама",
 "image": "/upload/content/types/2022-06/Mask group_4879d2fc.png",
 "flags": {
 "html": 0,
 "no_value": 0,
 "no_name": 0,
 "no_image": 0,
 "no_wrap": 0,
 "no_wrap_name": 0,
 "system": 0
 },
 "show": 100,
 "group": 1
 },
 */

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
//    let documentation: String
//    let fields: [Fields]
    
}

func getList(complition: @escaping ([Answer]) -> Void) {
    
    guard let url = URL(string: "http://shans.d2.i-partner.ru/api/ppp/index/") else {return}
    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: url) { data, response, error in
        if let error {
            print(error.localizedDescription)
            
            return
        }
        let statusCode = (response as? HTTPURLResponse)?.statusCode
        print(statusCode ?? "")
        if statusCode != 200 {
            print("Status Code = \(String(describing: statusCode))")
            return
        }
        guard let data else {
            print("data = nil")
            return
        }
        do {
            let answer = try JSONDecoder().decode([Answer].self, from: data)
            complition(answer)
        } catch {
            print(error)
        }
    }
    task.resume()
    
}
