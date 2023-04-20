//
//  String.swift
//  IPTest
//
//  Created by ROMAN VRONSKY on 16.04.2023.
//

import Foundation
import UIKit

class CustomImageView: UIImageView {
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
//        contentMode = .scaleAspectFit
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class InfoLabels: UILabel {
    init(inform: String, size: CGFloat, weight: UIFont.Weight, color: UIColor) {
        super.init(frame: .zero)
        text = inform
        textColor = color
        textAlignment = .natural
        translatesAutoresizingMaskIntoConstraints = false
        lineBreakMode = .byWordWrapping
        numberOfLines = 0
        font = UIFont.systemFont(ofSize: size, weight: weight)
        translatesAutoresizingMaskIntoConstraints = false
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
