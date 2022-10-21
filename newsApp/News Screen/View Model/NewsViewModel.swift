//
//  NewsViewModel.swift
//  newsApp
//
//  Created by manukant tyagi on 21/10/22.
//

import Foundation
class NewsViewModel{
    var articles = [Articles]()
    var page = 0
    var searchString = "india"
    var totalArticles = 0
    
}


extension NewsViewModel{
    func fetchTopHeadlinesNews(completion: @escaping(Result<[Articles], Error>)->()){
        var extensionUrl = "&page=\(page)"
        if searchString.count > 0{
            extensionUrl += "&q=\(searchString)"
        }
        
        HTTPManager.shared.getAPI(urlString: baseURL + extensionUrl) { [weak self] result in
            guard let self = self else {return}
            switch result{
            case .success(let data):
                let decoder = JSONDecoder()
                do{
                    let parseData = try decoder.decode(NewsDataModel.self, from: data)
                    self.articles += parseData.articles
                    self.totalArticles = parseData.totalResults
                    completion(.success(parseData.articles))
                    print(parseData)
                }catch{
                    completion(.failure(error))
                    print(error)
                }
                
            case .failure(let error):
                completion(.failure(error))
                self.page -= 1
                print(error)
            }
        }
    }
}
