//
//  DetailViewController.swift
//  IPTest
//
//  Created by ROMAN VRONSKY on 17.04.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    var viewModel: ListViewModelProtocol
    var list: Answer
    init(viewModel: ListViewModelProtocol, list: Answer) {
        self.viewModel = viewModel
        self.list = list
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var detailView: DetailView = {
        let view = DetailView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        detailView.setup(model: list)
        getImages(model: list)
    }
    
    private func setupView() {
        self.view.backgroundColor = .systemGreen
        self.view.addSubview(detailView)
        navigationController?.navigationBar.tintColor = .white
        NSLayoutConstraint.activate([
            
            self.detailView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.detailView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.detailView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.detailView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            
        ])
    }
    
    private func getImages(model: Answer) {
        viewModel.getData(networkPath: .image, stringURL: model.categories.icon) { [weak self] answer, data in
            guard let data else {return}
            DispatchQueue.main.async {
                self?.detailView.categoryImage.image = UIImage(data: data)
            }
        }
        viewModel.getData(networkPath: .image, stringURL: model.image) { [weak self] answer, data  in
            guard let data else {return}
            DispatchQueue.main.async {
                self?.detailView.productImage.image = UIImage(data: data)
                self?.detailView.activityIndicator.isHidden = true
                self?.detailView.activityIndicator.stopAnimating()
            }
        }
    }
}
