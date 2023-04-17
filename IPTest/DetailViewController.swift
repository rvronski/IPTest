//
//  DetailViewController.swift
//  IPTest
//
//  Created by ROMAN VRONSKY on 17.04.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    let list: List
    let image: UIImage
    
    init(list: List, image: UIImage) {
        self.list = list
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        detailView.setup(model: list, Image: image)

       
    }
    

   
}
