//
//  NewsViewModel.swift
//  NewsMedia
//
//  Created by Ferrakkem Bhuiyan on 2020-12-06.
//

import Foundation
import RealmSwift

class NewsViewModel{
    private var apiService = NetwrokManager()
    private var newsFeed = [NewsModel]()
    var news = [News]()
    
    //MARK: -
    func newsData(completion: @escaping () -> ()) {
        // weak self - prevent retain cycles
        apiService.getNewsData{ [weak self] (result) in
            switch result {
            case .success(let listOf):
                self?.newsFeed = listOf
                listOf .forEach { (newsData) in
                    //MARK: - Persisting data
                    DatabaseManager.shared.saveNewsToLocal(id: newsData.id!, title: newsData.title!, imageUrl: newsData.typeAttributes.imageLarge, date: newsData.readableUpdatedAt, newsType: newsData.type!)
                    self?.loadNews()
                }
                completion()
            case .failure(let error):
                // Something is wrong with the JSON file or the model
                print("Error processing json data: \(error)")
            }
        }
    }
    
    func loadNews(){
        news = DatabaseManager.shared.getNews()
    }

    func numberOfRowsInSection(section: Int) -> Int {
        if news.count != 0 {
            return news.count
        }
        return 0
    }
    
    func cellForRowAt (indexPath: IndexPath) -> News {
        return news[indexPath.row]
    }

    func numberOfRows(inSection section: Int) -> Int {
        return news.count
    }
    
    func didSelect(at indexPath: Int) -> News {
        return news[indexPath]
    }
    
}

