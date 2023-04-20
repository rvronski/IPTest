//
//  ListCollectionViewCell.swift
//  IPTest
//
//  Created by ROMAN VRONSKY on 14.04.2023.
//

import UIKit

protocol ListCollectionViewDelegate: AnyObject {
    func getImage(stringURL: String, complition: @escaping (Data) -> Void)
}

class ListCollectionViewCell: UICollectionViewCell {
    
    var delegate: ListCollectionViewDelegate?
    
    private lazy var imageView = CustomImageView()
    private lazy var nameLabel = InfoLabels(inform: "", size: 20, weight: .bold, color: .black)
    private lazy var descriptionLabel = InfoLabels(inform: "", size: 15, weight: .regular, color: .gray)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(model: Answer) {
        self.nameLabel.text = model.name
        self.descriptionLabel.text = model.description
        delegate?.getImage(stringURL: model.categories.image) { data in
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data)
            }
        }
    }
   
    private func setupView() {
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.contentView.layer.shadowRadius = 5
        self.contentView.layer.shadowColor = UIColor.gray.cgColor
        self.contentView.layer.shadowOpacity = 0.2
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(descriptionLabel)
        
        imageView.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
        
            self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12),
            self.imageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 12),
            self.imageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -12),
            self.imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor, multiplier: 0.58),
            
            self.nameLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 12),
            self.nameLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 12),
            self.nameLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -12),
            
            self.descriptionLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 6),
            self.descriptionLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 12),
            self.descriptionLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -12),
            self.descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10)
        
            
        ])
    }
    
}
