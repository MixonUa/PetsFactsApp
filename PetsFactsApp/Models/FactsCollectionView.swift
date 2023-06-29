//
//  FactsCollectionView.swift
//  PetsFactsApp
//
//  Created by Михаил Фролов on 28.06.2023.
//

import Foundation
import UIKit

protocol SelectedFactProtocol: AnyObject {
    func selectedFact(indexPath: IndexPath)
}

class FactsCollectionView: UICollectionView {
    
    weak var selectedFactDelegate: SelectedFactProtocol?
        
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        configure()
        register(FactsCollectionViewCell.self, forCellWithReuseIdentifier: "idCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .none
        delegate = self
    }
}

//MARK: - UICollectionViewDelegate

extension FactsCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedFactDelegate?.selectedFact(indexPath: indexPath)
    }
}

extension FactsCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width/2 - 10, height: 60)
    }
}
