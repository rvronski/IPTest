//
//  ViewController.swift
//  IPTest
//
//  Created by ROMAN VRONSKY on 14.04.2023.
//

import UIKit

class ViewController: UIViewController {

    private var images = [UIImage]() {
        didSet {
            DispatchQueue.main.async {
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
                self.collectionView.reloadData()
            }
        }
    }
    
    private var list = [List]() {
        didSet {
            print("listEnd")
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
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 16, left: 8, bottom: 16, right: 8)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: "ChekCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        getList { answer in
            for i in answer {
                let imageUrl = {
                    let img = url(i.image)
                    let image = "http://shans.d2.i-partner.ru\(img)"
                    let url = URL(string: image)
                    let url2 = URL(string: "http://shans.d2.i-partner.ru/upload/drugs//%D0%94%D0%B8%D1%88%D0%B0%D0%BD%D1%81_ce960df6.png")
                    do {
                        let imageURL = try Data(contentsOf: url ?? url2!)
                        return UIImage(data: imageURL) ?? UIImage(systemName: "person")!
                    } catch {
                        print(error)
                    }
                    return UIImage(systemName: "person")!
                }()
                self.images.append(imageUrl)
            }
            self.list = List.getData(model: answer)
        }
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(collectionView)
        self.view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
        
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
        
            self.activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        
        ])
    }

}
extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChekCell", for: indexPath) as! ListCollectionViewCell
        cell.setup(model: images[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemWidth = (collectionView.frame.width - 25) / 2
        
        return CGSize(width: itemWidth, height: 200)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let list = self.list[indexPath.row]
        let image = self.images[indexPath.row]
        self.navigationController?.pushViewController(DetailViewController(list: list, image: image), animated: true)
    }
}
