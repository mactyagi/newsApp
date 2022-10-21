//
//  NewsViewController.swift
//  newsApp
//
//  Created by manukant tyagi on 21/10/22.
//

import UIKit

class NewsViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    let newsViewModel = NewsViewModel()
    let totalArticles = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        callAPI()
    }
    
    
    //MARK: - Get data from API
    func callAPI(){
        // increase the page
        newsViewModel.page += 1
        
        // start activity indicator
        tableView.refreshControl?.beginRefreshing()
        
        // fetch news
        newsViewModel.fetchTopHeadlinesNews { [weak self] result in
            DispatchQueue.main.async {
                self?.tableView.refreshControl?.endRefreshing()
                switch result{
                case .success(_):
                    self?.updateUI()
                case .failure(let error):
                    self?.showToast(message: error.localizedDescription)
                }
            }
            
        }
    }
    
    //MARK: - update the UI
    func updateUI(){
        tableView.reloadData()
    }
    

}


// MARK: - Table View Data Source
extension NewsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsViewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableViewCell
        let articles = newsViewModel.articles
        let article = articles[indexPath.row]
        cell.populateData(title: article.title, publisher: article.source?.name ?? "No Publisher Found", imageUrl: article.urlToImage ?? "", time: "7h", author: article.author ?? "No Author")
        
        if articles.count - indexPath.row == 5{
            newsViewModel.totalArticles == articles.count ? showToast(message: "Finish") : callAPI()
        }
        
         return cell
    }
    
    
}


//MARK: - Table View Delegate
extension NewsViewController: UITableViewDelegate{
    
}
