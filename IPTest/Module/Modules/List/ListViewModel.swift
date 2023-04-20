//
//  ListViewModel.swift
//  IPTest
//
//  Created by ROMAN VRONSKY on 20.04.2023.
//

import Foundation

protocol ListViewModelProtocol: ViewModelProtocol {
    func getData(networkPath: NetworkEnvironment, stringURL: String?, complition: @escaping ([Answer]?, Data?) -> Void)
    func pushToDetail()
    func getSearch(searchText: String, completion: @escaping ([Answer]) -> Void)
}

class ListViewModel: ListViewModelProtocol {
    
    var coordinator: AppCoordinator!
    
    private let networkManager: NetworkProtocol
    
    init(networkManager: NetworkProtocol) {
        self.networkManager = networkManager
    }
    
    func pushToDetail() {
        coordinator.goTo(pushTo: .detailVC)
    }
    
    func getData(networkPath: NetworkEnvironment, stringURL: String?, complition: @escaping ([Answer]?, Data?) -> Void) {
        switch networkPath {
        case .list:
            networkManager.getList(apiURL: .list, stringURL: nil, complition: { answer, data  in
                guard let answer else {return}
                complition(answer, nil)
            })
        case .image:
            networkManager.getList(apiURL: .image, stringURL: stringURL, complition: { answer, data  in
                guard let data else {return}
                complition(nil, data)
            })
       
        }
    }
    
    func getSearch(searchText: String, completion: @escaping ([Answer]) -> Void) {
        networkManager.getSearch(searchText: searchText) { answer in
            completion(answer)
        }
    }
}
