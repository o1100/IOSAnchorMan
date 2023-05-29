//
//  searchViewController.swift
//  anchor
//
//  Created by Oliver Scott on 21/6/2022.
//

import Foundation
import UIKit
import SafariServices


class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

    private let searchVC = UISearchController(searchResultsController: nil)
    private var articles = [Article]()
    private var viewModels = [NewsTableViewCellViewModel]()

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(NewsTableViewCell.self,
                       forCellReuseIdentifier: NewsTableViewCell.identifier)
        return table
    }()
    
    @IBOutlet weak var searchTextField: UISearchBar!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        setupConstraints()
        
        view.backgroundColor = .systemBackground

        
        createSearchBar()
    }
    
    
    func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func createSearchBar(){
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else{
            return
        }
        print (text)
        
        ArticlesAPI.shared.searchArticles(with: text){ [weak self] result in         //looking at API
            switch result{
            case .success(let articles):                                 // if there are results
                self?.articles = articles
                self?.viewModels = articles.compactMap({
                    NewsTableViewCellViewModel(name: $0.source.name, title: $0.title,     //tableview needs to be added
                                           subtitle: $0.description ?? "No Description",
                                           imageURL: URL(string: $0.urlToImage ?? ""))
                })
               // break
                DispatchQueue.main.async{
                    self?.tableView.reloadData()
                    self?.searchVC.dismiss(animated: true, completion: nil)
                }
            case .failure(let error):                                       //prints error if there is one
                print(error)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    

    // table

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier,
                                                       for: indexPath)
                as? NewsTableViewCell else {
            fatalError()
        }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let viewModel = viewModels[indexPath.row]
        let article = articles[indexPath.row]
        guard let url =  URL(string: article.url ?? "") else {return}
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    

}
