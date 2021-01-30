//
//  NewsDetailsViewController.swift
//  NewsMedia
//
//  Created by Ferrakkem Bhuiyan on 2020-12-08.
//

import UIKit
import SkeletonView

class NewsDetailsViewController: UIViewController {
    var newsType = ""
    private var newsTypeViewModel = NewsTypeViewModel()
    @IBOutlet weak var typeNewsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.title = newsType
        newsTypeViewModel.searchNews(type: newsType)
        setTableView()
    }

    //MARK: - setTableView
    func setTableView(){
        typeNewsTableView.register(UINib(nibName: K.detailsNewsCellNibName, bundle: nil), forCellReuseIdentifier: K.detailsNewsCellCellReuseIdentifier)
        typeNewsTableView.separatorStyle = .none
        typeNewsTableView.reloadData()
    }
}

//MARK: - UITableViewDelegate & UITableViewDataSource
extension NewsDetailsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dataCount = newsTypeViewModel.numberOfRows(inSection: section)
        if dataCount == 0 {
            self.typeNewsTableView.setEmptyMessage("Nothing to show :(")
        } else {
            self.typeNewsTableView.restore()
        }
        return dataCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = typeNewsTableView.dequeueReusableCell(withIdentifier:K.detailsNewsCellCellReuseIdentifier , for: indexPath) as! NewsDetailsTableViewCell
        let newsDetails = newsTypeViewModel.cellForRowAt(indexPath: indexPath)
        cell.setNewsDeatilsCellWithValuesOf(with: newsDetails)
        return cell
        
    }
    
}
