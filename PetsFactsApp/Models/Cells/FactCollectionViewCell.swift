//
//  FactCollectionViewCell.swift
//  PetsFactsApp
//
//  Created by Михаил Фролов on 28.06.2023.
//

import Foundation
import UIKit

class FactsCollectionViewCell: UICollectionViewCell {
    private let factLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Apple SD Gothic Neo", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupViews() {
        contentView.backgroundColor = .systemYellow
        contentView.alpha = 1
        contentView.layer.cornerRadius = 10
        addSubview(factLabel)
    }
    
    private func configure(factLabelText: String) {
        factLabel.text = factLabelText
    }
    
    public func cellConfigure(factLableText: String) {
        configure(factLabelText: factLableText)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            factLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            factLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
