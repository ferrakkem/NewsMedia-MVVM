//
//  News.swift
//  NewsMedia
//
//  Created by Ferrakkem Bhuiyan on 2020-12-07.
//

import Foundation
import RealmSwift

class News: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var newsTitle: String = ""
    @objc dynamic var newsImage: String = ""
    @objc dynamic var date: String = ""
    @objc dynamic var typeName: String = ""
    
    override class func primaryKey() -> String {
        return "id"
    }
}
