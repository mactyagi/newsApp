//
//  NewsTableViewCell.swift
//  newsApp
//
//  Created by manukant tyagi on 21/10/22.
//

import UIKit
import SDWebImage

class NewsTableViewCell: UITableViewCell {
    
    //MARK: - properties
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var publisherLabel: UILabel!
    @IBOutlet private weak var newsImageView: UIImageView!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        newsImageView.layer.cornerRadius = 5
        // Initialization code
    }
    func populateData(title: String, publisher: String, imageUrl: String, time: String, author: String){
        titleLabel.text = title
        publisherLabel.text = publisher
        let url = URL(string: imageUrl)
        newsImageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "photo.fill.on.rectangle.fill"))
        timeLabel.text = time
        authorLabel.text = "- \(author)"
    }

}
