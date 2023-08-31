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
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var storageTableView: UITableView!
    
    
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var clearStorageButton: UIButton!
    
    let networkManager = NetworkFetchService()
    
    var catData: [CatModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storageTableView.dataSource = self
        storageTableView.reloadData()
        saveButton.isHidden = true
        
        let data = CoreDataManager.shared.fetchAllCatFacts()
        if data.isEmpty {
            activateDownloadButton()
            sorageStatusNoData()
            tipToClearLabel.isHidden = true
            clearStorageButton.isHidden = true
        }
        else {
            deactivateDownloadButton()
            storageStatusWithData()
            clearStorageButton.isHidden = false
            tipToClearLabel.isHidden = false
            data.forEach { (cat) in
                catData.append(CatModel(name: cat.name, fact: cat.fact, color: cat.color, likes: cat.likes))
            }
        }
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
    
    @IBAction func updateTableView(_ sender: Any) {
        storageTableView.reloadData()
    }
    @IBAction func downloadButtonPressed(_ sender: Any) {
        networkManager.requestCatData(completion: { [weak self] (data, error) in
            if let data = data {
                self?.catData = data
                self?.deactivateDownloadButton()
                self?.storageStatusWithData()
                self?.saveButton.isHidden = false
            }
        })
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        catData.forEach { (data) in
            CoreDataManager.shared.saveCatFact(name: data.name, fact: data.fact, color: data.color, likes: Int64(data.likes))
        }
        
        clearStorageButton.isHidden = false
        tipToClearLabel.isHidden = false
    }
    
    @IBAction func clearStorageButoonPressed(_ sender: Any) {
        CoreDataManager.shared.deleteAllCatFacts()
        activateDownloadButton()
        sorageStatusNoData()
        tipToClearLabel.isHidden = true
        clearStorageButton.isHidden = true
    }
}
extension StorageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catData.isEmpty ? 1 : catData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = storageTableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell", for: indexPath) as! InfoCell
        if catData.isEmpty {
            cell.updateCell(name: "Clear", fact: "Data")
        } else {
            cell.updateCell(name: catData[indexPath.row].name, fact: catData[indexPath.row].fact)
        }
        return cell
    }
}

