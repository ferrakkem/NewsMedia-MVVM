//
//  NewsModel.swift
//  NewsMedia
//
//  Created by Ferrakkem Bhuiyan on 2020-12-04.
//

import Foundation

// MARK: - NewsModelElement
struct NewsModel: Codable{
    
    let id: Int?
    let title, newsModelDescription: String?
    let sourceID, version: String?
    let publishedAt: Int
    let readablePublishedAt: String?
    let updatedAt: Int
    let readableUpdatedAt: String
    let images: Images
    let embedTypes: String?
    let typeAttributes: TypeAttributes
    let type: String?
    let source: String?

    
    enum CodingKeys: String, CodingKey {
        case id, title
        case newsModelDescription
        case sourceID
        case version, publishedAt, readablePublishedAt, updatedAt, readableUpdatedAt, embedTypes, images,typeAttributes, type, source
    }
}

// MARK: - Images
struct Images: Codable {
    let square140: String

    enum CodingKeys: String, CodingKey {
        case square140 = "square_140"
    }
}

struct TypeAttributes: Codable {
    let imageLarge: String
}
