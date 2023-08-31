//
//  InfoCell.swift
//  PetsFactsApp
//
//  Created by Михаил Фролов on 23.08.2023.
//

import Foundation
import UIKit

class InfoCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var factLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateCell(name: String, fact: String) {
        nameLabel.text = name
        factLabel.text = fact
    }
}
