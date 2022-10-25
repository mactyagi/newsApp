//
//  NewsViewController.swift
//  newsApp
//
//  Created by manukant tyagi on 21/10/22.
//

import UIKit

class NewsViewController: UIViewController{

    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    let newsViewModel = NewsViewModel()
    lazy var searchController = UISearchController()
    var refreshControl = UIRefreshControl()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetup()
        callAPIFirstTime()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    //MARK: - Refresh
    @objc func refresh(){
        callAPIFirstTime()
    }
    
    
    //MARK: - UISetup
    func UISetup(){
        tableView.delegate = self
        tableView.dataSource = self
        searchController.delegate = self
        searchController.searchBar.delegate = self
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching News Data ...")
    }
    
    
    
    //MARK: -  API related Functions
    func callAPI(){
        newsViewModel.fetchTopHeadlinesNews { [weak self] result in
            DispatchQueue.main.async {
                self?.view.activityStopAnimating()
                switch result{
                case .success(_):
                    self?.updateUI()
                case .failure(let error):
                    self?.refreshControl.endRefreshing()
                    self?.showToast(message: error.localizedDescription)
                }
            }
            
        }
    }
    
    func callAPIFirstTime(){
        self.tableView.refreshControl?.beginRefreshing()
        newsViewModel.page = 1
        newsViewModel.searchString = ""
        callAPI()
    }
    
    
//    API call for next Page
    func callNextPageAPI(){
        self.view.activityStartAnimating()  // start activity indicator
        newsViewModel.page += 1   // increase the page
        callAPI() // call api
    }
    
    // search for news
    func searchNewsAPI(searchString: String){
        self.view.activityStartAnimating()   // start activity indicator
        newsViewModel.page = 1
        newsViewModel.searchString = searchString
        callAPI()
    }
    
    
    
    //MARK: - update the UI
    func updateUI(){
        defer{
            refreshControl.endRefreshing()
        }
        if newsViewModel.page > 1 || refreshControl.isRefreshing{
            tableView.reloadSections(IndexSet(integer: 0), with: .none)
            return
        }
        tableView.reloadSections(IndexSet(integer: 0), with: newsViewModel.isSearch ? .left : .right)
    }
    
    
    
    //MARK: - push Detail VC Function
    func pushDetailVC(article: Article){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.viewModel = DetailViewModel(article: article)
        vc.title = article.source?.name ?? "Detail"
//        navigationItem.backButtonTitle = self.title
        navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.pushViewController(vc, animated: true)
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
        cell.populateData(title: article.title, publisher: article.source?.name ?? "No Publisher Found", imageUrl: article.urlToImage ?? "", time: newsViewModel.changeDateToRemainTime(string: article.publishedAt), author: article.author ?? "No Author")   // add data to the cell
        
        if articles.count - indexPath.row == 5{
            newsViewModel.totalArticles == articles.count ? showToast(message: "Finish") : callNextPageAPI()
        }
         return cell
    }
}


//MARK: - Table View Delegate
extension NewsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        pushDetailVC(article: newsViewModel.articles[indexPath.row])
        return nil
    }
}


//MARK: - search VC Delegate
extension NewsViewController: UISearchControllerDelegate{
}


//MARK: - search Bar Delegate
extension NewsViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchNewsAPI(searchString: searchBar.text ?? "")
        tableView.refreshControl = refreshControl
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        if newsViewModel.searchString != ""{  // should no API call when no search happen
            searchNewsAPI(searchString: "")
        }
        tableView.refreshControl = refreshControl // had removed bcz should not refresh during search
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        tableView.refreshControl = nil   // remove refresh during search
    }
}
