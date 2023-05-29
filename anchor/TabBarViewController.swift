//
//  TabBarViewController.swift
//  anchor
//
//  Created by Vincent Jin on 2022/6/22.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpControllers()
        
        // Do any additional setup after loading the view.
    }
    
    private func setUpControllers(){
        let home = ViewController()
        home.title = "Breaking News"
        let search = SearchViewController()
        search.title = "Search"
        let sports = SportsViewController()
        sports.title = "Sports"
        let finance = FinanceViewController()
        finance.title = "Finance"
        
        home.navigationItem.largeTitleDisplayMode = .always
        search.navigationItem.largeTitleDisplayMode = .always
        
        
        let nav1 =  UINavigationController(rootViewController: home)
        let nav2 = UINavigationController(rootViewController: finance)
        let nav3 = UINavigationController(rootViewController: sports)
        let nav4 = UINavigationController(rootViewController: search)
        
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        nav3.navigationBar.prefersLargeTitles = true
        nav4.navigationBar.prefersLargeTitles = true

        nav1.tabBarItem = UITabBarItem(title: "Breaking News", image: UIImage(systemName: "newspaper"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Finance", image: UIImage(systemName: "briefcase"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Sports", image: UIImage(systemName: "sportscourt"), tag: 3)
        nav4.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        
        setViewControllers([nav1, nav2, nav3, nav4], animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
