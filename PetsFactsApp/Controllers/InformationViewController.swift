//
//  InformationViewController.swift
//  PetsFactsApp
//
//  Created by Михаил Фролов on 25.06.2023.
//

import UIKit

class InformationViewController: UIViewController {
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    private let collectionView = FactsCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    var pet: String?
    var isCatFactsAsked: Bool = false
    var catFacts: [CatModel] = []
    var dogFacts: [DogModel] = []
    var catStoredFacts: [CatFact]?
    var dogStoredFacts: [DogFact]?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setDelegates()
        setConstraints()
    }

    private func setupViews() {
        containerView.addSubview(collectionView)
        backgroundImage.image = isCatFactsAsked ? UIImage(named: "cat") : UIImage(named: "dog")
        isCatFactsAsked = false
    }
    
    private func setDelegates() {
        collectionView.dataSource = self
        collectionView.selectedFactDelegate = self
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0)
        ])
    }
}

//MARK: - SelectedFactProtocol

extension UIAlertController {

    //Set background color of UIAlertController
    func setBackgroundColor(color: UIColor) {
        if let bgView = self.view.subviews.first, let groupView = bgView.subviews.first, let contentView = groupView.subviews.first {
            contentView.backgroundColor = color
        }
    }
}
extension InformationViewController: SelectedFactProtocol {
    func selectedFact(indexPath: IndexPath) {
        let title = catFacts.isEmpty ?  dogFacts[indexPath.row].name : catFacts[indexPath.row].name
        let message = catFacts.isEmpty ?  dogFacts[indexPath.row].fact : catFacts[indexPath.row].fact
        let color = catFacts.isEmpty ? dogFacts[indexPath.row].color : catFacts[indexPath.row].color
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alertController.setBackgroundColor(color: UIColor(named: color) ?? UIColor.white)
        alertController.addAction(ok)
        present(alertController, animated: true, completion: nil)
    }
}

//MARK: - UICollectionViewDataSource
extension InformationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 0
        if !catFacts.isEmpty {
            count = catFacts.count
        } else if !dogFacts.isEmpty {
            count = dogFacts.count
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "idCell", for: indexPath) as? FactsCollectionViewCell
        else { return UICollectionViewCell() }
        
        let factLableText = catFacts.isEmpty ? "Dog fact №\(indexPath.row+1)" : "Cat fact №\(indexPath.row+1)"
        cell.cellConfigure(factLableText: factLableText)
        return cell
    }
    
    
}
