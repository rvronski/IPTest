//
//  DetailViewController.swift
//  IPTest
//
//  Created by ROMAN VRONSKY on 17.04.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    var list: Answer?
    
    private lazy var detailView: DetailView = {
        let view = DetailView()
        return view
    }()
    
    override func loadView() {
        super.loadView()
        self.view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let list else { return }
        detailView.setup(model: list)
    }
}
