//
//  AppFactory.swift
//  IPTest
//
//  Created by ROMAN VRONSKY on 20.04.2023.
//

import UIKit

class AppFactory {
    
    private let networkManager: NetworkProtocol
    
    init(networkManager: NetworkProtocol) {
        self.networkManager = networkManager
    }
    
    func makeModule(ofType moduleType: Module.ModuleType) -> Module {
        switch moduleType {
        case.list:
            let viewModel = ListViewModel(networkManager: networkManager)
            let view = UINavigationController(rootViewController: ListViewController(viewModel: viewModel))
            return Module(moduleType: moduleType, viewModel: viewModel, view: view)
        }
    }
}
