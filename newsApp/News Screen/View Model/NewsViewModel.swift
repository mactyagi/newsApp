//
//  NewsViewModel.swift
//  newsApp
//
//  Created by manukant tyagi on 21/10/22.
//

import Foundation
public class NewsViewModel{
    var articles = [Article]()
    var page = 1
    var searchString = ""
    var totalArticles = 0
    var isSearch: Bool{
        searchString.count > 0
    }
    
}


extension NewsViewModel{
    func fetchTopHeadlinesNews(completion: @escaping(Result<[Article], Error>)->()){
        var extensionUrl = "&page=\(page)&q=india"
        if searchString.count > 0{
            searchString = searchString.replacingOccurrences(of: " ", with: "+")
            extensionUrl += "+\(searchString)"
        }
        
        HTTPManager.shared.getAPI(urlString: baseURL + extensionUrl) { [weak self] result in
            guard let self = self else {return}
            switch result{
            case .success(let data):
                let decoder = JSONDecoder()
                do{
                    let parseData = try decoder.decode(NewsDataModel.self, from: data)
                    if self.page > 1{
                        self.articles += parseData.articles
                    }else{
                        self.articles = parseData.articles
                    }
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
    
    func changeDateToRemainTime(string: String) -> String{
        let dateFormatter = DateFormatter()
          dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
          dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from:string){
            return Date().offset(from: date)
        }
        return ""
        
    }
}
