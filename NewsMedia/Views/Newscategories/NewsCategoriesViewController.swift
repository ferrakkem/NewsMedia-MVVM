//
//  NewsCategoriesViewController.swift
//  NewsMedia
//
//  Created by Ferrakkem Bhuiyan on 2020-12-08.
//

import UIKit

class NewsCategoriesViewController: UIViewController {

    private var newsTypeViewModel = NewsTypeViewModel()
    
    var newsTypeName = ""
    @IBOutlet weak var newsTypeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUpNewsTypeTable()
        newsTypeViewModel.getNewsType()
    }
    
    //MARK: - Setup TableView
    func setUpNewsTypeTable(){
        newsTypeTableView.register(UINib(nibName: K.newsTypeCellNib, bundle: nil), forCellReuseIdentifier: K.newsTypeCellReuseIdentifier)
        newsTypeTableView.separatorStyle = .none
        newsTypeTableView.tableFooterView = UIView()
        newsTypeTableView.reloadData()
    }
    
    //MARK: - refreshButton action
    @IBAction func refreshButtonPressed(_ sender: UIBarButtonItem) {
        //setUpNewsTypeTable()
        newsTypeViewModel.getNewsType()
    }
    
}

//MARK: - UITableViewDelegate and UITableViewDataSource
extension NewsCategoriesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dataCount = newsTypeViewModel.numberOfRowsInSection(section: section)
        
        if dataCount == 0 {
            self.newsTypeTableView.setEmptyMessage("Nothing to show :(")
        } else {
            self.newsTypeTableView.restore()
        }
        return dataCount
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTypeTableView.dequeueReusableCell(withIdentifier: K.newsTypeCellReuseIdentifier, for: indexPath) as! NewsCategoriesTableViewCell
        let newsType = newsTypeViewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOfCollection(with: newsType)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = newsTypeViewModel.didSelect(at: indexPath.row)
        //let index = newsTypeViewModel.cellForRowAt(indexPath: indexPath)
        newsTypeName = index.typeName
        performSegue(withIdentifier: K.newsDetailsSegueIndentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVc = segue.destination as! NewsDetailsViewController
        //print("**newsTypeName: \(newsTypeName)")
        destinationVc.newsType = newsTypeName

    }
    
    
}


