//
//  DetailViewModel.swift
//  newsApp
//
//  Created by manukant tyagi on 21/10/22.
//

import Foundation
import SDWebImage
class DetailViewModel{
    var article: Article?
    init (article: Article? = nil){
        self.article = article
    }
}
 
extension DetailViewModel{
    func configure(_ view: DetailView){
        guard let article = article else { return }
        view.authorLabel.text = "- \(article.author ?? "No Author")"
        view.titleLabel.text = article.title
        
        // add description two time, just to enable scroll View
        view.descriptionUILabel.text = (article.description ?? "No Description Available") + " " + (article.description ?? "")
        view.timeLabel.text = changeDateToRemainTime(string: article.publishedAt)
        let url = URL(string: article.urlToImage ?? "")
        view.imageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "photo.fill.on.rectangle.fill"))
    }
    
    
    
    func changeDateToRemainTime(string: String) -> String{
        let dateFormatter = DateFormatter()
          dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
          dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if  let date = dateFormatter.date(from:string){
            return Date().offset(from: date)
        }
        return ""
        
    }
    
    
}
