//
//  ViewController.swift
//  anchor
//
//  Created by Vincent Jin on 2022/6/21.
//

import UIKit
import SafariServices

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(NewsTableViewCell.self,
                       forCellReuseIdentifier: NewsTableViewCell.identifier)
        return table
    }()
    
    
    private var viewModels = [NewsTableViewCellViewModel]()
    private var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden=false
        navigationItem.hidesBackButton = false

        title = "Breaking News"

//        self.navigationController?.navigationBar.isHidden=true
//        navigationItem.hidesBackButton = true
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        setupConstraints()

        // Do any additional setup after loading the view
        view.backgroundColor = .systemBackground
        getTopArticles()
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
    
    func getTopArticles(){
        ArticlesAPI.shared.getTopArticles{ [weak self] result in         //looking at API
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
                }
            case .failure(let error):                                       //prints error if there is one
                print(error)
            }
        }
        
    }
    
//table check vid 21:00


//search
        func searchArticles(){
    ArticlesAPI.shared.searchArticles(with: "apple"){ [weak self] result in         //looking at API
        switch result{
        case .success(let articles):                                 // if there are results
            self?.viewModels = articles.compactMap({
                NewsTableViewCellViewModel(name: $0.source.name, title: $0.title,    
                                           subtitle: $0.description ?? "No Description",
                                           imageURL: URL(string: $0.urlToImage ?? ""))
                })
            //break
                DispatchQueue.main.async{
                    self?.tableView.reloadData()
                }
        case .failure(let error):                                       //prints error if there is one
            print(error)
            }
        }
            
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
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let tableViewHeight = tableView.bounds.height
//        let cellHeight = tableViewHeight/3
//        return cellHeight
//    }
    
    
}

