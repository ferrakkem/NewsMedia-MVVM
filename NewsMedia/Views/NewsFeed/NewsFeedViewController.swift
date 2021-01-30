//
//  ViewController.swift
//  NewsMedia
//
//  Created by Ferrakkem Bhuiyan on 2020-12-04.
//

import UIKit
import SkeletonView

class NewsFeedViewController: UIViewController {
    //realm
    
    private var newsViewModel = NewsViewModel()
    
    private var networkManager = NetwrokManager()
    @IBOutlet weak var newsFeedTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTableView()

    }
    
    func setTableView(){
        newsFeedTableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellReuseIdentifier)
        newsFeedTableView.separatorStyle = .none
        newsFeedTableView.reloadData()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        checkInternetConnectivity()
    }
    
    //MARK: - For paginatin data
    func loadMoreNewsItemsForList(page: Int){
    }
    
    func loadOnlineNewsData(){
        newsViewModel.newsData{ [weak self] in
            self?.newsFeedTableView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.50))
            self?.newsFeedTableView.reloadData()
        }
    }
    
    func offLineNewsData(){
        self.newsViewModel.loadNews()
        DispatchQueue.main.async {
            self.newsFeedTableView.reloadData()
        }
    }
    
    @IBAction func refereshBtnPressed(_ sender: UIBarButtonItem) {
        checkInternetConnectivity()
    }
    
    //MARK: - kInternetConnectivity check
    func checkInternetConnectivity(){
        let isConnection = InternetConnectionManager.isConnectedToNetwork()
        
        if isConnection{
            loadOnlineNewsData()
        }else{
            //print("Not Connected")
            self.openAlert(title: "InterNet Connection Error", message: "", alertStyle: .actionSheet, actionTitles: ["Load from local", "Cancel"], actionStyles:[.default, .cancel], actions: [
                {_ in
                    self.offLineNewsData()
                },
                {_ in
                     //print("cancel")
                }
           ])
        }
    }
}

//MARK: UITableViewDelegate & UITableViewDataSource
extension NewsFeedViewController: UITableViewDelegate, SkeletonTableViewDataSource{
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return K.cellReuseIdentifier
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dataCount = newsViewModel.numberOfRowsInSection(section: section)
        
        if dataCount == 0 {
            self.newsFeedTableView.setEmptyMessage("Nothing to show :(")
        } else {
            self.newsFeedTableView.restore()
        }
        return dataCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
        let cell = newsFeedTableView.dequeueReusableCell(withIdentifier: K.cellReuseIdentifier, for: indexPath) as! NewsFeedTableViewCell
        let news = newsViewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(with: news)
        
        return cell
    }
}


