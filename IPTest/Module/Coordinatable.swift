//
//  Coordinatable.swift
//  IPTest
//
//  Created by ROMAN VRONSKY on 20.04.2023.
//

import UIKit

protocol Coordinatable: AnyObject {
    var coordinators: [Coordinatable] { get }
    func addCoordinator(coordinator: Coordinatable)
    func removeCoordinator()
    func start() -> UIViewController
}

extension Coordinatable {
    func addCoordinator(coordinator: Coordinatable) {}
    func removeCoordinator() {}
}
