//
//  AppCoordinator.swift
//  IPTest
//
//  Created by ROMAN VRONSKY on 20.04.2023.
//

import UIKit

final class ListViewCoordinator: Coordinatable {
    
    enum PushVC {
        case detailVC(ViewModelProtocol, Answer)
    }
    
    private(set) var coordinators: [Coordinatable] = []
    private(set) var module: Module?
    private let factory: AppFactory
    
    var navigationController: UINavigationController
    
    init(factory: AppFactory, navigationController: UINavigationController) {
        self.factory = factory
        self.navigationController = navigationController
        
    }
    
    func start() -> UIViewController {
        let module = factory.makeModule(ofType: .list)
        let viewController = module.view
        (module.viewModel as! ListViewModel).coordinator = self
        self.module = module
        return viewController
    }
    
    func goTo(pushTo: PushVC) {
        switch pushTo {
        case let .detailVC(viewModel,answer):
            let viewControllerToPush = DetailViewController(viewModel: viewModel as! ListViewModelProtocol, list: answer)
            (module!.view as? UINavigationController)?.pushViewController(viewControllerToPush, animated: true)
        }
    }
    
    func addCoordinator(coordinator: Coordinatable) {
        guard coordinators.contains(where: { $0 === coordinator }) else {
            return
        }
        coordinators.append(coordinator)
    }
    
    func removeCoordinator() {
        coordinators.removeAll()
    }
}
