//
//  ArticlesAPI.swift
//  AnchorMan
//
//  Created by Oliver Scott on 21/6/2022.
//

import Foundation

final class ArticlesAPI{                            //this class gets data from the API
    static let shared = ArticlesAPI()
    
    struct Constants {                              //URL being used for articles
        static let articles = URL(string: "https://newsapi.org/v2/top-headlines?country=au&apiKey=5ee814785a1747a5ab334edd458d6257")
        
        static let searchUrlString = "https://newsapi.org/v2/everything?sortedBy=popularity&apiKey=5ee814785a1747a5ab334edd458d6257&q="
        
        static let customSearch = "https://newsapi.org/v2/everything?q="
        
//        static let searchByTopics =
        
        static let finance = URL(string: "https://newsapi.org/v2/top-headlines?country=au&category=business&apiKey=5ee814785a1747a5ab334edd458d6257")
        
        static let sport = URL(string: "https://newsapi.org/v2/top-headlines?country=au&category=sports&apiKey=5ee814785a1747a5ab334edd458d6257")
    }
    
    private init() {}                               //instance of this class
    


    public func getTopArticles(completion: @escaping (Result<[Article], Error>) -> Void){    //gets top articles, stores them in array
        guard let url = Constants.articles else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) {data,_,error in           //creates url session
            if let error = error {                                                  //catch error
                completion(.failure(error))
            }
            else if let data = data {                                               //got data back
                do {
                    let result = try JSONDecoder().decode(response.self, from: data)
                    //print(Article.Source)
                    completion(.success(result.articles))
                }
                catch{
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    public func getFinance(completion: @escaping (Result<[Article], Error>) -> Void){    //gets top articles, stores them in array
        guard let url = Constants.finance else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) {data,_,error in           //creates url session
            if let error = error {                                                  //catch error
                completion(.failure(error))
            }
            else if let data = data {                                               //got data back
                do {
                    let result = try JSONDecoder().decode(response.self, from: data)
                    print("top finance \(result.articles.count)")
                    completion(.success(result.articles))
                }
                catch{
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    public func getSport(completion: @escaping (Result<[Article], Error>) -> Void){    //gets top articles, stores them in array
        guard let url = Constants.sport else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) {data,_,error in           //creates url session
            if let error = error {                                                  //catch error
                completion(.failure(error))
            }
            else if let data = data {                                               //got data back
                do {
                    let result = try JSONDecoder().decode(response.self, from: data)
                    print("top sports \(result.articles.count)")
                    completion(.success(result.articles))
                }
                catch{
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    
    public func searchFullArticles(with query: String, completion: @escaping (Result<[Article], Error>) -> Void){    //gets searched articles, stores them in array
        guard  !query.trimmingCharacters(in: .whitespaces).isEmpty else{
            return
        }
        print(query)
        let urlString = Constants.customSearch + query +
                    "&from=2022-06-21&sortBy=popularity&apiKey=31698936c6af46eb9c13dd385b1aec64"           //adds string to search url
        print(urlString)
        guard let url = URL(string: urlString) else {                               //protects against white spaces
            return
        }
        let task = URLSession.shared.dataTask(with: url) {data,_,error in           //creates url session
            if let error = error {                                                  //catch error
                completion(.failure(error))
            }
            else if let data = data {                                               //got data back
                do {
                    let result = try JSONDecoder().decode(response.self, from: data)
                    print("Search Articles: \(result.articles.count)")
                    completion(.success(result.articles))
                }
                catch{
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    public func searchArticles(with query: String, completion: @escaping (Result<[Article], Error>) -> Void){    //gets searched articles, stores them in array
        guard  !query.trimmingCharacters(in: .whitespaces).isEmpty else{
            return
        }
        print(query)
        let urlString = Constants.customSearch + query +
                    "&searchIn=title&from=2022-06-21&sortBy=popularity&apiKey=5ee814785a1747a5ab334edd458d6257"           //adds string to search url
        print(urlString)
        guard let url = URL(string: urlString) else {                               //protects against white spaces
            return
        }
        let task = URLSession.shared.dataTask(with: url) {data,_,error in           //creates url session
            if let error = error {                                                  //catch error
                completion(.failure(error))
            }
            else if let data = data {                                               //got data back
                do {
                    let result = try JSONDecoder().decode(response.self, from: data)
                    print("Search Articles: \(result.articles.count)")
                    completion(.success(result.articles))
                }
                catch{
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}



// structures

struct response: Codable{                               //grabbing articles
    let articles: [Article]
}

struct Article: Codable {                               //stuff to grab from article
    let source: Source
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let content: String?
    let publishedAt: String
}

struct Source: Codable {
    let id: String?
    let name: String
}

