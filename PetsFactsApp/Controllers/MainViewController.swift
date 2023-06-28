//
//  MainViewController.swift
//  PetsFactsApp
//
//  Created by Михаил Фролов on 25.06.2023.
//

import UIKit
import Alamofire

class MainViewController: UIViewController {
    let manager = NetworkFetchService()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func catButtonPressed(_ sender: Any) {
        guard let destinationVC = self.storyboard?.instantiateViewController(identifier: "InformationViewController") as? InformationViewController else { return }
        destinationVC.pet = "CAT"        
        manager.requestCatData(completion: { [weak self] (data, error) in
            if let data = data {
            destinationVC.catFacts = data
            }
            self?.navigationController?.pushViewController(destinationVC, animated: true)
        })
    }
    
    @IBAction func dogButtonPressed(_ sender: Any) {
        guard let destinationVC = self.storyboard?.instantiateViewController(identifier: "InformationViewController") as? InformationViewController else { return }
        destinationVC.pet = "DOG"
        manager.requestDogData(completion: { [weak self] (data, error) in
            if let data = data {
            destinationVC.dogFacts = data
            }
            self?.navigationController?.pushViewController(destinationVC, animated: true)
        })
    }
}
