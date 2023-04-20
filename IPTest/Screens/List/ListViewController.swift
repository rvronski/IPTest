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
                self.listView.activityIndicator.isHidden = true
                self.listView.activityIndicator.stopAnimating()
                self.listView.collectionView.reloadData()
            }
        }
    }
    
    private lazy var listView: ListView = {
       let view = ListView()
        return view
    }()
    
    override func loadView() {
        super.loadView()
        self.view = listView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        listView.configureCollectionView(dataSource: self, delegate: self)
        loadingList()
    }
    
    private func loadingList() {
        self.listView.notFoundLabel.isHidden = true
        self.listView.activityIndicator.isHidden = false
        self.listView.activityIndicator.startAnimating()
        viewModel.getData(networkPath: .list, stringURL: nil) { [weak self] answer, data in
            guard let answer else { return }
            self?.list = answer
        }
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .white
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
}
extension ListViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.identifire, for: indexPath) as! ListCollectionViewCell
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
        listView.notFoundLabel.isHidden = true
        self.listView.activityIndicator.isHidden = false
        self.listView.activityIndicator.startAnimating()
        viewModel.getSearch(searchText: searchText) { [weak self] answer in
            if answer.isEmpty {
                DispatchQueue.main.async {
                    self?.list = answer
                    self?.listView.notFoundLabel.isHidden = false
                }
            } else {
                self?.list = answer
            }
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


