//
//  StorageViewController.swift
//  PetsFactsApp
//
//  Created by Михаил Фролов on 02.07.2023.
//

import UIKit

class StorageViewController: UIViewController {
    @IBOutlet weak var storageStatusLabel: UILabel!
    @IBOutlet weak var tipToClearLabel: UILabel!
    
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var clearStorageButton: UIButton!
    
    private let coreDataManager = CoreDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    private func setupButtons() {
        
    }
    
    private func deactivateDownloadButton() {
        downloadButton.isEnabled = false
        downloadButton.backgroundColor = UIColor.systemGray
    }
    private func activateDownloadButton() {
        downloadButton.isEnabled = true
        downloadButton.backgroundColor = UIColor.systemBlue
    }
    private func storageStatusWithData() {
        storageStatusLabel.text = "Data stored"
        storageStatusLabel.textColor = UIColor.systemGreen
    }
    private func sorageStatusNoData() {
        storageStatusLabel.text = "No data stored"
        storageStatusLabel.textColor = UIColor.systemGray
    }
    
    @IBAction func downloadButtonPressed(_ sender: Any) {
        coreDataManager.saveData()
        deactivateDownloadButton()
        storageStatusWithData()
        clearStorageButton.isHidden = false
        tipToClearLabel.isHidden = false
    }
    @IBAction func clearStorageButoonPressed(_ sender: Any) {
        coreDataManager.deleteData()
        activateDownloadButton()
        sorageStatusNoData()
        tipToClearLabel.isHidden = true
        clearStorageButton.isHidden = true
    }
}
