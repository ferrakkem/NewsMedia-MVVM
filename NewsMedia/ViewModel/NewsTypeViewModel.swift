//
//  NewsTypeViewModel.swift
//  NewsMedia
//
//  Created by Ferrakkem Bhuiyan on 2020-12-08.
//

import Foundation
import RealmSwift

class NewsTypeViewModel{

    var newsType = [News]()
    
    func getNewsType(){
        newsType = DatabaseManager.shared.getNewsType()
    }
    
    func searchNews(type: String){
        newsType = DatabaseManager.shared.searchNews(type: type)
    }

    func numberOfRowsInSection(section: Int) -> Int {
        if newsType.count != 0{
            return newsType.count
        }
        return 0
    }
    
    func cellForRowAt (indexPath: IndexPath) -> News {
        return newsType[indexPath.row]
    }
    
    func numberOfRows(inSection section: Int) -> Int {
        return newsType.count
    }
    
    func didSelect(at indexPath: Int) -> News {
        return newsType[indexPath]
    }
    
}

