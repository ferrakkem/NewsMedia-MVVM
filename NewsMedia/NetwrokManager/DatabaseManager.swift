//
//  NewsViewModel.swift
//  NewsMedia
//
//  Created by Ferrakkem Bhuiyan on 2020-12-06.
//

import RealmSwift

class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let realm = try! Realm()
    var news: Results<News>?
    
    // MARK: - Lifecycle
    private init() {}
    
    // MARK: - Delete Realm Objects
    func delete() {
        try! realm.write {
          realm.deleteAll()
        }
    }
    
    //MARK: - Saving favourite gip
    func saveNewsToLocal(id: Int, title: String,  imageUrl: String, date: String , newsType:String){
        
        let isExists = objectExists(id: id)
        if isExists{
                //print("isExists : \(isExists)")
        }else{
            let newsInfo = News()
            newsInfo.id = id
            newsInfo.newsTitle = title
            newsInfo.newsImage = imageUrl
            newsInfo.date = date
            newsInfo.typeName = newsType
            save(with: newsInfo)
        }
    }
    
    //MARK: - Saving data
    func save(with news: News){
        do{
            try realm.write{
                realm.add(news)
                //realm.add(gipy, update: Realm.UpdatePolicy.modified)
            }
        }catch{
            print("Error during saving time: \(error)")
        }
    }
    
    //MARK: - loadNews
    func getNews() -> [News]{
        return Array(realm.objects(News.self))

    }
    
    //MARK: - check is object Exists or not
    func objectExists(id: Int) -> Bool{
        return realm.object(ofType: News.self, forPrimaryKey: id) != nil
    }
    
    //MARK: - Get only news Type
    func getNewsType() -> [News]{
        return Array(realm.objects(News.self).distinct(by: ["typeName"]))

    }
    
    //MARK: -Get news according to news type selected
    func searchNews(type: String) -> [News]{
        return Array(realm.objects(News.self).filter("typeName == %@", type))
    }
    

}
