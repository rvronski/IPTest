//
//  DetailView.swift
//  IPTest
//
//  Created by ROMAN VRONSKY on 17.04.2023.
//

import UIKit

class DetailView: UIView {

    private lazy var categoryImage = CustomImageView()
    private lazy var productImage = CustomImageView()
    private lazy var starImage = CustomImageView()
    private lazy var nameLabel = InfoLabels(inform: "", size: 20, weight: .bold, color: .black)
    private lazy var descriptionLabel = InfoLabels(inform: "", size: 15, weight: .regular, color: .gray)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
