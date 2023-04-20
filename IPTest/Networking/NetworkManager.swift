//
//  NetworkManager.swift
//  IPTest
//
//  Created by ROMAN VRONSKY on 14.04.2023.
//

import Foundation

protocol NetworkProtocol: AnyObject {
    func getList(apiURL: NetworkEnvironment, stringURL: String?, complition: @escaping ([Answer]?,Data?) -> Void)
    func getSearch(searchText: String, complition: @escaping ([Answer]) -> Void)
}

class NetworkManager: NetworkProtocol {
    
    func getList(apiURL: NetworkEnvironment, stringURL: String?=nil, complition: @escaping ([Answer]?,Data?) -> Void) {
        if apiURL == .list {
            guard let url = URL(string: apiURL.rawValue ) else {return}
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
                    complition(answer, nil)
                } catch {
                    print(error)
                }
            }
            task.resume()
        }
        if apiURL == .image {
            guard let stringURL else { return }
            let imgURL = url(stringURL)
            guard let url = URL(string: apiURL.rawValue + imgURL) else {return}
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
                complition(nil, data)
            }
            task.resume()
        }
    }
    func getSearch(searchText: String, complition: @escaping ([Answer]) -> Void) {
        let string = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        print(string)
        guard let url = URL(string: "http://shans.d2.i-partner.ru/api/ppp/index/?search=\(string)") else {return}
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
}
