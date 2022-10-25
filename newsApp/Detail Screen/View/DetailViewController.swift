//
//  DetailViewController.swift
//  newsApp
//
//  Created by manukant tyagi on 21/10/22.
//

import UIKit

class DetailViewController: UIViewController {

    //MARK: - Properties
    var detailView: DetailView!{
        guard isViewLoaded else { return nil }
        return (view as! DetailView)
    }
    var viewModel = DetailViewModel()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    //MARK: - IB Actions
    @IBAction func clickMoreButtonPressed(){
        pushWebViewController()
    }

    
    // MARK: - push web VC
    func pushWebViewController(){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        vc.urlString = viewModel.article?.url ?? ""
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //MARK: - Update UI
    func updateUI(){
        guard let detailView = detailView else { return }
        viewModel.configure(detailView)
    }
    
    
    
}
