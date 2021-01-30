//
//  TypeNewsTableViewCell.swift
//  NewsMedia
//
//  Created by Ferrakkem Bhuiyan on 2020-12-09.
//

import UIKit

class NewsDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsType: UILabel!
    @IBOutlet weak var publishDate: UILabel!
    
    private var urlString: String = ""
    var customView = CustomView()
    var roundedLabel = CustomLabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Setup News values
    func setNewsDeatilsCellWithValuesOf(with news :News) {
        //print("news***** \(news)")
        updateUI(title: news.newsTitle, poster: news.newsImage, type: news.typeName, date: news.date)
    }

    //MARK: Update the UI Views
    private func updateUI(title: String?,  poster: String, type: String?, date: String?) {
        self.newsTitle.text = title
        self.newsType.text = type?.capitalized
        self.publishDate.text = date?.fromUTCToLocalDateTime()   //date//convertDateFormater(date)
        urlString = poster

        guard let posterImageURL = URL(string: urlString) else {
            self.newsImage.image = UIImage(named: "noImageFound")
            return
        }

        // Before we download the image we clear out the old one
        self.newsImage.image = nil
        getImageDataFrom(url: posterImageURL)
        customView.customView(userview: cardView)
        roundedLabel.customLabel(userLabel: newsType)
        roundedLabel.customLabel(userLabel: publishDate)

    }
    // MARK: - Get image data
    private func getImageDataFrom(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Handle Error
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                // Handle Empty Data
                print("Empty Data")
                return
            }

            DispatchQueue.main.async {
                if let image = UIImage(data: data){
                    self.newsImage.image = image
                }
            }
        }.resume()
    }
    
    
    
}
