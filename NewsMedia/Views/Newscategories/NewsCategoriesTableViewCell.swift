//
//  NewsCategoriesTableViewCell.swift
//  NewsMedia
//
//  Created by Ferrakkem Bhuiyan on 2020-12-08.
//

import UIKit

class NewsCategoriesTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    //MARK: - setup Type value
    func setCellWithValuesOfCollection(with news: News) {
        //print("setCellWithValuesOfCollection***** \(news)")
        updateUI(type: news.typeName)
    }
    
    //MARK: - UpdateUI
    func updateUI(type: String?){
        self.textLabel?.text = type?.capitalized
    }
    
}
