//
//  NewsDataModel.swift
//  newsApp
//
//  Created by manukant tyagi on 21/10/22.
//

import Foundation
struct NewsDataModel: Codable{
    let articles: [Articles]
    let status: String
    let totalResults: Int
}

struct Articles: Codable{
    let source: Sources?
     let author: String?
     let title: String
     let description: String?
     let url: String
     let urlToImage: String?
     let publishedAt: String
     let content: String?
}

struct Sources: Codable{
    let id: String?
    let name: String?
}
