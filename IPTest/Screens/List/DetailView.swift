//
//  DetailView.swift
//  IPTest
//
//  Created by ROMAN VRONSKY on 17.04.2023.
//

import UIKit

class DetailView: UIView {
    
    lazy var categoryImage = CustomImageView()
    lazy var productImage = CustomImageView()
    private lazy var starImage = CustomImageView()
    private lazy var locationImage = CustomImageView()
    private lazy var nameLabel = InfoLabels(inform: "", size: 20, weight: .bold, color: .black)
    private lazy var descriptionLabel = InfoLabels(inform: "", size: 15, weight: .regular, color: .gray)
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .darkGray
        return activityIndicator
    }()
    private lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.setTitle("ГДЕ КУПИТЬ", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 0.7
        button.clipsToBounds = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(model: Answer) {
        self.nameLabel.text = model.name
        self.descriptionLabel.text = model.description
        
    }
       
    private func setupView() {
        self.backgroundColor = .white
        self.addSubview(categoryImage)
        self.addSubview(productImage)
        self.addSubview(starImage)
        self.addSubview(nameLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(button)
        self.button.addSubview(locationImage)
        self.addSubview(activityIndicator)
        
        productImage.contentMode = .scaleAspectFit
        starImage.image = UIImage(systemName: "star")
        starImage.tintColor = .gray
        locationImage.image = UIImage(named: "locationImage")
        NSLayoutConstraint.activate([
            
            categoryImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,constant: 40),
            categoryImage.leftAnchor.constraint(equalTo: self.leftAnchor ,constant: 35),
            categoryImage.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.074),
            categoryImage.heightAnchor.constraint(equalTo: self.categoryImage.widthAnchor),
            
            productImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,constant: 40),
            productImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            productImage.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.3),
            productImage.heightAnchor.constraint(equalTo: self.productImage.widthAnchor, multiplier: 1.56),
            
            starImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,constant: 40),
            starImage.rightAnchor.constraint(equalTo: self.rightAnchor ,constant: -35),
            starImage.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.074),
            starImage.heightAnchor.constraint(equalTo: self.starImage.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: self.productImage.bottomAnchor,constant: 32),
            nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor ,constant: 14),
            
            descriptionLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor,constant: 8),
            descriptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 14),
            descriptionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30),
            
            button.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 20),
            button.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            button.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            button.heightAnchor.constraint(equalToConstant: 50),
            
            locationImage.centerYAnchor.constraint(equalTo: self.button.centerYAnchor),
            locationImage.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -70),
            
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: productImage.centerYAnchor)
            
        ])
    }
}
