//
//  ViewController.swift
//  IPTest
//
//  Created by ROMAN VRONSKY on 14.04.2023.
//

import UIKit

class ListViewController: UIViewController {
    
    var viewModel: ListViewModelProtocol
    
    init(viewModel: ListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var searchController = UISearchController(searchResultsController: nil)
    
    private var list = [Answer]() {
        didSet {
            DispatchQueue.main.async {
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
                self.collectionView.reloadData()
            }
        }
    }
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .darkGray
        return activityIndicator
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: "ChekCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        viewModel.getData(networkPath: .list, stringURL: nil) { answer, data in
            guard let answer else { return }
            self.list = answer
        }
    }
    
    private func setupView() {
        navigationController?.navigationBar.tintColor = .white
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        self.view.backgroundColor = .systemGreen
        self.view.addSubview(collectionView)
        self.view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            
            self.activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            
        ])
    }
    
}
extension ListViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChekCell", for: indexPath) as! ListCollectionViewCell
        cell.delegate = self
        cell.setup(model: list[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemWidth = (collectionView.frame.width - 48) / 2
        
        return CGSize(width: itemWidth, height: 300)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let list = self.list[indexPath.row]
        
        viewModel.pushToDetail(list: list)
    }
}

extension ListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        viewModel.getSearch(searchText: searchText) { answer in
            self.list = answer
        }
    }
}
extension ListViewController: ListCollectionViewDelegate {
    func getImage(stringURL: String, complition: @escaping (Data) -> Void) {
        viewModel.getData(networkPath: .image, stringURL: stringURL) { answer, data in
            guard let data else {return}
            complition(data)
        }
    }
}


