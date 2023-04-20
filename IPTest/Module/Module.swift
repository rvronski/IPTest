//
//  Module.swift
//  IPTest
//
//  Created by ROMAN VRONSKY on 20.04.2023.
//

import UIKit

protocol ViewModelProtocol: AnyObject {}

struct Module {
    
    enum ModuleType {
        case list
    }
    
    let moduleType: ModuleType
    let viewModel: ViewModelProtocol
    let view: UIViewController
    
}
